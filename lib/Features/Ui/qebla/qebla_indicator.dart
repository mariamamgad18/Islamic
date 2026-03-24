import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_images.dart';

import '../../../core/Utils/app_colors.dart';

class QeblaIndicator extends StatelessWidget {
  QeblaIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 384.w,
          height: 384.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.Bosla),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Text(
                "شمال",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cairo",
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0.w,
                  vertical: 126.h,
                ),
                child: Row(
                  children: [
                    Text(
                      "غرب",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                    Spacer(),
                    Text(
                      "شرق",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "جنوب",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cairo",
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 120.0.h, horizontal: 85.w),
          child: Image(image: AssetImage(AppImages.qiblaIcon)),
        ),
      ],
    );
  }
}

/*


          Text(
              "شمال",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.BlackColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Cairo",
              ),
            ),

            Text(
              "جنوب",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.BlackColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Cairo",
              ),
            ),

 */
