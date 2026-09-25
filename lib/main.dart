import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/l10n/app_localizations.dart';

import 'Features/Ui/Azkar/azkar_page.dart';
import 'Features/Ui/Azkar/cubit/azkar_view_model.dart';
import 'Features/Ui/Nearby_Mosques_screen/nearby_mosques_screen.dart';
import 'Features/Ui/Reminders/reminders_page.dart';
import 'Features/Ui/Sebha/sebha_screen.dart';
import 'Features/Ui/home_screen/home_screen.dart';
import 'Features/Ui/language_selection_screen/language_selection_screen.dart';
import 'Features/Ui/location_permission_screen/location_permission_screen.dart';
import 'Features/Ui/on_boarding_screens/on_boarding_screens.dart';
import 'Features/Ui/prayer_times_screen/athan_screen.dart';
import 'Features/Ui/prayer_times_screen/prayer_times_screen.dart';
import 'Features/Ui/qebla/qebla_screen.dart';
import 'Features/Ui/quran/quran_list_page.dart';
import 'Features/Ui/reminders_inside_screen/reminders_Inside_screen.dart';
import 'Features/Ui/setting/setting_screen.dart';
import 'Features/Ui/splash_screen/splash_screen.dart';
import 'core/DI/injection.dart';
import 'core/Services/notification_service.dart';
import 'core/Utils/app_routes.dart';
import 'core/Utils/language_manager.dart';


// =========================================================
// ATHAN ACTIVITY METHOD CHANNEL
// =========================================================
//
// Used by AthanActivity <-> Flutter
// For:
// - Getting athan data
// - Stopping athan
//

const MethodChannel athanActivityChannel =
MethodChannel('athan_activity_channel');


// =========================================================
// NAVIGATOR KEY
// =========================================================

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>();


// =========================================================
// MAIN
// =========================================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // =======================================================
  // LANGUAGE
  // =======================================================

  await LanguageManager.loadSavedLanguage();

  // =======================================================
  // NOTIFICATIONS
  // =======================================================

  await NotificationService.init();

  // =======================================================
  // DEPENDENCIES
  // =======================================================

  await configureDependencies();

  // =======================================================
  // CHECK IF APP WAS OPENED FROM NOTIFICATION
  // =======================================================

  final NotificationAppLaunchDetails?
  notificationAppLaunchDetails =
  await NotificationService
      .flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails();

  String? athanPayload;

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ??
      false) {
    athanPayload =
        notificationAppLaunchDetails
            ?.notificationResponse
            ?.payload;
  }

  debugPrint(
    'Athan Payload: $athanPayload',
  );

  // =======================================================
  // RUN APP
  // =======================================================

  runApp(
    MyApp(
      athanPayload: athanPayload,
    ),
  );
}


// =========================================================
// MY APP
// =========================================================

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    this.athanPayload,
  });

  final String? athanPayload;


// =========================================================
// GET ATHAN SCREEN FROM NOTIFICATION PAYLOAD
// =========================================================

  AthanScreen? _getAthanScreen() {
    if (athanPayload == null ||
        !athanPayload!.startsWith('athan:')) {
      return null;
    }

    final List<String> parts =
    athanPayload!.split(':');

    if (parts.length < 3) {
      return null;
    }

    final int? athanId =
    int.tryParse(parts[1]);

    if (athanId == null) {
      return null;
    }

    final String prayerName =
    parts.sublist(2).join(':');

    return AthanScreen(
      athanId: athanId,
      prayerName: prayerName,
    );
  }


// =========================================================
// BUILD
// =========================================================

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable:
      LanguageManager.localeNotifier,
      builder: (context,
          locale,
          child,) {
        return ScreenUtilInit(
          designSize: const Size(
            430,
            932,
          ),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context,
              child,) {
            final AthanScreen? athanScreen =
            _getAthanScreen();

            return MaterialApp(

              // =================================================
              // BASIC SETTINGS
              // =================================================

              debugShowCheckedModeBanner: false,

              navigatorKey: navigatorKey,

              // =================================================
              // LOCALIZATION
              // =================================================

              locale: locale,

              localizationsDelegates: const [
                AppLocalizations.delegate,

                GlobalMaterialLocalizations.delegate,

                GlobalWidgetsLocalizations.delegate,

                GlobalCupertinoLocalizations.delegate,
              ],

              supportedLocales: const [
                Locale('en'),
                Locale('fr'),
                Locale('ur'),
                Locale('ar'),
              ],

              // =================================================
              // HOME
              // =================================================

              home: athanScreen ??
                  SplashScreen(),

              // =================================================
              // ROUTES
              // =================================================

              routes: {

                // -------------------------------------------------
                // SPLASH
                // -------------------------------------------------

                AppRoutes.SplashScreenRoutename:
                    (context) => SplashScreen(),

                // -------------------------------------------------
                // ONBOARDING
                // -------------------------------------------------

                AppRoutes.OnBoardingScreenRoutename:
                    (context) => OnBoardingScreens(),

                // -------------------------------------------------
                // LANGUAGE
                // -------------------------------------------------

                AppRoutes.LanguageSelectionScreenRoutename:
                    (context) =>
                    LanguageSelectionScreen(),

                // -------------------------------------------------
                // LOCATION PERMISSION
                // -------------------------------------------------

                AppRoutes.LocationPermissionScreenRoutename:
                    (context) =>
                    LocationPermissionScreen(),

                // -------------------------------------------------
                // HOME
                // -------------------------------------------------

                AppRoutes.HomeScreenRoutename:
                    (context) => HomeScreen(),

                // -------------------------------------------------
                // QURAN
                // -------------------------------------------------

                AppRoutes.QuranScreenRoutename:
                    (context) => QuranListPage(),

                // -------------------------------------------------
                // AZKAR
                // -------------------------------------------------

                AppRoutes.AzkarScreenRoutename:
                    (context) =>
                    BlocProvider(
                      create: (context) =>
                          getIt<AzkarViewModel>(),
                      child: const AzkarPage(),
                    ),

                // -------------------------------------------------
                // REMINDERS
                // -------------------------------------------------

                AppRoutes.RemindersScreenRoutename:
                    (context) => RemindersPage(),

                // -------------------------------------------------
                // ADD REMINDER
                // -------------------------------------------------

                AppRoutes.RemindersInsideScreenRoutename:
                    (context) =>
                    RemindersInsideScreen(),

                // -------------------------------------------------
                // SETTINGS
                // -------------------------------------------------

                AppRoutes.settingScreenRoutename:
                    (context) => SettingScreen(),

                // -------------------------------------------------
                // SEBHA
                // -------------------------------------------------

                AppRoutes.TasbihScreenRoutename:
                    (context) => SebhaScreen(),

                // -------------------------------------------------
                // QIBLA
                // -------------------------------------------------

                AppRoutes.QiblaScreenRoutename:
                    (context) => QeblaScreen(),

                // -------------------------------------------------
                // PRAYER TIMES
                // -------------------------------------------------

                AppRoutes.AzanScreenRoutename:
                    (context) =>
                    PrayerTimesScreen(),

                // -------------------------------------------------
                // ATHAN
                // -------------------------------------------------

                '/athan':
                    (context) =>
                const AthanLauncher(),

                // -------------------------------------------------
                // NEARBY MOSQUES
                // -------------------------------------------------

                AppRoutes.NearbyMosquesScreenRoutename:
                    (context) =>
                    NearbyMosquesScreen(),
              },
            );
          },
        );
      },
    );
  }
}


// =========================================================
// ATHAN LAUNCHER
// =========================================================
//
// This screen is opened inside AthanActivity.
//
// It gets:
// - athanId
// - prayerName
//
// from Kotlin through MethodChannel.
//
// Then it displays AthanScreen.
//

class AthanLauncher extends StatefulWidget {
  const AthanLauncher({
    super.key,
  });

  @override
  State<AthanLauncher> createState() =>
      _AthanLauncherState();
}


class _AthanLauncherState extends State<AthanLauncher> {

  int? athanId;

  String prayerName = '';

  bool isLoading = true;


  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    _getAthanData();
  }


  // =========================================================
  // GET ATHAN DATA
  // =========================================================

  Future<void> _getAthanData() async {
    try {
      final dynamic result =
      await athanActivityChannel.invokeMethod(
        'getAthanData',
      );

      if (result is Map) {
        final dynamic id =
        result['athanId'];

        final dynamic name =
        result['prayerName'];

        if (mounted) {
          setState(() {
            athanId = id is int
                ? id
                : int.tryParse(
              id?.toString() ?? '',
            );

            prayerName =
                name?.toString() ?? '';

            isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint(
        'ERROR GETTING ATHAN DATA: $e',
      );

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context,) {
    if (isLoading) {
      return const Scaffold(

        backgroundColor: Colors.black,

        body: Center(

          child: CircularProgressIndicator(
            color: Colors.white,
          ),

        ),
      );
    }


    if (athanId == null) {
      return Scaffold(

        backgroundColor: Colors.black,

        body: Center(

          child: Text(

            'حدث خطأ في تشغيل الأذان',

            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontFamily: 'Cairo',
            ),

          ),

        ),
      );
    }


    return AthanScreen(
      athanId: athanId!,
      prayerName: prayerName,
    );
  }
}