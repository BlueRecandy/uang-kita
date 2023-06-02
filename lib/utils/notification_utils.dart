import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationUtils {
  static FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidInitializationSettings _initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  static const InitializationSettings _initializationSettings =
      InitializationSettings(android: _initializationSettingsAndroid);

  static Future<void> initialize() {
    return notificationsPlugin.initialize(_initializationSettings);
  }

  static int _generateNotificationId() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  static NotificationDetails prepareNotification(
      {required String channelId,
      required String channelName,
      required String channelDescription,
      Importance importance = Importance.max,
      Priority priority = Priority.high,
      String ticker = 'ticker'}) {
    final androidNotificationDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
      ticker: ticker,
    );

    return NotificationDetails(android: androidNotificationDetails);
  }

  static Future<void> scheduleNotification(
      NotificationDetails notificationDetails, DateTime sendAt,
      {required String title,
      required String body,
      String? payload,
      AndroidScheduleMode androidScheduleMode =
          AndroidScheduleMode.inexact}) async {
    final id = _generateNotificationId();

    final scheduledDate = tz.TZDateTime.from(sendAt, tz.local);

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      payload: payload,
      androidScheduleMode: androidScheduleMode,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> showNotification(
    NotificationDetails notificationDetails, {
    required String title,
    required String body,
    String? payload,
  }) async {
    final id = _generateNotificationId();
    await notificationsPlugin.show(id, title, body, notificationDetails,
        payload: payload);
  }
}
