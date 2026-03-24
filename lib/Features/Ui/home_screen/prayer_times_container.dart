import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/home_screen/fard_column.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

class PrayerTimesContainer extends StatelessWidget {
  PrayerTimesContainer({super.key});

  final List<Map<String, String>> fardList = [
    {"name": "العشاء", "time": "45", "image": AppImages.ishaa},
    {"name": "المغرب", "time": "6:15", "image": AppImages.maghreb},
    {"name": "العصر", "time": "3:45", "image": AppImages.asr},
    {"name": "الضهر", "time": "6:45", "image": AppImages.duhr},
    {"name": "الفجر", "time": "5:15", "image": AppImages.fajr},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 270.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            //first row
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "12:30",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: AppColors.DarkGreenColor,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          "بعد ساعة و 15 دقيقة",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.GreyColor,
                            fontFamily: "Cairo",
                          ),
                        ),
                        SizedBox(height: 3.w),
                        Container(
                          width: 6.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.lightGreenColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "الصلاة القادمة",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.GreyColor,
                        fontFamily: "Cairo",
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "صلاة الظهر",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.BlackColor,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: AppColors.DarkGreenColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Image(image: AssetImage(AppImages.clockIcon)),
                ),
              ],
            ),
            SizedBox(height: 35.h),
            //second row
            Image(image: AssetImage(AppImages.homePageLine)),
            SizedBox(height: 40.h),

            Row(
              children: List.generate(fardList.length, (index) {
                final fardIndex = fardList[index];

                return Padding(
                  padding: EdgeInsets.only(
                    right: index == fardList.length - 1 ? 0 : 40,
                  ),
                  child: FardColumn(
                    fardImage: fardIndex["image"]!,
                    fardName: fardIndex["name"]!,
                    fardTime: fardIndex["time"]!,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
