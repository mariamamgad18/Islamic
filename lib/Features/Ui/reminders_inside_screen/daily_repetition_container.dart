import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class DailyRepetitionContainer extends StatefulWidget {
  DailyRepetitionContainer({super.key});

  @override
  State<DailyRepetitionContainer> createState() =>
      _DailyRepetitionContainerState();
}

class _DailyRepetitionContainerState extends State<DailyRepetitionContainer> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 470.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 16.w),
        child: Row(
          children: [
            Switch(
              value: dark,

              activeTrackColor: AppColors.DarkGreenColor,
              activeColor: AppColors.whiteColor,
              inactiveThumbColor: AppColors.GreyColor,
              onChanged: (bool value) {
                setState(() {
                  dark = value;
                });
              },
            ),
            Spacer(),
            Text(
              "تكرار يومي",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.BlackColor,
                fontWeight: FontWeight.w500,
                fontFamily: "Cairo",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
