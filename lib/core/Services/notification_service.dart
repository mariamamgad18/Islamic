import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // =========================================================
  // REMINDER CHANNEL
  // =========================================================

  static const AndroidNotificationChannel reminderChannel =
      AndroidNotificationChannel(
        'reminders_channel',
        'التذكيرات',
        description: 'تنبيهات التذكيرات الشخصية',
        importance: Importance.high,
        playSound: false,
        enableVibration: false,
      );

  // =========================================================
  // INIT
  // =========================================================

  static Future<void> init() async {
    // =======================================================
    // TIMEZONE
    // =======================================================

    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));

    // =======================================================
    // ANDROID INITIALIZATION
    // =======================================================

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // =======================================================
    // ANDROID PLUGIN
    // =======================================================

    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    // =======================================================
    // CREATE REMINDER CHANNEL
    // =======================================================

    await androidPlugin?.createNotificationChannel(reminderChannel);

    // =======================================================
    // PERMISSIONS
    // =======================================================

    await androidPlugin?.requestNotificationsPermission();

    // Exact alarms are still needed for reminders because
    // scheduleReminder() uses exactAllowWhileIdle.
    await androidPlugin?.requestExactAlarmsPermission();
  }

  // =========================================================
  // SCHEDULE REMINDER
  // =========================================================

  static Future<void> scheduleReminder({
    required int id,
    required String title,
    required TimeOfDay time,
    required bool isDaily,
  }) async {
    try {
      final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

      tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      // =====================================================
      // IF TIME HAS PASSED TODAY
      // =====================================================

      if (!scheduledDate.isAfter(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // =====================================================
      // SCHEDULE
      // =====================================================

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        '',
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            reminderChannel.id,
            reminderChannel.name,
            channelDescription: reminderChannel.description,
            importance: Importance.high,
            priority: Priority.high,
            playSound: false,
            enableVibration: false,
            category: AndroidNotificationCategory.reminder,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: isDaily ? DateTimeComponents.time : null,
      );

      debugPrint('==========================================');

      debugPrint('REMINDER SCHEDULED');

      debugPrint('ID: $id');

      debugPrint('TITLE: $title');

      debugPrint('TIME: ${time.hour}:${time.minute}');

      debugPrint('DAILY: $isDaily');

      debugPrint('SCHEDULED DATE: $scheduledDate');

      debugPrint('==========================================');
    } catch (e, stackTrace) {
      debugPrint('ERROR SCHEDULING REMINDER: $e');

      debugPrint('STACK TRACE: $stackTrace');
    }
  }

  // =========================================================
  // CANCEL REMINDER
  // =========================================================

  static Future<void> cancelReminder({required int id}) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);

      debugPrint('REMINDER CANCELLED: $id');
    } catch (e, stackTrace) {
      debugPrint('ERROR CANCELLING REMINDER: $e');

      debugPrint('STACK TRACE: $stackTrace');
    }
  }

  // =========================================================
  // CANCEL ALL REMINDERS
  // =========================================================

  static Future<void> cancelAllReminders(List<int> reminderIds) async {
    try {
      for (final int id in reminderIds) {
        await flutterLocalNotificationsPlugin.cancel(id);
      }

      debugPrint('ALL REMINDERS CANCELLED');
    } catch (e, stackTrace) {
      debugPrint('ERROR CANCELLING ALL REMINDERS: $e');

      debugPrint('STACK TRACE: $stackTrace');
    }
  }

  // =========================================================
  // CHECK NOTIFICATIONS
  // =========================================================

  static Future<bool> areNotificationsEnabled() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    return await androidPlugin?.areNotificationsEnabled() ?? false;
  }

  // =========================================================
  // REQUEST NOTIFICATION PERMISSION
  // =========================================================

  static Future<bool> requestNotificationPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    final bool? result = await androidPlugin?.requestNotificationsPermission();

    return result ?? false;
  }

  // =========================================================
  // OPEN NOTIFICATION SETTINGS
  // =========================================================

  static Future<void> openNotificationSettings() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    await androidPlugin?.requestNotificationsPermission();
  }
}
