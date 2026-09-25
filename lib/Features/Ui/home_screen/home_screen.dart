import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic/Features/Ui/home_screen/green_container.dart';
import 'package:islamic/Features/Ui/home_screen/home_content.dart';
import 'package:islamic/Features/Ui/location_permission_screen/cubit/location_states.dart';
import 'package:islamic/Features/Ui/location_permission_screen/cubit/location_view_model.dart';
import 'package:islamic/Features/Ui/prayer_times_screen/Cubit/prayer_times_stets.dart';
import 'package:islamic/Features/Ui/prayer_times_screen/Cubit/prayer_times_view_model.dart';
import 'package:islamic/core/DI/injection.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final LocationViewModel _locationViewModel;

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    _locationViewModel =
        getIt<LocationViewModel>();

    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        _loadSavedLocation();
      },
    );
  }

  // =========================================================
  // LOAD SAVED LOCATION
  // =========================================================
  //
  // مهم جداً:
  //
  // هنا إحنا مش بنطلب GPS.
  //
  // إحنا بس بنقرأ الـ location المحفوظة
  // من SharedPreferences.
  //
  // =========================================================

  Future<void> _loadSavedLocation() async {
    if (!mounted) return;

    await _locationViewModel
        .loadSavedLocation();
  }

  // =========================================================
  // CURRENT DATE
  // =========================================================

  String _getCurrentDate() {
    final now = DateTime.now();

    return "${now.day.toString().padLeft(2, '0')}-"
        "${now.month.toString().padLeft(2, '0')}-"
        "${now.year}";
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context,) {
    return MultiBlocProvider(
      providers: [
        // ===================================================
        // LOCATION VIEW MODEL
        // ===================================================

        BlocProvider<LocationViewModel>.value(
          value: _locationViewModel,
        ),

        // ===================================================
        // PRAYER TIMES VIEW MODEL
        // ===================================================

        BlocProvider<PrayerTimesViewModel>(
          create: (_) =>
              getIt<PrayerTimesViewModel>(),
        ),
      ],

      // =====================================================
      // SCAFFOLD
      // =====================================================

      child: Scaffold(
        backgroundColor:
        AppColors.semiwhiteColor,

        // ===================================================
        // LOCATION LISTENER
        // ===================================================

        body: BlocListener<
            LocationViewModel,
            LocationStates>(
          listener: (context,
              locationState,) {
            // ===============================================
            // LOCATION SUCCESS
            // ===============================================

            if (locationState
            is LocationSuccessState) {
              final location =
                  _locationViewModel.locationEntity;

              // =============================================
              // SAFETY CHECK
              // =============================================

              if (location == null) {
                return;
              }

              // =============================================
              // GET TODAY PRAYER TIMES
              // =============================================

              context
                  .read<PrayerTimesViewModel>()
                  .getPrayerTimes(
                date: _getCurrentDate(),
                latitude:
                location.latitude,
                longitude:
                location.longitude,
                method: 5,
              );
            }
          },

          // =================================================
          // LOCATION BUILDER
          // =================================================
          //
          // مهم:
          //
          // بدل ما نعتمد على PrayerTimesViewModel فقط،
          // بنسمع كمان للـ LocationViewModel.
          //
          // =================================================

          child: BlocBuilder<
              LocationViewModel,
              LocationStates>(
            builder: (context,
                locationState,) {
              // =============================================
              // LOCATION LOADING
              // =============================================
              //
              // ده ممكن يحصل فقط لو استخدمنا
              // getCurrentLocation().
              //
              // أما عند فتح Home عادي،
              // loadSavedLocation() مش بيطلب GPS.
              //
              // =============================================

              if (locationState
              is LocationLoadingState) {
                return const Center(
                  child:
                  CircularProgressIndicator(),
                );
              }

              // =============================================
              // NO SAVED LOCATION
              // =============================================
              //
              // أول مرة لو المستخدم ضغط Skip
              // هيكون مفيش Location محفوظة.
              //
              // بالتالي الصلاة تظهر 00:00
              // عن طريق timings: null.
              //
              // =============================================

              if (locationState
              is LocationInitialState ||
                  _locationViewModel.locationEntity ==
                      null) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      GreenContainer(
                        timings: null,
                        onLocationUpdated: _loadSavedLocation,

                      ),

                      Column(
                        children: [
                          HomeContent(),
                        ],
                      ),
                    ],
                  ),
                );
              }

              // =============================================
              // LOCATION ERROR
              // =============================================

              if (locationState
              is LocationErrorState) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      GreenContainer(
                        timings: null,
                        onLocationUpdated: _loadSavedLocation,

                      ),

                      Column(
                        children: [
                          HomeContent(),
                        ],
                      ),
                    ],
                  ),
                );
              }

              // =============================================
              // SAVED LOCATION EXISTS
              // =============================================
              //
              // دلوقتي نسمع للـ PrayerTimesViewModel
              // علشان نعرض حالة الصلاة.
              //
              // =============================================

              return BlocBuilder<
                  PrayerTimesViewModel,
                  PrayerTimesStates>(
                builder: (context,
                    prayerState,) {
                  // =========================================
                  // PRAYER TIMES LOADING
                  // =========================================

                  if (prayerState
                  is PrayerTimesLoadingState) {
                    return const Center(
                      child:
                      CircularProgressIndicator(),
                    );
                  }

                  // =========================================
                  // PRAYER TIMES ERROR
                  // =========================================

                  if (prayerState
                  is PrayerTimesErrorState) {
                    return Center(
                      child: Text(
                        prayerState.errorMessage,
                      ),
                    );
                  }

                  // =========================================
                  // PRAYER TIMES SUCCESS
                  // =========================================

                  if (prayerState
                  is PrayerTimesSuccessState) {
                    return SingleChildScrollView(
                      child: Stack(
                        children: [
                          GreenContainer(
                            timings: prayerState
                                .prayersTimes
                                .data
                                .timings,
                            onLocationUpdated: _loadSavedLocation,

                          ),

                          Column(
                            children: [
                              HomeContent(),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  // =========================================
                  // DEFAULT
                  // =========================================
                  //
                  // Location موجودة لكن لسه Prayer Times
                  // مبدأتش أو مفيش نتيجة لسه.
                  //
                  // =========================================

                  return SingleChildScrollView(
                    child: Stack(
                      children: [
                        GreenContainer(
                          timings: null,
                          onLocationUpdated: _loadSavedLocation,

                        ),

                        Column(
                          children: [
                            HomeContent(),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}