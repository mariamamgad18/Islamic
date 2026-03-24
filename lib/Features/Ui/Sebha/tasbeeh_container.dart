import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class TasbeehContainer extends StatelessWidget {
  TasbeehContainer({
    super.key,
    required this.tasbeehTitle,
    required this.onTap,
    this.isSelected = false,
  });

  String tasbeehTitle;
  VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 181.5.w,
        height: 64.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.whiteColor,
          border: Border.all(
            color:
                isSelected ? AppColors.DarkGreenColor : AppColors.transparent,
            width: isSelected ? 1 : 10,
          ),
        ),
        child:
            isSelected
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tasbeehTitle,
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Amiri",
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: AppColors.DarkGreenColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                )
                : Center(
                  child: Text(
                    tasbeehTitle,
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.BlackColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Amiri",
                    ),
                  ),
                ),
      ),
    );
  }
}
