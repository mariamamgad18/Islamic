import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/home_screen/prayer_times_container.dart';
import 'package:islamic/core/Utils/app_routes.dart';

import '../../../core/Utils/app_colors.dart';
import '../../../core/Utils/app_images.dart';

class GreenContainer extends StatelessWidget {
  const GreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430.w,
      height: 478.h,
      decoration: BoxDecoration(
        color: AppColors.DarkGreenColor,
        borderRadius: BorderRadius.circular(48),
        image: DecorationImage(
          image: AssetImage(AppImages.GreenContainer),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.0.w),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.settingScreenRoutename);
                  },
                  child: Image(image: AssetImage(AppImages.settinIcon)),
                ),
                SizedBox(width: 18.w),
                Image(image: AssetImage(AppImages.themeIcon)),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "المصحف الشريف",
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColors.whiteColor,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(width: 4.h),
                    Text(
                      "السلام عليكم ورحمة الله",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24.h),
            PrayerTimesContainer(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
