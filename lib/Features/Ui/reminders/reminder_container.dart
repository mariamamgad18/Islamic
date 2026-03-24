import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class ReminderContainer extends StatefulWidget {
  ReminderContainer({
    super.key,
    required this.reminderTitle,
    required this.reminderTime,
    required this.reminderIcon,
  });

  String reminderTitle;
  String reminderIcon;

  TimeOfDay reminderTime;

  @override
  State<ReminderContainer> createState() => _ReminderContainerState();
}

class _ReminderContainerState extends State<ReminderContainer> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382.w,
      height: 98.h,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.w),
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
            Column(
              children: [
                Text(
                  widget.reminderTitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.BlackColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cairo",
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      widget.reminderTime.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.GreyColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(width: 3.3.w),
                    Icon(
                      Icons.access_time,
                      color: AppColors.GreyColor,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 16.w),
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: AppColors.DarkGreenColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Image(image: AssetImage(widget.reminderIcon)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
