import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/reminders/add_new_reminder_container.dart';
import 'package:islamic/Features/Ui/reminders/nasiha_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_routes.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //todo:green Container
          Container(
            width: double.infinity,
            height: 84,
            color: AppColors.DarkGreenColor,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.RemindersInsideScreenRoutename);
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreyColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: AppColors.whiteColor),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "التذكيرات",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ),

          Expanded(child: ListView(children: [])),
          Spacer(),
          AddNewReminderContainer(),
          SizedBox(height: 16.h),
          NasihaContainer(),
        ],
      ),
    );
  }
}
