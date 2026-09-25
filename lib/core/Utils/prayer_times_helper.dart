import 'package:flutter/material.dart';

class PrayerTimesHelper {
  final String name;
  final String time;
  final Duration remaining;

  PrayerTimesHelper({
    required this.name,
    required this.time,
    required this.remaining,
  });
}

PrayerTimesHelper getNextPrayer({required Map<String, String> prayers}) {
  final now = TimeOfDay.now();
  final nowMinutes = now.hour * 60 + now.minute;

  final prayerList =
      prayers.entries.map((entry) {
        final cleanTime = entry.value.split(' ').first;

        final parts = cleanTime.split(':');

        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);

        return {
          'name': entry.key,
          'time': cleanTime,
          'minutes': hour * 60 + minute,
        };
      }).toList();

  prayerList.sort(
    (a, b) => (a['minutes'] as int).compareTo(b['minutes'] as int),
  );

  for (final prayer in prayerList) {
    final prayerMinutes = prayer['minutes'] as int;

    if (prayerMinutes > nowMinutes) {
      return PrayerTimesHelper(
        name: prayer['name'] as String,
        time: prayer['time'] as String,
        remaining: Duration(minutes: prayerMinutes - nowMinutes),
      );
    }
  }

  final fajr = prayerList.first;

  final fajrMinutes = fajr['minutes'] as int;

  final difference = (24 * 60 - nowMinutes) + fajrMinutes;

  return PrayerTimesHelper(
    name: fajr['name'] as String,
    time: fajr['time'] as String,
    remaining: Duration(minutes: difference),
  );
}
