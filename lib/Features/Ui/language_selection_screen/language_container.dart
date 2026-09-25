import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

import '../../../core/Utils/app_images.dart';

class LanguageContainer extends StatelessWidget {
  LanguageContainer({
    super.key,
    required this.firstLanguageTitle,
    required this.onTap,
    required this.SecondtLanguageTitle,
    required this.flagImage,
    required this.isSelected,
  });

  String firstLanguageTitle;
  String SecondtLanguageTitle;
  String flagImage;
  bool isSelected;
  VoidCallback onTap; // جديد: وظيفة الضغط

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 382.w,
          height: 96.h,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  isSelected ? AppColors.DarkGreenColor : AppColors.transparent,
              width: 2,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
            child: Row(
              children: [
                //todo: ///////done///////////////
                if (isSelected)
                  Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.DarkGreenColor,
                    ),
                    child: Image(image: AssetImage(AppImages.SelectedIcon)),
                  ),

                Spacer(),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          firstLanguageTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: AppColors.BlackColor,
                            fontFamily: "Cairo",
                          ),
                        ),
                        Text(
                          SecondtLanguageTitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.GreyColor,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.w),
                    Image(image: AssetImage(flagImage)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
