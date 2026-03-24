import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/app_colors.dart';

class MakkeiaOrMadeniaOrAllContainer extends StatelessWidget {
  MakkeiaOrMadeniaOrAllContainer({
    super.key,
    required this.isSelectd,
    required this.onTap,
    required this.title,
    required this.number,
  });

  bool isSelectd;
  VoidCallback onTap;
  String title;
  String number;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32.h,
        width: 123.66.w,
        decoration: BoxDecoration(
          //   border: Border.all(color: AppColors.GreyColor),
          color:
              isSelectd ? AppColors.DarkGreenColor : AppColors.semiwhiteColor,

          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 30.w),
          child: Row(
            children: [
              Text(
                number,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      isSelectd ? AppColors.whiteColor : AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      isSelectd ? AppColors.whiteColor : AppColors.BlackColor,
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
