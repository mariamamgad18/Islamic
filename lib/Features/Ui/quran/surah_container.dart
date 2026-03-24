import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

import '../quran_inside/quran_inside_page.dart';

class SurahContainer extends StatelessWidget {
  SurahContainer({
    super.key,
    required this.SurahArabicName,
    required this.MakiaOrMadenia,
    required this.AyahCount,
    required this.SurahENglishName,
    required this.counter,
  });

  String counter;
  String SurahArabicName;
  String SurahENglishName;
  String AyahCount;
  String MakiaOrMadenia;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => QuranInsidePage(
                    SuraName: SurahArabicName,
                    AyahCount2: AyahCount,
                    MakiaOrMadenia2: MakiaOrMadenia,
                  ),
            ),
          );
        },
        child: Container(
          width: 389.w,
          height: 85.h,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  child: Stack(
                    children: [
                      Image(image: AssetImage(AppImages.numberIcon)),
                      Center(
                        child: Text(
                          counter,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.DarkGreenColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      SurahArabicName,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "$SurahENglishName · $AyahCount آية ",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.GreyColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.w),
                if (MakiaOrMadenia == "مكية")
                  Container(
                    width: 42.44.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreenColor2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "مكية",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.DarkGreenColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cairo",
                        ),
                      ),
                    ),
                  ),
                if (MakiaOrMadenia == "مدنية")
                  Container(
                    width: 42.44.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightYellowColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "مدنية",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.DarkYellowColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cairo",
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
