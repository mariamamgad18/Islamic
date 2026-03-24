import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/app_colors.dart';
import '../../../core/Utils/app_images.dart';

class OnBoardingPageViewModel extends StatelessWidget {
  final String OnBoardingimage;
  final String OnBoardingTitle;
  final String OnBoardingDescription;

  const OnBoardingPageViewModel({
    super.key,
    required this.OnBoardingimage,
    required this.OnBoardingTitle,
    required this.OnBoardingDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: AssetImage(AppImages.onBoardingscreen), fit: BoxFit.cover),

        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 200.0.h),
            child: Column(
              children: [
                Image.asset(OnBoardingimage, height: 120.h, width: 120.w),
                SizedBox(height: 8.h),
                Text(
                  OnBoardingTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: AppColors.BlackColor,
                    fontFamily: "Cairo",
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  OnBoardingDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.GreyColor,
                    fontFamily: "Cairo",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/*

 */
