import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/app_link_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../firebase_options.dart';
import 'notification_service.dart';

class FirebaseMessagingService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final NotificationService _notifs;
  final CrudDio _crudDio;

  FirebaseMessagingService(this._notifs, this._crudDio);

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await messaging.requestPermission(alert: true, badge: true, sound: true);

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((message) async {
      final title =
          message.notification?.title ?? message.data['title'] ?? 'إشعار';
      final body = message.notification?.body ?? message.data['body'] ?? '';

      _notifs.showNotification(
        id: message.hashCode,
        title: title,
        body: body,
        payload: message.data.toString(),
      );

      await NotificationsArchive.saveNotification(title, body, message.data);

      log("📩 onMessage: ${message.data}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      log("📩 Notification clicked: ${message.data}");

      final title =
          message.notification?.title ?? message.data['title'] ?? 'إشعار';
      final body = message.notification?.body ?? message.data['body'] ?? '';
      await NotificationsArchive.saveNotification(title, body, message.data);

      //
    });

    final token = await messaging.getToken();
    if (token != null) {
      await _sendTokenToBackend(token);
      log("🔑 FCM Token: $token");
    }

    messaging.onTokenRefresh.listen((token) async {
      await _sendTokenToBackend(token);
    });

    await messaging.subscribeToTopic("all");
  }

  Future<void> _sendTokenToBackend(String token) async {
    final result = await _crudDio.dioPostMethod(
      endPoint: "/api/devices",
      data: {"token": token, "platform": "android"},
      token: null,
      queryParameters: {},
    );

    result.fold(
      (fail) => log("❌ Error sending token: ${fail.message}"),
      (res) => log("✅ Token sent: ${res['status'] ?? '200'}"),
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final title = message.notification?.title ?? message.data['title'] ?? 'إشعار';
  final body = message.notification?.body ?? message.data['body'] ?? '';

  await NotificationsArchive.saveNotification(title, body, message.data);

  log("📩 رسالة بالخلفية: ${message.messageId}");
}

/// 🗂 أرشيف الإشعارات
class NotificationsArchive {
  static const String key = "notifications_archive";

  static Future<void> saveNotification(
      String title, String body, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(key) ?? [];
    final notif = jsonEncode({
      "title": title,
      "body": body,
      "data": data,
      "time": DateTime.now().toIso8601String(),
    });
    existing.add(notif);
    await prefs.setStringList(key, existing);
  }

  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(key) ?? [];
    return existing
        .map((e) => jsonDecode(e))
        .cast<Map<String, dynamic>>()
        .toList();
  }
}
