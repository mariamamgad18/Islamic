import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

class CounterSebhaContainer extends StatefulWidget {
  CounterSebhaContainer({super.key, required this.tasbeehTitle});

  final String tasbeehTitle;

  @override
  State<CounterSebhaContainer> createState() => _CounterSebhaContainerState();
}

class _CounterSebhaContainerState extends State<CounterSebhaContainer> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385.w,
      height: 678.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(AppImages.tasbeehbackground)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0.h, horizontal: 32.w),
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
            Container(
              width: 200.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 8, color: AppColors.DarkGreenColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    counter.toString(),
                    style: TextStyle(
                      fontSize: 60,
                      color: AppColors.BlackColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                    ),
                  ),
                  Text(
                    "من 33",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.GreyColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 5.h),
                  //todo: line
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.1416), // 180 درجة
                    child: Container(
                      width: 80.w, // العرض اللي انتي عايزاه
                      child: LinearProgressIndicator(
                        value: counter / 33,
                        minHeight: 8,
                        color: AppColors.lightOrange,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            InkWell(
              onTap: () {
                setState(() {
                  if (counter < 34) {
                    counter++;
                  }
                  if (counter == 34) {
                    counter = 0;
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
                      "تسبيح",
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),
                    Text(
                      "اضغط للعد",
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
            SizedBox(height: 50.h),
            Container(
              width: 300.w,
              height: 1.h,
              decoration: BoxDecoration(color: AppColors.lightGreyColor),
            ),
            SizedBox(height: 30.h),

            InkWell(
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
                  border: Border.all(color: AppColors.GreyColor, width: 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0.h,
                    horizontal: 40.w,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "إعادة تعيين",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.BlackColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Icon(Icons.update, color: AppColors.BlackColor, size: 15),
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
