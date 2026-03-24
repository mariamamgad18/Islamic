import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/location_permission_screen/location_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_routes.dart';

import '../../../core/Utils/app_images.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> LocationOptions = [
      {
        "firstTitle": "أوقات الصلاة الدقيقة",
        "SecondTitle": "حساب دقيق بناءً على موقعك",
        "image": AppImages.secondIcon,
      },
      {
        "firstTitle": "المساجد القريبة",
        "SecondTitle": "اكتشف المساجد من حولك",
        "image": AppImages.firstIcon,
      },
      {
        "firstTitle": "خصوصية محمية",
        "SecondTitle": "بياناتك آمنة ومحمية",
        "image": AppImages.thirdIcon,
      },
    ];
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage(AppImages.SelectLocationScreenBackGround),
            width: double.infinity,
            height: double.infinity,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 91.0.h, horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 154.24.w,
                    height: 154.24.h,
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: AppColors.semiYellowColor,
                        width: 4,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.1),
                      child: Container(
                        width: 131.w,
                        height: 131.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: AppColors.transparent,
                          border: Border.all(
                            color: AppColors.semiGreenColor,
                            width: 4,
                          ),
                        ),
                        child: Container(
                          width: 129.w,
                          height: 129.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: AppColors.DarkGreenColor,
                          ),
                          child: Image(
                            image: AssetImage(AppImages.LocationIcon),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    "تحديد الموقع",
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColors.BlackColor,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Text(
                    "نحتاج إلى موقعك لحساب أوقات الصلاة الدقيقة في منطقتك وإظهار المساجد القريبة منك",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.GreyColor,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 32.h),

                  ...List.generate(LocationOptions.length, (index) {
                    final loc = LocationOptions[index];
                    return LocationContainer(
                      firstLocationTitle: loc["firstTitle"]!,
                      secondLocationTitle: loc["SecondTitle"]!,
                      LocationImage: loc["image"]!,
                    );
                  }),
                  SizedBox(height: 20.h),

                  SizedBox(
                    width: 382.w,
                    height: 56.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        backgroundColor: AppColors.DarkGreenColor,
                      ),
                      onPressed: () {
                        // Navigator.of(context).pushReplacementNamed(AppRoutes.LocationPermissionScreenRoutename);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 50.w,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "السماح بالوصول للموقع",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.whiteColor,
                                fontFamily: "Cairo",
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Image(image: AssetImage(AppImages.fourthIcon)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRoutes.HomeScreenRoutename);
                    },
                    child: Text(
                      "تخطي الآن",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.GreyColor,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.0.w),
                    child: Row(
                      children: [
                        Text(
                          "يمكنك تغيير هذا الإعداد لاحقًا من الإعدادات",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.GreyColor,
                            fontFamily: "Cairo",
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Image(image: AssetImage(AppImages.fifthIcon)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
 children: [
    Image(
    image: AssetImage(AppImages.SelectLanguageScreenBackGround,),
    width: double.infinity,
    height: double.infinity,),
    Padding(
    padding:  EdgeInsets.only(top: 102.h,bottom: 94.h,left: 24.w,right: 24.w),
    child: SingleChildScrollView(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,

    );
 */
