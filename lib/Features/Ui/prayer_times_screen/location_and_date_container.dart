import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class LocationAndDateContainer extends StatelessWidget {
  const LocationAndDateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430.w,
      height: 373.h,
      decoration: BoxDecoration(
        color: AppColors.DarkGreenColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 24.0.h, left: 24.w, right: 24.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "مواقيت الصلاة",
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "أوقات دقيقة حسب موقعك",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Container(
              width: 367.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.lightGreenColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "الرياض، المملكة العربية السعودية",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.whiteColor,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: 367.w,
              height: 153.h,
              decoration: BoxDecoration(
                color: AppColors.lightGreenColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "الثلاثاء",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      " 2025 أكتوبر 21 ",
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "28 ربيع الثاني 1447",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
