import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/app_colors.dart';
import '../../../core/Utils/app_images.dart';

class AyahContainerr extends StatelessWidget {
  AyahContainerr({
    super.key,
    this.title = "آية اليوم",
    this.subTitle = "﴾وَقُل رَّبِّ زِدۡنِی عِلۡمࣰا﴿ ",
    this.lastLine = "سورة طه - آية 114",
    this.topPadding = 415,
    this.ayahWidth = 500,
    this.ayahHeight = 300,
  });

  String title;
  String subTitle;
  String lastLine;
  int topPadding;
  int ayahWidth;
  int ayahHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding.h,
        right: 10.w,
        left: 10.w,
        bottom: 5,
      ),
      child: Container(
        width: ayahWidth.w,
        height: ayahHeight.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //  border: Border.all(color: AppColors.YellowColor,width: 2),
          image: DecorationImage(
            image: AssetImage(AppImages.ayahBackGround),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.DarkYellowColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Image(image: AssetImage(AppImages.starIcon)),
                ),
                SizedBox(height: 16.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.GreyColor,
                    fontFamily: "Cairo",
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: 64.w,
                  height: 1.h,
                  color: AppColors.DarkYellowColor,
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    subTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.BlackColor,
                      fontFamily: "Amiri",
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                Container(
                  width: 64.w,
                  height: 1.h,
                  color: AppColors.DarkYellowColor,
                ),
                SizedBox(height: 5.h),
                Text(
                  lastLine,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.GreyColor,
                    fontFamily: "Cairo",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
