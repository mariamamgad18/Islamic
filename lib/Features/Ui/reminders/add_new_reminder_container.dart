import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_routes.dart';

import '../../../core/Utils/app_colors.dart';

class AddNewReminderContainer extends StatelessWidget {
  const AddNewReminderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(AppRoutes.RemindersInsideScreenRoutename);
      },
      child: Container(
        width: 382.w,
        height: 76.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.lightGreyColor, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "إضافة تذكير جديد",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.GreyColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Cairo",
              ),
            ),
            SizedBox(width: 12.w),
            Icon(Icons.add, size: 16, color: AppColors.GreyColor),
          ],
        ),
      ),
    );
  }
}
