import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:islamic/Domain/use_case/prayer_times/prayer_times_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AthanScheduler {
  AthanScheduler({
    required this.prayerTimesUseCase,
  });

  final PrayerTimesUseCase prayerTimesUseCase;

  static const MethodChannel _channel = MethodChannel(
    'athan_scheduler_channel',
  );

  // =========================================================
  // SHARED PREFERENCES KEYS
  // =========================================================

  static const String athanMasterKey =
      'athan_master_enabled';

  static const String prayerEnabledPrefix =
      'azan_enabled_';

  static const String prayerNamePrefix =
      'azan_prayer_name_';

  // =========================================================
  // MASTER ATHAN NOTIFIER
  // =========================================================

  static final ValueNotifier<bool> athanEnabledNotifier =
  ValueNotifier<bool>(false);

  // =========================================================
  // SCHEDULE CONFIG
  // =========================================================

  static const int scheduledDays = 7;

  // =========================================================
  // PRAYER BASE IDS
  // =========================================================

  static const Map<String, int> prayerBaseIds = {
    'fajr': 1,
    'dhuhr': 2,
    'asr': 3,
    'maghrib': 4,
    'isha': 5,
  };

  // =========================================================
  // PRAYER PREFERENCE IDS
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

    final enabled =
        prefs.getBool(athanMasterKey) ?? false;

    athanEnabledNotifier.value = enabled;

    await _setNativeMasterState(enabled);

    debugPrint(
      'INITIAL ATHAN MASTER STATE => $enabled',
    );

    return enabled;
  }

  // =========================================================
  // GET MASTER STATE
  // =========================================================

  Future<bool> isAthanEnabled() async {
    final prefs = await SharedPreferences.getInstance();

    final enabled =
        prefs.getBool(athanMasterKey) ?? false;

    athanEnabledNotifier.value = enabled;

    await _setNativeMasterState(enabled);

    return enabled;
  }

  // =========================================================
  // SET MASTER STATE
  //
  // IMPORTANT:
  //
  // Master ON:
  //     Does NOT enable any prayer.
  //
  // Master OFF:
  //     Disables every prayer and cancels all alarms.
  //
  // =========================================================

  Future<void> setAthanEnabled(bool enabled,) async {
    final prefs =
    await SharedPreferences.getInstance();

    // Save master state
    await prefs.setBool(
      athanMasterKey,
      enabled,
    );

    athanEnabledNotifier.value = enabled;

    // Tell Android native side
    await _setNativeMasterState(enabled);

    debugPrint(
      'MASTER ATHAN => $enabled',
    );

    // =======================================================
    // MASTER OFF
    // =======================================================

    if (!enabled) {
      // Cancel every scheduled alarm
      await cancelAll();

      // Disable every prayer
      for (final prayerKey
      in prayerBaseIds.keys) {
        final preferenceId =
        preferenceIds[prayerKey]!;

        await prefs.setBool(
          '$prayerEnabledPrefix$preferenceId',
          false,
        );
      }

      debugPrint(
        'MASTER OFF => ALL PRAYERS DISABLED',
      );

      return;
    }

    // =======================================================
    // MASTER ON
    // =======================================================

    // IMPORTANT:
    //
    // We intentionally DO NOT enable all prayers here.
    //
    // The user must manually enable Fajr,
    // Dhuhr, Asr, Maghrib or Isha.
    //
    debugPrint(
      'MASTER ON => PRAYER STATES PRESERVED',
    );
  }

  // =========================================================
  // SET INDIVIDUAL PRAYER
  //
  // This is the main method that PrayerTimesScreen
  // should use.
  //
  // Example:
  //
  // await setPrayerEnabled(
  //   prayerKey: 'fajr',
  //   enabled: true,
  // );
  //
  // =========================================================

  Future<void> setPrayerEnabled({
    required String prayerKey,
    required bool enabled,
    String? prayerName,
  }) async {
    // Validate prayer
    if (!prayerBaseIds.containsKey(prayerKey)) {
      debugPrint(
        'INVALID PRAYER KEY => $prayerKey',
      );

      return;
    }

    final prefs =
    await SharedPreferences.getInstance();

    final preferenceId =
    preferenceIds[prayerKey]!;

    // =======================================================
    // MASTER MUST BE ON
    // =======================================================

    final masterEnabled =
        prefs.getBool(athanMasterKey) ?? false;

    if (!masterEnabled) {
      // Master is OFF.
      // Do not allow individual prayer activation.
      //
      // We also make sure the prayer remains disabled.

      await prefs.setBool(
        '$prayerEnabledPrefix$preferenceId',
        false,
      );

      debugPrint(
        'CANNOT ENABLE $prayerKey => MASTER ATHAN IS OFF',
      );

      return;
    }

    // =======================================================
    // SAVE PRAYER STATE
    // =======================================================

    await prefs.setBool(
      '$prayerEnabledPrefix$preferenceId',
      enabled,
    );

    // Save prayer name if supplied
    if (prayerName != null &&
        prayerName
            .trim()
            .isNotEmpty) {
      await prefs.setString(
        '$prayerNamePrefix$prayerKey',
        prayerName,
      );
    }

    debugPrint(
      'PRAYER $prayerKey => $enabled',
    );

    // =======================================================
    // PRAYER OFF
    // =======================================================

    if (!enabled) {
      await cancelPrayer(
        prayerKey: prayerKey,
      );

      return;
    }

    // =======================================================
    // PRAYER ON
    //
    // We don't schedule here because scheduling requires
    // location and prayer times.
    //
    // PrayerTimesScreen should call scheduleNextDays()
    // after changing the state.
    // =======================================================

    debugPrint(
      'PRAYER $prayerKey ENABLED',
    );
  }

  // =========================================================
  // GET INDIVIDUAL PRAYER STATE
  // =========================================================

  Future<bool> isPrayerEnabled(String prayerKey,) async {
    if (!prayerBaseIds.containsKey(prayerKey)) {
      return false;
    }

    final prefs =
    await SharedPreferences.getInstance();

    final preferenceId =
    preferenceIds[prayerKey]!;

    return prefs.getBool(
      '$prayerEnabledPrefix$preferenceId',
    ) ??
        false;
  }

  // =========================================================
  // GET ALL PRAYER STATES
  // =========================================================

  Future<Map<String, bool>>
  getPrayerStates() async {
    final prefs =
    await SharedPreferences.getInstance();

    final states = <String, bool>{};

    for (final prayerKey
    in prayerBaseIds.keys) {
      final preferenceId =
      preferenceIds[prayerKey]!;

      states[prayerKey] =
          prefs.getBool(
            '$prayerEnabledPrefix$preferenceId',
          ) ??
              false;
    }

    return states;
  }

  // =========================================================
  // ENABLED PRAYERS
  // =========================================================

  Future<List<String>>
  getEnabledPrayers() async {
    final prefs =
    await SharedPreferences.getInstance();

    final enabledPrayers =
    <String>[];

    for (final prayerKey
    in prayerBaseIds.keys) {
      final preferenceId =
      preferenceIds[prayerKey]!;

      final enabled =
          prefs.getBool(
            '$prayerEnabledPrefix$preferenceId',
          ) ??
              false;

      if (enabled) {
        enabledPrayers.add(
          prayerKey,
        );
      }
    }

    return enabledPrayers;
  }

  // =========================================================
  // NATIVE MASTER STATE
  // =========================================================

  Future<void> _setNativeMasterState(bool enabled,) async {
    try {
      await _channel.invokeMethod(
        'setNativeAthanMasterEnabled',
        {
          'enabled': enabled,
        },
      );

      debugPrint(
        'NATIVE MASTER ATHAN => $enabled',
      );
    } catch (e) {
      debugPrint(
        'ERROR SETTING NATIVE MASTER STATE: $e',
      );
    }
  }

  // =========================================================
  // FULL SCREEN INTENT
  // =========================================================

  Future<bool> canUseFullScreenIntent() async {
    try {
      final result =
      await _channel.invokeMethod<bool>(
        'canUseFullScreenIntent',
      );

      return result ?? false;
    } catch (e) {
      debugPrint(
        'ERROR CHECKING FULL SCREEN INTENT: $e',
      );

      return false;
    }
  }

  Future<void>
  openFullScreenIntentSettings() async {
    try {
      await _channel.invokeMethod(
        'openFullScreenIntentSettings',
      );
    } catch (e) {
      debugPrint(
        'ERROR OPENING FULL SCREEN INTENT SETTINGS: $e',
      );
    }
  }

  // =========================================================
  // SCHEDULE NEXT DAYS
  // =========================================================

  Future<void> scheduleNextDays({
    required double latitude,
    required double longitude,
    int method = 5,
    int days = scheduledDays,
  }) async {
    try {
      final prefs =
      await SharedPreferences.getInstance();

      // =====================================================
      // MASTER STATE
      // =====================================================

      final masterEnabled =
          prefs.getBool(athanMasterKey) ?? false;

      athanEnabledNotifier.value =
          masterEnabled;

      await _setNativeMasterState(
        masterEnabled,
      );

      // =====================================================
      // MASTER OFF
      // =====================================================

      if (!masterEnabled) {
        debugPrint(
          'MASTER ATHAN OFF => NO SCHEDULING',
        );

        return;
      }

      final now = DateTime.now();

      // =====================================================
      // GET ONLY ENABLED PRAYERS
      // =====================================================

      final enabledPrayers =
      <String>[];

      for (final prayerKey
      in prayerBaseIds.keys) {
        final preferenceId =
        preferenceIds[prayerKey]!;

        final enabled =
            prefs.getBool(
              '$prayerEnabledPrefix$preferenceId',
            ) ??
                false;

        if (enabled) {
          enabledPrayers.add(
            prayerKey,
          );
        }
      }

      // =====================================================
      // NOTHING ENABLED
      // =====================================================

      if (enabledPrayers.isEmpty) {
        debugPrint(
          'NO ENABLED ATHAN PRAYERS => NOTHING TO SCHEDULE',
        );

        return;
      }

      debugPrint(
        'ENABLED PRAYERS => $enabledPrayers',
      );

      // =====================================================
      // GET PRAYER NAMES
      // =====================================================

      final prayerNames =
      <String, String>{};

      for (final prayerKey
      in enabledPrayers) {
        final name =
            prefs.getString(
              '$prayerNamePrefix$prayerKey',
            ) ??
                _getDefaultPrayerName(
                  prayerKey,
                );

        prayerNames[prayerKey] = name;
      }

      // =====================================================
      // SCHEDULE DAYS
      // =====================================================

      for (
      int dayIndex = 0;
      dayIndex < days;
      dayIndex++
      ) {
        // ===================================================
        // CHECK MASTER AGAIN
        // ===================================================

        final currentMasterState =
            prefs.getBool(
              athanMasterKey,
            ) ??
                false;

        if (!currentMasterState) {
          debugPrint(
            'MASTER TURNED OFF DURING SCHEDULING',
          );

          await _setNativeMasterState(
            false,
          );

          return;
        }

        // ===================================================
        // CURRENT DATE
        // ===================================================

        final date = now.add(
          Duration(
            days: dayIndex,
          ),
        );

        final dateString =
        _formatDate(date);

        try {
          // =================================================
          // GET PRAYER TIMES
          // =================================================

          final result =
          await prayerTimesUseCase.invoke(
            date: dateString,
            latitude: latitude,
            longitude: longitude,
            method: method,
          );

          final timings =
              result.data.timings;

          // =================================================
          // SCHEDULE ENABLED PRAYERS
          // =================================================

          for (final prayerKey
          in enabledPrayers) {
            // -----------------------------------------------
            // CHECK MASTER
            // -----------------------------------------------

            final masterStillEnabled =
                prefs.getBool(
                  athanMasterKey,
                ) ??
                    false;

            if (!masterStillEnabled) {
              debugPrint(
                'MASTER OFF => STOP SCHEDULING',
              );

              return;
            }

            // -----------------------------------------------
            // CHECK PRAYER STATE
            // -----------------------------------------------

            final preferenceId =
            preferenceIds[prayerKey]!;

            final prayerStillEnabled =
                prefs.getBool(
                  '$prayerEnabledPrefix$preferenceId',
                ) ??
                    false;

            if (!prayerStillEnabled) {
              debugPrint(
                '$prayerKey DISABLED => SKIP',
              );

              continue;
            }

            // -----------------------------------------------
            // GET TIME
            // -----------------------------------------------

            final time =
            _getPrayerTime(
              prayerKey,
              timings,
            );

            if (time == null) {
              debugPrint(
                'NO TIME FOR $prayerKey',
              );

              continue;
            }

            // -----------------------------------------------
            // CREATE DATETIME
            // -----------------------------------------------

            final prayerDateTime =
            DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            );

            // -----------------------------------------------
            // SKIP PAST TIMES
            // -----------------------------------------------

            if (!prayerDateTime.isAfter(
              now,
            )) {
              continue;
            }

            // -----------------------------------------------
            // GENERATE UNIQUE ID
            // -----------------------------------------------

            final athanId =
            _generateAthanId(
              date,
              prayerKey,
            );

            // -----------------------------------------------
            // SCHEDULE NATIVE ALARM
            // -----------------------------------------------

            await _scheduleNativeAthan(
              athanId: athanId,
              prayerName:
              prayerNames[prayerKey]!,
              prayerKey: prayerKey,
              timestamp:
              prayerDateTime
                  .millisecondsSinceEpoch,
            );

            debugPrint(
              'SCHEDULED $prayerKey '
                  '=> $prayerDateTime',
            );
          }
        } catch (e, stackTrace) {
          debugPrint(
            'ERROR FETCHING DATE '
                '$dateString: $e',
          );

          debugPrint(
            '$stackTrace',
          );
        }
      }
    } catch (e, stackTrace) {
      debugPrint(
        'ERROR IN ATHAN SCHEDULER: $e',
      );

      debugPrint(
        '$stackTrace',
      );
    }
  }

  // =========================================================
  // NATIVE SCHEDULE
  // =========================================================

  Future<void> _scheduleNativeAthan({
    required int athanId,
    required String prayerName,
    required String prayerKey,
    required int timestamp,
  }) async {
    try {
      await _channel.invokeMethod(
        'scheduleAthan',
        {
          'athanId': athanId,
          'prayerName': prayerName,
          'prayerKey': prayerKey,
          'timestamp': timestamp,
        },
      );
    } on PlatformException catch (e) {
      debugPrint(
        'NATIVE ATHAN ERROR: '
            '${e.code} - ${e.message}',
      );
    } catch (e) {
      debugPrint(
        'ERROR SCHEDULING NATIVE ATHAN: $e',
      );
    }
  }

  // =========================================================
  // CANCEL ONE PRAYER
  // =========================================================

  Future<void> cancelPrayer({
    required String prayerKey,
  }) async {
    if (!prayerBaseIds.containsKey(prayerKey)) {
      debugPrint(
        'INVALID PRAYER KEY => $prayerKey',
      );

      return;
    }

    try {
      await _channel.invokeMethod(
        'cancelAthanPrayer',
        {
          'prayerKey': prayerKey,
        },
      );

      debugPrint(
        'CANCELLED ALL ATHAN FOR: $prayerKey',
      );
    } catch (e, stackTrace) {
      debugPrint(
        'ERROR CANCELLING $prayerKey: $e',
      );

      debugPrint(
        '$stackTrace',
      );
    }
  }

  // =========================================================
  // CANCEL ALL
  // =========================================================

  Future<void> cancelAll() async {
    try {
      await _channel.invokeMethod(
        'cancelAllAthan',
      );

      debugPrint(
        'ALL ATHAN ALARMS CANCELLED',
      );
    } catch (e, stackTrace) {
      debugPrint(
        'ERROR CANCELLING ALL ATHAN: $e',
      );

      debugPrint(
        '$stackTrace',
      );
    }
  }

  // =========================================================
  // EXACT ALARM
  // =========================================================

  Future<bool>
  canScheduleExactAlarms() async {
    try {
      final result =
      await _channel.invokeMethod<bool>(
        'canScheduleExactAlarms',
      );

      return result ?? false;
    } catch (e) {
      debugPrint(
        'ERROR CHECKING EXACT ALARM: $e',
      );

      return false;
    }
  }

  Future<void>
  openExactAlarmSettings() async {
    try {
      await _channel.invokeMethod(
        'openExactAlarmSettings',
      );
    } catch (e) {
      debugPrint(
        'ERROR OPENING EXACT ALARM SETTINGS: $e',
      );
    }
  }

  // =========================================================
  // DATE FORMAT
  // =========================================================

  String _formatDate(DateTime date,) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  // =========================================================
  // GET PRAYER TIME
  // =========================================================

  _PrayerTime? _getPrayerTime(String prayerKey,
      dynamic timings,) {
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

    if (value == null ||
        value
            .trim()
            .isEmpty) {
      return null;
    }

    try {
      final cleanValue =
          value
              .trim()
              .split(' ')
              .first;

      final parts =
      cleanValue.split(':');

      if (parts.length < 2) {
        return null;
      }

      final hour =
      int.parse(parts[0]);

      final minute =
      int.parse(parts[1]);

      return _PrayerTime(
        hour: hour,
        minute: minute,
      );
    } catch (e) {
      debugPrint(
        'ERROR PARSING TIME: $value',
      );

      return null;
    }
  }

  // =========================================================
  // GENERATE UNIQUE ATHAN ID
  // =========================================================

  int _generateAthanId(DateTime date,
      String prayerKey,) {
    final baseId =
    prayerBaseIds[prayerKey]!;

    return (date.year * 10000 +
        date.month * 100 +
        date.day) *
        10 +
        baseId;
  }

  // =========================================================
  // DEFAULT PRAYER NAME
  // =========================================================

  String _getDefaultPrayerName(String prayerKey,) {
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
// PRAYER TIME MODEL
// ===========================================================

class _PrayerTime {
  final int hour;
  final int minute;

  const _PrayerTime({
    required this.hour,
    required this.minute,
  });
}