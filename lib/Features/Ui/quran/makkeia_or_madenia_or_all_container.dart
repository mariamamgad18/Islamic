import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/app_colors.dart';

class MakkeiaOrMadeniaOrAllContainer extends StatelessWidget {
  final bool isSelectd;
  final VoidCallback onTap;
  final String title;
  final String number;

  const MakkeiaOrMadeniaOrAllContainer({
    super.key,
    required this.isSelectd,
    required this.onTap,
    required this.title,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 33.h,
        decoration: BoxDecoration(
          color: isSelectd
              ? AppColors.DarkGreenColor
              : AppColors.semiwhiteColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 6.h,
            horizontal: 30.w,
          ),
          child: Row(
            children: [
              Text(
                number,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelectd
                      ? AppColors.whiteColor
                      : AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isSelectd
                      ? AppColors.whiteColor
                      : AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}