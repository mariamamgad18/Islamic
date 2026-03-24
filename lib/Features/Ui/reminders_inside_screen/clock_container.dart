import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/app_colors.dart';

class ClockContainer extends StatelessWidget {
  ClockContainer({super.key, required this.onTimeSelected});

  final Function(TimeOfDay) onTimeSelected;

  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 462.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: TextField(
        controller: timeController,
        readOnly: true,
        style: TextStyle(color: AppColors.BlackColor, fontSize: 16),
        decoration: InputDecoration(border: InputBorder.none),
        onTap: () async {
          // هعمل var اسمه : pickedTime
          // نوعه TimeOfDay?

          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            // الساعه تفتح ع الوقت الحالي
            initialTime: TimeOfDay.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.DarkGreenColor,
                    // لون الزرار و الساعة
                    onPrimary: Colors.white,
                    // لون النص جواه
                    onSurface: AppColors.BlackColor, // لون الأرقام
                  ),

                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          AppColors.DarkGreenColor, // لون OK و Cancel
                    ),
                  ),
                ),

                child: child!,
              );
            },
          );
          if (pickedTime != null) {
            // هنا عشان اتشيك ازا كان اختار وقت ولا قفل الساعه من غير م يختار
            //لو اختار هنخليها تسمع ف ال ui
            onTimeSelected(pickedTime); // 👈 أهم سطر
          }
        },
      ),
    );
  }
}
