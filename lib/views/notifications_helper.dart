import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uptodo/views/focus_logic.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void showFocusModeNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
    ongoing: true,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Focus Mode',
    'Time elapsed: $formattedTime',
    platformChannelSpecifics,
    payload: 'item x',
  );
}
