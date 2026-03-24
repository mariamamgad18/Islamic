import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_images.dart';

import '../../../core/Utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //todo: عشان نظبط الduration :
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.OnBoardingScreenRoutename,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage(AppImages.SplashScreenBackGround),
          width: double.infinity,
          height: double.infinity,
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 303.5.h, horizontal: 55.05.w),
          child: Container(
            height: 325.h,
            width: 319.89.w,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(AppImages.SplashScreenContent),
            ),
          ),
        ),
      ],
    );
  }
}

/*
 Column(
mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Image(
           image: AssetImage(AppImages.SplashScreenIcon,),
           width: 96.w,
           height:96.h),
         SizedBox(height: 32.h),
         Text("المصحف الشريف",style: TextStyle(
           color: AppColors.whiteColor,
           fontSize: 36,
           fontWeight: FontWeight.w500,
           fontFamily: "Cairo",

         ),),
         SizedBox(height: 32.h),
         Image(
             image: AssetImage(AppImages.SplashScreenQuran,),
             width: 255.89.w,
             height:40.h),
         SizedBox(height:8.h),
         Text("سورة المزمل - آية 4",style: TextStyle(
           color: AppColors.whiteColor,
           fontSize: 14,
           fontWeight: FontWeight.w500,
           fontFamily: "Cairo",

         ),),
         SizedBox(height: 48.h),
         Image(
             image: AssetImage(AppImages.SplashScreenThreeDots,),
             width: 255.89.w,
             height:40.h),

       ],),

 */
