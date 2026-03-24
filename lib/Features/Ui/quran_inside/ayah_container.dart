import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class AyahContainer extends StatelessWidget {
  AyahContainer({super.key, required this.counter, required this.ayah});

  String counter;
  String ayah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, right: 20.0.w, left: 20.w),
      child: Container(
        width: 390.w,
        // height:94.h ,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            bottom: 32.h,
            right: 20.0.w,
            left: 20.w,
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.DarkGreenColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    counter,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cairo",
                    ),
                  ),
                ),
              ),
              SizedBox(width: 120.w),
              Expanded(
                child: Text(
                  ayah,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.BlackColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Amiri",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
