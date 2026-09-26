import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:islamic/Domain/use_case/prayer_times/prayer_times_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AthanScheduler {
  AthanScheduler({required this.prayerTimesUseCase});

  final PrayerTimesUseCase prayerTimesUseCase;

  static const MethodChannel _channel = MethodChannel(
    'athan_scheduler_channel',
  );

  // =========================================================
  // MASTER ATHAN STATE
  // =========================================================

  static const String athanMasterKey = 'athan_master_enabled';

  // Default = ON
  static final ValueNotifier<bool> athanEnabledNotifier = ValueNotifier<bool>(
    true,
  );

  // =========================================================
  // NUMBER OF DAYS TO SCHEDULE
  // =========================================================

  static const int scheduledDays = 7;

  // =========================================================
  // PRAYER IDS
  // =========================================================

  static const Map<String, int> prayerBaseIds = {
    'fajr': 1,
    'dhuhr': 2,
    'asr': 3,
    'maghrib': 4,
    'isha': 5,
  };

  // =========================================================
  // PREF KEYS
  // =========================================================

  static const Map<String, int> preferenceIds = {
    'fajr': 1001,
    'dhuhr': 1002,
    'asr': 1003,
    'maghrib': 1004,
    'isha': 1005,
  };

  // =========================================================
  // INITIALIZE MASTER STATE
  // =========================================================

  Future<bool> initializeAthanMasterState() async {
    final prefs = await SharedPreferences.getInstance();

    final enabled = prefs.getBool(athanMasterKey) ?? true;

    athanEnabledNotifier.value = enabled;

    /*
     * IMPORTANT:
     *
     * Keep Android native state synchronized with
     * Flutter SharedPreferences.
     *
     * This allows AthanReceiver to make the decision
     * even when Flutter is not running.
     */
    await _setNativeMasterState(enabled);

    return enabled;
  }

  // =========================================================
  // GET MASTER STATE
  // =========================================================

  Future<bool> isAthanEnabled() async {
    final prefs = await SharedPreferences.getInstance();

    final enabled = prefs.getBool(athanMasterKey) ?? true;

    athanEnabledNotifier.value = enabled;

    await _setNativeMasterState(enabled);

    return enabled;
  }

  // =========================================================
  // SET MASTER STATE
  // =========================================================

  Future<void> setAthanEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(athanMasterKey, enabled);

    athanEnabledNotifier.value = enabled;

    /*
     * Update native state FIRST.
     *
     * This prevents a race where an alarm fires
     * at exactly the same moment the user turns
     * the master switch OFF.
     */
    await _setNativeMasterState(enabled);

    debugPrint('MASTER ATHAN => $enabled');

    // =======================================================
    // MASTER OFF
    // =======================================================

    if (!enabled) {
      await cancelAll();

      for (final prayerKey in prayerBaseIds.keys) {
        final preferenceId = preferenceIds[prayerKey]!;

        await prefs.setBool('azan_enabled_$preferenceId', false);
      }

      debugPrint('MASTER ATHAN OFF => ALL PRAYERS DISABLED');

      return;
    }

    // =======================================================
    // MASTER ON
    // =======================================================

    for (final prayerKey in prayerBaseIds.keys) {
      final preferenceId = preferenceIds[prayerKey]!;

      await prefs.setBool('azan_enabled_$preferenceId', true);
    }

    debugPrint('MASTER ATHAN ON => ALL PRAYERS ENABLED');
  }

  // =========================================================
  // SET NATIVE MASTER STATE
  // =========================================================

  Future<void> _setNativeMasterState(bool enabled) async {
    try {
      await _channel.invokeMethod('setNativeAthanMasterEnabled', {
        'enabled': enabled,
      });

      debugPrint('NATIVE MASTER ATHAN => $enabled');
    } catch (e) {
      debugPrint('ERROR SETTING NATIVE MASTER STATE: $e');
    }
  }

  // =========================================================
  // CHECK FULL SCREEN INTENT PERMISSION
  // =========================================================

  Future<bool> canUseFullScreenIntent() async {
    try {
      final result = await _channel.invokeMethod<bool>(
        'canUseFullScreenIntent',
      );

      return result ?? false;
    } catch (e) {
      debugPrint('ERROR CHECKING FULL SCREEN INTENT: $e');

      return false;
    }
  }

  // =========================================================
  // OPEN FULL SCREEN INTENT SETTINGS
  // =========================================================

  Future<void> openFullScreenIntentSettings() async {
    try {
      await _channel.invokeMethod('openFullScreenIntentSettings');
    } catch (e) {
      debugPrint('ERROR OPENING FULL SCREEN INTENT SETTINGS: $e');
    }
  }

  // =========================================================
  // SCHEDULE ALL ENABLED PRAYERS
  // =========================================================

  Future<void> scheduleNextDays({
    required double latitude,
    required double longitude,
    int method = 5,
    int days = scheduledDays,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final masterEnabled = prefs.getBool(athanMasterKey) ?? true;

      athanEnabledNotifier.value = masterEnabled;

      await _setNativeMasterState(masterEnabled);

      if (!masterEnabled) {
        debugPrint('MASTER ATHAN IS OFF => NO SCHEDULING');

        return;
      }

      final now = DateTime.now();

      debugPrint('========================================');

      debugPrint('START SCHEDULING ATHAN');

      debugPrint('LATITUDE: $latitude');

      debugPrint('LONGITUDE: $longitude');

      debugPrint('DAYS: $days');

      debugPrint('MASTER ATHAN: $masterEnabled');

      debugPrint('========================================');

      // =====================================================
      // CHECK ENABLED PRAYERS
      // =====================================================

      final enabledPrayers = <String>[];

      for (final prayerKey in prayerBaseIds.keys) {
        final preferenceId = preferenceIds[prayerKey]!;

        final enabled = prefs.getBool('azan_enabled_$preferenceId') ?? true;

        if (enabled) {
          enabledPrayers.add(prayerKey);
        }
      }

      if (enabledPrayers.isEmpty) {
        debugPrint('NO ENABLED ATHAN PRAYERS');

        return;
      }

      debugPrint('ENABLED PRAYERS: $enabledPrayers');

      // =====================================================
      // GET LOCALIZED PRAYER NAMES
      // =====================================================

      final prayerNames = <String, String>{};

      for (final prayerKey in enabledPrayers) {
        final name =
            prefs.getString('azan_prayer_name_$prayerKey') ??
            _getDefaultPrayerName(prayerKey);

        prayerNames[prayerKey] = name;
      }

      // =====================================================
      // LOOP THROUGH DAYS
      // =====================================================

      for (int dayIndex = 0; dayIndex < days; dayIndex++) {
        final currentMasterState = prefs.getBool(athanMasterKey) ?? true;

        if (!currentMasterState) {
          debugPrint('MASTER ATHAN TURNED OFF DURING SCHEDULING');

          await _setNativeMasterState(false);

          return;
        }

        final date = now.add(Duration(days: dayIndex));

        final dateString = _formatDate(date);

        debugPrint('FETCHING PRAYER TIMES FOR: $dateString');

        try {
          final result = await prayerTimesUseCase.invoke(
            date: dateString,
            latitude: latitude,
            longitude: longitude,
            method: method,
          );

          final timings = result.data.timings;

          // ===================================================
          // SCHEDULE EACH ENABLED PRAYER
          // ===================================================

          for (final prayerKey in enabledPrayers) {
            final time = _getPrayerTime(prayerKey, timings);

            if (time == null) {
              debugPrint('NO TIME FOR $prayerKey');

              continue;
            }

            final prayerDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );

            if (!prayerDateTime.isAfter(now)) {
              debugPrint(
                'SKIP PAST TIME: '
                '$prayerKey $prayerDateTime',
              );

              continue;
            }

            final athanId = _generateAthanId(date, prayerKey);

            await _scheduleNativeAthan(
              athanId: athanId,
              prayerName: prayerNames[prayerKey]!,
              prayerKey: prayerKey,
              timestamp: prayerDateTime.millisecondsSinceEpoch,
            );

            debugPrint(
              'SCHEDULED: '
              '$prayerKey | '
              '$prayerDateTime | '
              'ID: $athanId',
            );
          }
        } catch (e, stackTrace) {
          debugPrint('ERROR FETCHING DATE $dateString: $e');

          debugPrint('$stackTrace');
        }
      }

      debugPrint('========================================');

      debugPrint('ATHAN SCHEDULING FINISHED');

      debugPrint('========================================');
    } catch (e, stackTrace) {
      debugPrint('ERROR IN ATHAN SCHEDULER: $e');

      debugPrint('$stackTrace');
    }
  }

  // =========================================================
  // SCHEDULE ONE NATIVE ALARM
  // =========================================================

  Future<void> _scheduleNativeAthan({
    required int athanId,
    required String prayerName,
    required String prayerKey,
    required int timestamp,
  }) async {
    try {
      await _channel.invokeMethod('scheduleAthan', {
        'athanId': athanId,
        'prayerName': prayerName,
        'prayerKey': prayerKey,
        'timestamp': timestamp,
      });
    } on PlatformException catch (e) {
      debugPrint(
        'NATIVE ATHAN ERROR: '
        '${e.code} - ${e.message}',
      );
    } catch (e) {
      debugPrint('ERROR SCHEDULING NATIVE ATHAN: $e');
    }
  }

  // =========================================================
  // CANCEL ONE PRAYER
  // =========================================================

  Future<void> cancelPrayer({required String prayerKey}) async {
    try {
      await _channel.invokeMethod('cancelAthanPrayer', {
        'prayerKey': prayerKey,
      });

      debugPrint('CANCELLED ALL ATHAN FOR: $prayerKey');
    } catch (e, stackTrace) {
      debugPrint('ERROR CANCELLING $prayerKey: $e');

      debugPrint('$stackTrace');
    }
  }

  // =========================================================
  // CANCEL ALL ATHAN
  // =========================================================

  Future<void> cancelAll() async {
    try {
      await _channel.invokeMethod('cancelAllAthan');

      debugPrint('ALL ATHAN ALARMS CANCELLED');
    } catch (e, stackTrace) {
      debugPrint('ERROR CANCELLING ALL ATHAN: $e');

      debugPrint('$stackTrace');
    }
  }

  // =========================================================
  // CHECK EXACT ALARM PERMISSION
  // =========================================================

  Future<bool> canScheduleExactAlarms() async {
    try {
      final result = await _channel.invokeMethod<bool>(
        'canScheduleExactAlarms',
      );

      return result ?? false;
    } catch (e) {
      debugPrint('ERROR CHECKING EXACT ALARM PERMISSION: $e');

      return false;
    }
  }

  // =========================================================
  // OPEN EXACT ALARM SETTINGS
  // =========================================================

  Future<void> openExactAlarmSettings() async {
    try {
      await _channel.invokeMethod('openExactAlarmSettings');
    } catch (e) {
      debugPrint('ERROR OPENING EXACT ALARM SETTINGS: $e');
    }
  }

  // =========================================================
  // FORMAT DATE
  // =========================================================

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  // =========================================================
  // GET PRAYER TIME
  // =========================================================

  _PrayerTime? _getPrayerTime(String prayerKey, dynamic timings) {
    String? value;

    switch (prayerKey) {
      case 'fajr':
        value = timings.fajr;
        break;

      case 'dhuhr':
        value = timings.dhuhr;
        break;

      case 'asr':
        value = timings.asr;
        break;

      case 'maghrib':
        value = timings.maghrib;
        break;

      case 'isha':
        value = timings.isha;
        break;
    }

    if (value == null || value.trim().isEmpty) {
      return null;
    }

    try {
      final cleanValue = value.trim().split(' ').first;

      final parts = cleanValue.split(':');

      if (parts.length < 2) {
        return null;
      }

      final hour = int.parse(parts[0]);

      final minute = int.parse(parts[1]);

      return _PrayerTime(hour: hour, minute: minute);
    } catch (e) {
      debugPrint('ERROR PARSING TIME: $value');

      return null;
    }
  }

  // =========================================================
  // GENERATE UNIQUE ID
  // =========================================================

  int _generateAthanId(DateTime date, String prayerKey) {
    final baseId = prayerBaseIds[prayerKey]!;

    return (date.year * 10000 + date.month * 100 + date.day) * 10 + baseId;
  }

  // =========================================================
  // DEFAULT PRAYER NAME
  // =========================================================

  String _getDefaultPrayerName(String prayerKey) {
    switch (prayerKey) {
      case 'fajr':
        return 'الفجر';

      case 'dhuhr':
        return 'الظهر';

      case 'asr':
        return 'العصر';

      case 'maghrib':
        return 'المغرب';

      case 'isha':
        return 'العشاء';

      default:
        return prayerKey;
    }
  }
}

// ===========================================================
// PRIVATE TIME CLASS
// ===========================================================

class _PrayerTime {
  final int hour;

  final int minute;

  const _PrayerTime({required this.hour, required this.minute});
}
