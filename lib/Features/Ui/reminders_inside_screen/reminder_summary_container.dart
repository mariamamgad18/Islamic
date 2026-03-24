import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/app_colors.dart';
import '../../../core/Utils/app_images.dart';

class ReminderSummaryContainer extends StatelessWidget {
  ReminderSummaryContainer({
    super.key,
    required this.selecetdTime,
    required this.selectedTitle,
  });

  TimeOfDay? selecetdTime;
  String selectedTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 462.w,
      height: 134.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.reminderContainerbackground),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "معاينة التذكير",
              style: TextStyle(
                fontSize: 12,
                color: AppColors.GreyColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Cairo",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_alarm,
                      color: AppColors.GreyColor,
                      size: 12,
                    ),
                    SizedBox(width: 3.h),
                    Text(
                      selecetdTime != null
                          ? selecetdTime!.format(context)
                          : "00:00",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.GreyColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      selectedTitle.isNotEmpty
                          ? selectedTitle
                          : "عنوان التذكير",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColors.DarkGreenColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.access_alarm,
                          color: AppColors.whiteColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
