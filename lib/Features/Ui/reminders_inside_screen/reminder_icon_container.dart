import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class ReminderIconContainer extends StatefulWidget {
  ReminderIconContainer({super.key, required this.containerImage2});

  String containerImage2;

  @override
  State<ReminderIconContainer> createState() => _ReminderIconContainerState();
}

class _ReminderIconContainerState extends State<ReminderIconContainer> {
  bool isIconSelcted = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isIconSelcted = !isIconSelcted;
        });
      },
      child: Container(
        width: 86.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              isIconSelcted
                  ? AppColors.lightGreenColor2
                  : AppColors.semiwhiteColor,
          border: Border.all(
            color:
                isIconSelcted
                    ? AppColors.DarkGreenColor
                    : AppColors.lightGreenColor2,
            width: isIconSelcted ? 2 : 1,
          ),
        ),
        child: Center(child: Image(image: AssetImage(widget.containerImage2))),
      ),
    );
  }
}
