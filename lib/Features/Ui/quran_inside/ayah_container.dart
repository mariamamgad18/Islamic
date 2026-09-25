import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class AyahContainer extends StatelessWidget {
  const AyahContainer({
    super.key,
    required this.counter,
    required this.ayah,
    required this.fontSize,
  });

  final String counter;
  final String ayah;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        right: 20.w,
        left: 20.w,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            bottom: 32.h,
            right: 20.w,
            left: 20.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// =========================================================
// Ayah Number
// =========================================================

              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.DarkGreenColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    counter,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cairo",
                    ),
                  ),
                ),
              ),

              SizedBox(width: 20.w),

// =========================================================
// Ayah Text
// =========================================================

              Expanded(
                child: Text(
                  ayah,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: fontSize,
                    height: 1.8,
                    color: AppColors.BlackColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Amiri",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
