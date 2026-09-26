import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'reminder_model.dart';

class ReminderStorage {
  static const String _remindersKey = 'reminders';

  // =========================================================
  // SAVE REMINDERS
  // =========================================================

  static Future<void> saveReminders(List<ReminderModel> reminders) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String> remindersJson =
        reminders.map((reminder) {
          return jsonEncode(reminder.toMap());
        }).toList();

    await prefs.setStringList(_remindersKey, remindersJson);
  }

  // =========================================================
  // GET REMINDERS
  // =========================================================

  static Future<List<ReminderModel>> getReminders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? remindersJson = prefs.getStringList(_remindersKey);

    if (remindersJson == null || remindersJson.isEmpty) {
      return [];
    }

    return remindersJson.map((reminderJson) {
      final Map<String, dynamic> map =
          jsonDecode(reminderJson) as Map<String, dynamic>;

      return ReminderModel.fromMap(map);
    }).toList();
  }

  // =========================================================
  // CLEAR REMINDERS
  // =========================================================

  static Future<void> clearReminders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(_remindersKey);
  }
}
