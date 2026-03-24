import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

class MapContainer extends StatelessWidget {
  const MapContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430.w,
      height: 255.h,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AppImages.MapBG)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.0.h),
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Icon(
                  Icons.location_on_outlined,
                  size: 55,
                  color: AppColors.DarkGreenColor,
                ),
              ),
            ),
          ),

          //todo: عرض علي الخريطه
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                top: 39.0.h,
                right: 261.w,
                left: 16.w,
                bottom: 16.h,
              ),
              child: Container(
                width: 152.98.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Text(
                        "عرض على الخريطة",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.DarkGreenColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(
                        Icons.send_outlined,
                        size: 14,
                        color: AppColors.DarkGreenColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
