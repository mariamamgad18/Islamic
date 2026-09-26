import 'package:flutter/material.dart';

class ReminderModel {
  final String title;
  final TimeOfDay time;
  final String icon;
  final Color color;
  final bool isDaily;
  bool isEnabled;

  ReminderModel({
    required this.title,
    required this.time,
    required this.icon,
    required this.color,
    required this.isDaily,
    this.isEnabled = true,
  });

  // =========================================================
  // ReminderModel -> Map
  // =========================================================

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'hour': time.hour,
      'minute': time.minute,
      'icon': icon,
      'color': color.value,
      'isDaily': isDaily,
      'isEnabled': isEnabled,
    };
  }

  // =========================================================
  // Map -> ReminderModel
  // =========================================================

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      title: map['title'] as String,

      time: TimeOfDay(hour: map['hour'] as int, minute: map['minute'] as int),

      icon: map['icon'] as String,

      color: Color(map['color'] as int),

      isDaily: map['isDaily'] as bool,

      isEnabled: map['isEnabled'] as bool? ?? true,
    );
  }
}
