import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islamic/Features/Ui/on_boarding_screens/on_boarding_page_view_model.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/core/Utils/app_routes.dart';

import '../../../core/Utils/app_colors.dart';
import '../../../core/Utils/app_preferences.dart';
import '../../../l10n/app_localizations.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  int currentPage = 0;

  Color get activeColor {
    if (currentPage == 1) {
      return AppColors.YellowColor;
    }

    return AppColors.DarkGreenColor;
  }

  Row get buttonText {
    final localizations = AppLocalizations.of(context)!;

    if (currentPage == 2) {
      return Row(
        children: [
          SizedBox(width: 25.w),

          Text(
            localizations.getStarted,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.whiteColor,
              fontFamily: "Cairo",
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        SizedBox(width: 8.w),

        Text(
          localizations.next,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: "Cairo",
          ),
        ),

        SizedBox(width: 4.w),

        Icon(
          Icons.arrow_forward_ios,
          color: AppColors.whiteColor,
          size: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return IntroductionScreen(
      safeAreaList: const [false, false, false, false],

      onChange: (index) {
        setState(() {
          currentPage = index;
        });
      },

// =========================================================
// DOTS
// =========================================================

      dotsDecorator: DotsDecorator(
        size: const Size(10, 10),
        activeSize: const Size(12, 12),
        color: AppColors.GreyColor,
        activeColor: activeColor,
      ),

// =========================================================
// NEXT BUTTON
// =========================================================

      rtl: false,
      showNextButton: true,

      next: Container(
        width: 200.w,
        height: 56.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 20.w,
          ),
          child: buttonText,
        ),
      ),

// =========================================================
// DONE BUTTON
// =========================================================

      showDoneButton: true,

      onDone: () async {
        await AppPreferences.setOnboardingCompleted();

        if (!context.mounted) return;

        Navigator.of(context).pushReplacementNamed(
          AppRoutes.LanguageSelectionScreenRoutename,
        );
      },

      done: Container(
        width: 200.w,
        height: 56.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: buttonText,
      ),

// =========================================================
// SKIP BUTTON
// =========================================================

      showSkipButton: true,

      onSkip: () async {
        await AppPreferences.setOnboardingCompleted();

        if (!context.mounted) return;

        Navigator.of(context).pushReplacementNamed(
          AppRoutes.LanguageSelectionScreenRoutename,
        );
      },

      skip: Text(
        localizations.skip,
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Cairo",
          color: AppColors.GreyColor,
        ),
      ),

// =========================================================
// PAGES
// =========================================================

      pages: [
// =======================================================
// PAGE 1
// =======================================================

        PageViewModel(
          titleWidget: const SizedBox(),

          decoration: const PageDecoration(
            bodyPadding: EdgeInsets.zero,
          ),

          bodyWidget: OnBoardingPageViewModel(
            OnBoardingimage: AppImages.onBoarding1,

            OnBoardingTitle: localizations.quranKareem,

            OnBoardingDescription:
            localizations.quranDescription,
          ),
        ),

// =======================================================
// PAGE 2
// =======================================================

        PageViewModel(
          titleWidget: const SizedBox(),

          decoration: const PageDecoration(
            bodyPadding: EdgeInsets.zero,
          ),

          bodyWidget: OnBoardingPageViewModel(
            OnBoardingimage: AppImages.onBoarding2,

            OnBoardingTitle: localizations.prayerTimes,

            OnBoardingDescription:
            localizations.prayerTimesDescription,
          ),
        ),

// =======================================================
// PAGE 3
// =======================================================

        PageViewModel(
          titleWidget: const SizedBox(),

          decoration: const PageDecoration(
            bodyPadding: EdgeInsets.zero,
          ),

          bodyWidget: OnBoardingPageViewModel(
            OnBoardingimage: AppImages.onBoarding3,

            OnBoardingTitle:
            localizations.spiritualCompanion,

            OnBoardingDescription:
            localizations.spiritualCompanionDescription,
          ),
        ),
      ],
    );
  }
}
