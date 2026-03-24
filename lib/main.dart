import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Features/Ui/Azkar/azkar_page.dart';
import 'Features/Ui/Nearby_Mosques_screen/nearby_mosques_screen.dart';
import 'Features/Ui/Reminders/reminders_page.dart';
import 'Features/Ui/Sebha/sebha_screen.dart';
import 'Features/Ui/home_screen/home_screen.dart';
import 'Features/Ui/language_selection_screen/language_selection_screen.dart';
import 'Features/Ui/location_permission_screen/location_permission_screen.dart';
import 'Features/Ui/on_boarding_screens/on_boarding_screens.dart';
import 'Features/Ui/prayer_times_screen/prayer_times_screen.dart';
import 'Features/Ui/qebla/qebla_screen.dart';
import 'Features/Ui/quran/quran_list_page.dart';
import 'Features/Ui/quran_inside/quran_inside_page.dart';
import 'Features/Ui/reminders_inside_screen/reminders_Inside_screen.dart';
import 'Features/Ui/setting/setting_screen.dart';
import 'Features/Ui/splash_screen/splash_screen.dart';
import 'core/Utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoutes.SplashScreenRoutename,
              routes: {
                AppRoutes.SplashScreenRoutename: (context) => SplashScreen(),
                AppRoutes.OnBoardingScreenRoutename: (context) =>
                    OnBoardingScreens(),
                AppRoutes.LanguageSelectionScreenRoutename: (context) =>
                    LanguageSelectionScreen(),

                AppRoutes.LocationPermissionScreenRoutename: (context) =>
                    LocationPermissionScreen(),
                AppRoutes.HomeScreenRoutename: (context) => HomeScreen()
                ,
                AppRoutes.QuranScreenRoutename: (context) => QuranListPage(),

                AppRoutes.QuranInsideScreenRoutename: (context) =>
                    QuranInsidePage(),
                AppRoutes.AzkarScreenRoutename: (context) => AzkarPage(),
                AppRoutes.RemindersScreenRoutename: (context) =>
                    RemindersPage(),
                AppRoutes.RemindersInsideScreenRoutename: (context) =>
                    RemindersInsideScreen(),
                AppRoutes.settingScreenRoutename: (context) => SettingScreen(),
                AppRoutes.TasbihScreenRoutename: (context) => SebhaScreen(),
                AppRoutes.QiblaScreenRoutename: (context) => QeblaScreen(),
                AppRoutes.AzanScreenRoutename: (context) => PrayerTimesScreen(),
                AppRoutes.NearbyMosquesScreenRoutename: (context) =>
                    NearbyMosquesScreen(),


              }

          );
        }
    );
  }
}
