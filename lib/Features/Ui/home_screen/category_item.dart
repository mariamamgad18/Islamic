import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({
    super.key,
    required this.isYellow,
    this.isGridView = "true",
    required this.iconImage,
    required this.CategoryDesc,
    required this.CategoryTitle,
  });

  String isYellow;
  String iconImage;
  String CategoryTitle;
  String CategoryDesc;
  String isGridView;

  @override
  Widget build(BuildContext context) {
    if (isGridView == "true") {
      return Container(
        width: 189.w,
        height: 162.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color:
                      (isYellow == "true")
                          ? AppColors.DarkYellowColor
                          : AppColors.DarkGreenColor,
                ),
                child: Image(image: AssetImage(iconImage)),
              ),
              SizedBox(height: 16.h),
              Text(
                CategoryTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.BlackColor,
                  fontFamily: "Cairo",
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                CategoryDesc,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.GreyColor,
                  fontFamily: "Cairo",
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: 390.w,
        height: 98.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    CategoryTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.BlackColor,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    CategoryDesc,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.GreyColor,
                      fontFamily: "Cairo",
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color:
                      (isYellow == "true")
                          ? AppColors.DarkYellowColor
                          : AppColors.DarkGreenColor,
                ),
                child: Image(image: AssetImage(iconImage)),
              ),
            ],
          ),
        ),
      );
    }
  }
}
