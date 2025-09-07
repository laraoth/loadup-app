// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:loadup/core/notification/firebase_messaging_service.dart';

// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({super.key});

//   @override
//   State<NotificationsPage> createState() => _NotificationsPageState();
// }

// class _NotificationsPageState extends State<NotificationsPage> {
//   List<Map<String, dynamic>> _notifications = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadNotifications();
//   }

//   Future<void> _loadNotifications() async {
//     final notifs = await NotificationsArchive.getNotifications();
//     setState(() {
//       _notifications = notifs.reversed.toList(); // newest first
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notifications"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _loadNotifications,
//           ),
//         ],
//       ),
//       body: _notifications.isEmpty
//           ? const Center(child: Text("No notifications yet"))
//           : ListView.builder(
//               itemCount: _notifications.length,
//               itemBuilder: (context, index) {
//                 final notif = _notifications[index];
//                 return Card(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   child: ListTile(
//                     title: Text(
//                       notif["title"] ?? "No Title",
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(notif["body"] ?? ""),
//                     trailing: Text(
//                       (notif["time"] as String).substring(0, 16),
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (_) => AlertDialog(
//                           title: Text(notif["title"] ?? ""),
//                           content: Text(
//                             "📩 ${notif["body"]}\n\nDATA: ${notif["data"]}",
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text("Close"),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
