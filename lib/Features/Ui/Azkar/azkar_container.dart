import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class AzkarContainer extends StatelessWidget {
  final String containerImage;
  final String containerEmoji;
  final String azkarTitle;
  final String azkarCount;
  final VoidCallback onTap;

  const AzkarContainer({
    super.key,
    required this.containerImage,
    required this.containerEmoji,
    required this.azkarTitle,
    required this.azkarCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(20.r),

      child: Container(
        width: 200.w,
        height: 144.h,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),

          image: DecorationImage(
            image: AssetImage(containerImage),
            fit: BoxFit.fill,
          ),
        ),

        child: Padding(
          padding: EdgeInsets.all(20.w),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [

              Text(
                containerEmoji,
                style: TextStyle(
                  fontSize: 25.sp,
                ),
              ),

              SizedBox(height: 30.h),

              Row(
                children: [

                  Icon(
                    Icons.keyboard_arrow_left_sharp,
                    color: AppColors.whiteColor,
                  ),

                  const Spacer(),

                  Expanded(
                    child: Text(
                      azkarTitle,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}