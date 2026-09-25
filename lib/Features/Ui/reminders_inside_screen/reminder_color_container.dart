import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class ReminderColorContainer extends StatefulWidget {
  ReminderColorContainer({
    super.key,
    required this.ContainerColor,
    required this.onColorSelected,
  });

  Color ContainerColor;

  final Function(Color) onColorSelected;

  @override
  State<ReminderColorContainer> createState() =>
      _ReminderColorContainerState();
}

class _ReminderColorContainerState extends State<ReminderColorContainer> {
  bool isColorSelcted = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isColorSelcted = !isColorSelcted;
        });

        if (isColorSelcted) {
          widget.onColorSelected(
            widget.ContainerColor,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.ContainerColor,
            border: Border.all(
              color:
              isColorSelcted
                  ? AppColors.DarkGreenColor
                  : AppColors.transparent,
              width: isColorSelcted ? 1 : 80,
            ),
          ),
        ),
      ),
    );
  }
}
