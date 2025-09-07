import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:loadup/core/networking/crud_dio.dart';
import 'package:loadup/core/networking/app_link_url.dart';
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

    FirebaseMessaging.onMessage.listen((message) {
      final notif = message.notification;
      if (notif != null) {
        _notifs.showNotification(
          id: notif.hashCode,
          title: notif.title,
          body: notif.body,
          payload: message.data.toString(),
        );
      }
      log("📩 onMessage: ${message.data}");
    });

    final token = await messaging.getToken();
    if (token != null) {
      await _sendTokenToBackend(token);
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
  log("📩 رسالة بالخلفية: ${message.messageId}");
}
