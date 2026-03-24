import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class AzkarContainer extends StatelessWidget {
  AzkarContainer({
    super.key,
    required this.containerImage,
    required this.containerEmoji,
    required this.azkarTitle,
    required this.azkarCount,
  });

  String containerImage;
  String containerEmoji;
  String azkarTitle;
  String azkarCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 144.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(containerImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(containerEmoji, style: TextStyle(fontSize: 25)),
            SizedBox(height: 30.h),
            Row(
              children: [
                Icon(
                  Icons.keyboard_arrow_left_sharp,
                  color: AppColors.whiteColor,
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      azkarTitle,
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      azkarCount,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
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
