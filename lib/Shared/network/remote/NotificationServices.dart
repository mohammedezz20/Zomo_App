import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  void initialiseNotification() async {
    InitializationSettings _initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      _initializationSettings,
    );
  }

  void sendNotification({required String title, required String body}) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      '01',
      'Local notification',
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.id, channel.name,
            importance: Importance.max,
            priority: Priority.high,
            colorized: true,
            styleInformation: BigTextStyleInformation(body));
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    _flutterLocalNotificationsPlugin.show(
      payload: 'Join_Screen',
      0,
      title,
      body,
      notificationDetails,
    );
  }

  // Future<void> scheduleNotification() async {
  //   const androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'channel id', 'channel name', channelDescription:'channel description',
  //       importance: Importance.max, priority: Priority.high);
  //
  //   const platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //   );
  //
  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'Scheduled Notification Title',
  //       'Scheduled Notification Body',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       platformChannelSpecifics,
  //       uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime);
  // }
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required body,
    required days,
    required hour,
    required minutes,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local)
          .add(Duration(days: days, hours: hour, minutes: minutes)),
      NotificationDetails(
        // Android details
        android: AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          channelDescription: "ashwin",
          importance: Importance.max,
          priority: Priority.max,
          styleInformation: BigTextStyleInformation(body),
        ),
        // iOS details
      ),
      // Type of time interpretation
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle:
          true, //To show notification even when the app is closed
    );
  }
}
