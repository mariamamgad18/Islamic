import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class LocationContainer extends StatelessWidget {
  LocationContainer({
    super.key,
    required this.firstLocationTitle,
    required this.secondLocationTitle,
    required this.LocationImage,
  });

  String firstLocationTitle;

  String secondLocationTitle;

  String LocationImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        width: 382.w,
        height: 82.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Spacer(),
              Column(
                children: [
                  Text(
                    firstLocationTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.BlackColor,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    firstLocationTitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.GreyColor,
                      fontFamily: "Cairo",
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.semiwhiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image(image: AssetImage(LocationImage)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
