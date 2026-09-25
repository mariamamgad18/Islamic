import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/core/Utils/app_preferences.dart';

import '../../../core/Utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkAppStatus();
  }

  // =========================================================
  // CHECK APP STATUS
  // =========================================================

  Future<void> _checkAppStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    final onboardingCompleted =
    await AppPreferences.isOnboardingCompleted();

    final locationFlowCompleted =
    await AppPreferences.isLocationFlowCompleted();

    if (!mounted) return;

    // =======================================================
    // FIRST TIME
    // =======================================================

    if (!onboardingCompleted) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.OnBoardingScreenRoutename,
      );

      return;
    }

    // =======================================================
    // ONBOARDING DONE BUT LOCATION FLOW NOT DONE
    // =======================================================

    if (!locationFlowCompleted) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.LocationPermissionScreenRoutename,
      );

      return;
    }

    // =======================================================
    // EVERYTHING DONE
    // =======================================================

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.HomeScreenRoutename,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage(AppImages.SplashScreenBackGround),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 303.5.h,
            horizontal: 55.05.w,
          ),
          child: SizedBox(
            height: 325.h,
            width: 319.89.w,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(
                AppImages.SplashScreenContent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}