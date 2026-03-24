import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/quran/makkeia_or_madenia_or_all_container.dart';
import 'package:islamic/Features/Ui/quran/surah_ayah_safha_container.dart';
import 'package:islamic/Features/Ui/quran/surah_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

class QuranListPage extends StatefulWidget {
  QuranListPage({super.key});

  @override
  State<QuranListPage> createState() => _QuranListState();
}

class _QuranListState extends State<QuranListPage> {
  int SelectedItem = 0;

  final List<Map<String, String>> MakkeiaOrMadeniaList = [
    {"Title": "مكية", "num": "86"},
    {"Title": "مدنية", "num": "28"},
    {"Title": "الكل", "num": ""},
  ];
  final List<Map<String, dynamic>> SurahAyahSafhaList = [
    {"Title": "صفحة", "num": "604", "image": AppImages.safhaIcon},
    {
      "Title": "آية",
      "num": "6236",
      "image": AppImages.ayahIcon,
      "fontColor": AppColors.DarkYellowColor,
      "borderColor": AppColors.DarkYellowColor,
      "bgColor": AppColors.lightYellowColor,
    },
    {"Title": "سورة", "num": "114", "image": AppImages.SurahIcon},
  ];
  final List<Map<String, dynamic>> SurahList = [
    {
      "ArName": "الفاتحة",
      "EnName": "Al-Fatihah",
      "MakkeiaOrMadenia": "مكية",
      "numerOfAyah": "7",
    },
    {
      "ArName": "البقرة",
      "EnName": "Al-Baqarah",
      "MakkeiaOrMadenia": "مدنية",
      "numerOfAyah": "286",
    },
    {
      "ArName": "آل عمران",
      "EnName": "Ali 'Imran",
      "MakkeiaOrMadenia": "مدنية",
      "numerOfAyah": "200",
    },
    {
      "ArName": "النساء",
      "EnName": "An-Nisa",
      "MakkeiaOrMadenia": "مدنية",
      "numerOfAyah": "176",
    },
    {
      "ArName": "المائدة",
      "EnName": "Al-Ma'idah",
      "MakkeiaOrMadenia": "مدنية",
      "numerOfAyah": "120",
    },
    {
      "ArName": "الأنعام",
      "EnName": "Al-An'am",
      "MakkeiaOrMadenia": "مكية",
      "numerOfAyah": "165",
    },
    {
      "ArName": "الأعراف",
      "EnName": "Al-A'raf",
      "MakkeiaOrMadenia": "مكية",
      "numerOfAyah": "206",
    },
    {
      "ArName": "الأنفال",
      "EnName": "Al-Anfal",
      "MakkeiaOrMadenia": "مكية",
      "numerOfAyah": "75",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: Column(
        children: [
          //todo:Green Container +Search
          Container(
            width: double.infinity,
            height: 180.h,
            decoration: BoxDecoration(color: AppColors.DarkGreenColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "القرآن الكريم",
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Cairo",
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "114 سورة",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Cairo",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 90.w),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  //todo: Search
                  Container(
                    width: 350.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreenColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.GreyColor, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11.0,
                        vertical: 11,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "... ابحث عن سورة",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.semiwhiteColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Cairo",
                            ),
                          ),
                          Icon(Icons.search, color: AppColors.semiwhiteColor),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 57.h,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 15,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 20.w),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(MakkeiaOrMadeniaList.length, (
                        index,
                      ) {
                        final item = MakkeiaOrMadeniaList[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            right:
                                index == MakkeiaOrMadeniaList.length - 1
                                    ? 0
                                    : 8,
                          ),
                          child: MakkeiaOrMadeniaOrAllContainer(
                            isSelectd: SelectedItem == index,
                            onTap: () {
                              setState(() {
                                SelectedItem = index;
                              });
                            },
                            title: item["Title"]!,
                            number: item["num"]!,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 16.0.h, right: 20.w, left: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(SurahAyahSafhaList.length, (index) {
                final item2 = SurahAyahSafhaList[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == SurahAyahSafhaList.length - 1 ? 0 : 4,
                  ),
                  child: SurahAyahSafhaContainer(
                    Image2: item2["image"],
                    Title2: item2["Title"],
                    num: item2["num"],
                    bgColor: item2["bgColor"] ?? AppColors.lightGreenColor,
                    borderColor:
                        item2["borderColor"] ?? AppColors.DarkGreenColor,
                    TitleColor: item2["fontColor"] ?? AppColors.DarkGreenColor,
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.builder(
              //physics: NeverScrollableScrollPhysics(),
              itemCount: SurahList.length,
              itemBuilder: (context, index) {
                final surah = SurahList[index];

                return SurahContainer(
                  SurahArabicName: surah["ArName"],
                  SurahENglishName: surah["EnName"],
                  MakiaOrMadenia: surah["MakkeiaOrMadenia"],
                  AyahCount: surah["numerOfAyah"],
                  counter: (index + 1).toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
