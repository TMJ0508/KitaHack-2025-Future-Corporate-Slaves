import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('app_icon');
    const InitializationSettings settings = InitializationSettings(android: androidSettings);
    await _notifications.initialize(settings);
  }

  Future<void> scheduleNotification(String title, String body, DateTime scheduledTime) async {
    await _notifications.schedule(
      0,
      title,
      body,
      scheduledTime,
      NotificationDetails(
        android: AndroidNotificationDetails('channel_id', 'Reminders', importance: Importance.max),
      ),
    );
  }
}