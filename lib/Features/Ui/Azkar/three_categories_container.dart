import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class ThreeCategoriesContainer extends StatelessWidget {
  ThreeCategoriesContainer({
    super.key,
    required this.number,
    required this.title,
  });

  String number;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122.w,
      height: 76.h,
      decoration: BoxDecoration(
        color: AppColors.lightGreenColor2.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w400,
              fontFamily: "Cairo",
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w400,
              fontFamily: "Cairo",
            ),
          ),
        ],
      ),
    );
  }
}
