import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void showFocusModeNotification(formattedTime) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // Configure notification details (icon, sound, etc.)
  // ...

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    // ... (Your notification channel configuration)
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
    ongoing: true,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Focus Mode',
    'Time elapsed: $formattedTime',
    platformChannelSpecifics,
    payload: 'item x',
  );
}


