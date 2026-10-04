import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic/Features/Ui/Widgets/main_error_widget.dart';
import 'package:islamic/Features/Ui/Widgets/main_loading_widget.dart';
import 'package:islamic/Features/Ui/prayer_times_screen/location_and_date_container.dart';
import 'package:islamic/Features/Ui/prayer_times_screen/prayers_list_view.dart'
as prayer_list;
import 'package:islamic/core/Services/athan_scheduler.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_preferences.dart';
import 'package:islamic/l10n/app_localizations.dart';

import '../../../Core/DI/injection.dart';
import '../location_permission_screen/cubit/location_states.dart';
import '../location_permission_screen/cubit/location_view_model.dart';
import 'Cubit/prayer_times_stets.dart';
import 'Cubit/prayer_times_view_model.dart'
as prayer_view_model;

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({
    super.key,
  });

  @override
  State<PrayerTimesScreen> createState() =>
      _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  late final LocationViewModel
  _locationViewModel;

  late final AthanScheduler
  _athanScheduler;

// =========================================================
// INIT
// =========================================================

  @override
  void initState() {
    super.initState();

    _locationViewModel =
        getIt<LocationViewModel>();

    _athanScheduler =
        getIt<AthanScheduler>();

    WidgetsBinding.instance
        .addPostFrameCallback((_) async {
      await _athanScheduler
          .initializeAthanMasterState();

      await _loadSavedLocation();
    });
  }

// =========================================================
// LOAD SAVED LOCATION
// =========================================================

  Future<void> _loadSavedLocation() async {
    final hasLocation =
    await AppPreferences.hasSavedLocation();

    if (!mounted) return;

    if (!hasLocation) {
      return;
    }

    await _locationViewModel
        .loadSavedLocation();
  }

// =========================================================
// CURRENT DATE
// =========================================================

  String _getCurrentDate() {
    final now = DateTime.now();

    return '${now.day.toString().padLeft(2, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.year}';
  }

// =========================================================
// SCHEDULE ATHAN
// =========================================================
//
// IMPORTANT:
// This function only schedules according to the individual
// prayer states saved in SharedPreferences.
//
// It DOES NOT enable all prayers by itself.
//
// =========================================================

  Future<void> _scheduleAthan({
    required double latitude,
    required double longitude,
  }) async {
    try {
// =======================================================
// MASTER ATHAN CHECK
// =======================================================

      final masterEnabled =
      await _athanScheduler.isAthanEnabled();

      if (!masterEnabled) {
        debugPrint(
          'MASTER ATHAN OFF => SKIP SCHEDULING',
        );

        return;
      }

// =======================================================
// EXACT ALARM PERMISSION
// =======================================================

      final canSchedule =
      await _athanScheduler
          .canScheduleExactAlarms();

      if (!canSchedule) {
        debugPrint(
          'EXACT ALARM PERMISSION NOT GRANTED',
        );

        return;
      }

// =======================================================
// SCHEDULE
// =======================================================

      await _athanScheduler.scheduleNextDays(
        latitude: latitude,
        longitude: longitude,
        method: 5,
        days: AthanScheduler.scheduledDays,
      );

      debugPrint(
        'ATHAN SCHEDULER FINISHED',
      );
    } catch (e, stackTrace) {
      debugPrint(
        'ERROR STARTING ATHAN SCHEDULER: $e',
      );

      debugPrint(
        '$stackTrace',
      );
    }
  }

// =========================================================
// HANDLE INDIVIDUAL AZAN SWITCH
// =========================================================

  Future<void> _onAzanToggle(String prayerKey,
      bool enabled,
      double latitude,
      double longitude,) async {
    try {
// =======================================================
// CHECK MASTER
// =======================================================

      final masterEnabled =
      await _athanScheduler.isAthanEnabled();

// =======================================================
// MASTER OFF
// =======================================================

      if (!masterEnabled) {
        debugPrint(
          'MASTER ATHAN OFF => '
              'CANNOT ENABLE $prayerKey',
        );

        return;
      }

// =======================================================
// ENABLE INDIVIDUAL PRAYER
// =======================================================

      if (enabled) {
        await _scheduleAthan(
          latitude: latitude,
          longitude: longitude,
        );

        debugPrint(
          '$prayerKey ATHAN ENABLED',
        );
      }

// =======================================================
// DISABLE INDIVIDUAL PRAYER
// =======================================================

      else {
        await _athanScheduler.cancelPrayer(
          prayerKey: prayerKey,
        );

        debugPrint(
          '$prayerKey ATHAN DISABLED',
        );
      }
    } catch (e, stackTrace) {
      debugPrint(
        'ERROR HANDLING AZAN TOGGLE: $e',
      );

      debugPrint(
        '$stackTrace',
      );
    }
  }

// =========================================================
// BUILD
// =========================================================

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
// =====================================================
// LOCATION
// =====================================================

        BlocProvider<LocationViewModel>.value(
          value: _locationViewModel,
        ),

// =====================================================
// PRAYER TIMES
// =====================================================

        BlocProvider<
            prayer_view_model.PrayerTimesViewModel>(
          create: (_) =>
              getIt<
                  prayer_view_model
                      .PrayerTimesViewModel>(),
        ),
      ],
      child: Scaffold(
        backgroundColor:
        AppColors.semiwhiteColor,

        body: BlocListener<
            LocationViewModel,
            LocationStates>(
          listener: (context,
              locationState,) async {
// =================================================
// LOCATION SUCCESS
// =================================================

            if (locationState
            is LocationSuccessState) {
              final location =
                  _locationViewModel
                      .locationEntity;

              if (location == null) {
                return;
              }

// ===============================================
// GET TODAY PRAYER TIMES
// ===============================================

              context
                  .read<
                  prayer_view_model
                      .PrayerTimesViewModel>()
                  .getPrayerTimes(
                date: _getCurrentDate(),
                latitude:
                location.latitude,
                longitude:
                location.longitude,
                method: 5,
              );

// ===============================================
// SCHEDULE ONLY IF MASTER IS ON
// ===============================================

              await _scheduleAthan(
                latitude:
                location.latitude,
                longitude:
                location.longitude,
              );
            }
          },

          child: BlocBuilder<
              prayer_view_model
                  .PrayerTimesViewModel,
              PrayerTimesStates>(
            builder: (context,
                prayerState,) {
// =================================================
// NO LOCATION
// =================================================

              if (!_locationViewModel
                  .locationEntityPresent) {
                return Stack(
                  children: [
                    LocationAndDateContainer(
                      cityName:
                      localizations
                          .locationUnavailable,
                    ),

                    prayer_list
                        .PrayersListView(
                      timings: null,
                    ),
                  ],
                );
              }

// =================================================
// LOADING
// =================================================

              if (prayerState
              is PrayerTimesLoadingState) {
                return MainLoadingWidget();
              }

// =================================================
// ERROR
// =================================================

              if (prayerState
              is PrayerTimesErrorState) {
                return MainErrorWidget(
                  errorMsg:
                  prayerState.errorMessage,
                );
              }

// =================================================
// SUCCESS
// =================================================

              if (prayerState
              is PrayerTimesSuccessState) {
                final location =
                _locationViewModel
                    .locationEntity!;

                return Stack(
                  children: [
// =========================================
// LOCATION + DATE
// =========================================

                    LocationAndDateContainer(
                      cityName:
                      location.cityName,
                    ),

// =========================================
// PRAYER LIST
// =========================================

                    prayer_list
                        .PrayersListView(
                      timings:
                      prayerState
                          .prayersTimes
                          .data
                          .timings,

                      onAzanToggle:
                          (prayerKey,
                          enabled,) async {
                        await _onAzanToggle(
                          prayerKey,
                          enabled,
                          location.latitude,
                          location.longitude,
                        );
                      },
                    ),
                  ],
                );
              }

// =================================================
// DEFAULT
// =================================================

              return Stack(
                children: [
                  LocationAndDateContainer(
                    cityName:
                    localizations
                        .locationUnavailable,
                  ),

                  prayer_list
                      .PrayersListView(
                    timings: null,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
