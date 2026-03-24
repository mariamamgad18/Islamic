import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class SettingOption extends StatelessWidget {
  SettingOption({
    super.key,
    required this.buttonOrRow,
    required this.title,
    required this.subTitle,
    required this.SettingImage,
  });

  Widget buttonOrRow;
  String title;
  String subTitle;
  String SettingImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      color: AppColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.w),
        child: Row(
          children: [
            buttonOrRow,
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.BlackColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cairo",
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.GreyColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cairo",
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Container(
              width: 40.h,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.semiwhiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image(image: AssetImage(SettingImage)),
            ),
          ],
        ),
      ),
    );
  }
}
