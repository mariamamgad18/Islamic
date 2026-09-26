import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

import '../../../l10n/app_localizations.dart';

class CounterSebhaContainer extends StatefulWidget {
  const CounterSebhaContainer({
    super.key,
    required this.tasbeehTitle,
    required this.targetCount,
  });

  final String tasbeehTitle;
  final int targetCount;

  @override
  State<CounterSebhaContainer> createState() =>
      _CounterSebhaContainerState();
}

class _CounterSebhaContainerState extends State<CounterSebhaContainer> {
  int counter = 0;

  @override
  void didUpdateWidget(covariant CounterSebhaContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // لو التسبيحة أو العدد المستهدف اتغير
    // نبدأ العد من الصفر
    if (oldWidget.tasbeehTitle != widget.tasbeehTitle ||
        oldWidget.targetCount != widget.targetCount) {
      counter = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final double progress =
    widget.targetCount > 0
        ? (counter / widget.targetCount).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      width: 385.w,
      height: 678.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(AppImages.tasbeehbackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 40.h,
          horizontal: 32.w,
        ),
        child: Column(
          children: [
            Text(
              widget.tasbeehTitle,
              style: TextStyle(
                fontSize: 30,
                color: AppColors.DarkGreenColor,
                fontWeight: FontWeight.w500,
                fontFamily: "Amiri",
              ),
            ),

            SizedBox(height: 24.h),

            // ================= COUNTER =================

            Container(
              width: 200.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 8,
                  color: AppColors.DarkGreenColor,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // العدد الحالي
                  Text(
                    counter.toString(),
                    style: TextStyle(
                      fontSize: 60,
                      color: AppColors.BlackColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                    ),
                  ),

                  // العدد المستهدف
                  Text(
                    "/ ${widget.targetCount}",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.GreyColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Progress
                  SizedBox(
                    width: 80.w,
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      color: AppColors.lightOrange,
                      backgroundColor: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // ================= TASBEEH BUTTON =================

            InkWell(
              borderRadius: BorderRadius.circular(60),
              onTap: () {
                setState(() {
                  // العداد يقف عند العدد المستهدف
                  if (counter < widget.targetCount) {
                    counter++;
                  }
                });
              },
              child: Container(
                width: 128.w,
                height: 128.h,
                decoration: BoxDecoration(
                  color: AppColors.DarkGreenColor,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.tasbeeh,
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),

                    Text(
                      l10n.tapToCount,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // ================= DIVIDER =================

            Container(
              width: 300.w,
              height: 1.h,
              decoration: BoxDecoration(
                color: AppColors.lightGreyColor,
              ),
            ),

            SizedBox(height: 30.h),

            // ================= RESET =================

            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                setState(() {
                  counter = 0;
                });
              },
              child: Container(
                height: 40.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.GreyColor,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 40.w,
                  ),
                  child: Row(
                    children: [
                      Text(
                        l10n.reset,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.BlackColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),

                      SizedBox(width: 7.w),

                      Icon(
                        Icons.update,
                        color: AppColors.BlackColor,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}