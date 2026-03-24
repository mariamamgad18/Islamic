import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/Nearby_Mosques_screen/map_container.dart';
import 'package:islamic/Features/Ui/Sebha/mosque_container.dart';
import 'package:islamic/Features/Ui/home_screen/ayah_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class NearbyMosquesScreen extends StatelessWidget {
  const NearbyMosquesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: Column(
        children: [
          //todo: Green Container:
          Container(
            width: 430.w,
            height: 132.h,
            decoration: BoxDecoration(color: AppColors.DarkGreenColor),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0.h, horizontal: 25.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "المساجد القريبة",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Text(
                        "الموقع الحالي: الرياض",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cairo",
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          MapContainer(),
          MosqueContainer(
            address: "شارع الملك فهد، الرياض",
            distanceBetweenYourCurrentLocationAndMosque: 0.5,
            MosqueName: "الجامع الكبير",
            counter: 1,
          ),

          Spacer(),
          AyahContainerr(
            ayahWidth: 382,
            ayahHeight: 280,
            topPadding: 16,
            title: 'حديث شريف',
            subTitle:
                "مَنْ غَدَا إِلَى الْمَسْجِدِ أَوْ رَاحَ، أَعَدَّ اللَّهُ لَهُ فِي الْجَنَّةِ نُزُلًا",
            lastLine: "رواه البخاري ومسلم",
          ),
        ],
      ),
    );
  }
}
