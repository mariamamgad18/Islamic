import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/quran_inside/ayah_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

class QuranInsidePage extends StatefulWidget {
  QuranInsidePage({
    super.key,
    this.SuraName = "",
    this.AyahCount2 = "",
    this.MakiaOrMadenia2 = "",
  });

  String SuraName;
  String AyahCount2;
  String MakiaOrMadenia2;

  @override
  State<QuranInsidePage> createState() => _QuranInsidePageState();
}

class _QuranInsidePageState extends State<QuranInsidePage> {
  String SelectedLanguage = "العربية";

  final List<Map<String, dynamic>> AlFatihaVerses = [
    {"ayah": "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِیمَِ"},
    {"ayah": "ٱلۡحَمۡدُ لِلَّهِ رَبِّ ٱلۡعَـٰلَمِینَ"},
    {"ayah": "ٱلرَّحۡمَـٰنِ ٱلرَّحِیمَِ"},
    {"ayah": "مَـٰلِكِ یَوۡمِ ٱلدِّینَِِ"},
    {"ayah": "إِیَّاكَ نَعۡبُدُ وَإِیَّاكَ نَسۡتَعِینَُِ"},
    {"ayah": "ٱهۡدِنَا ٱلصِّرَ ٰ⁠طَ ٱلۡمُسۡتَقِیمَ"},
    {
      "ayah":
          "صِرَ ٰ⁠طَ ٱلَّذِینَ أَنۡعَمۡتَ عَلَیۡهِمۡ غَیۡرِ ٱلۡمَغۡضُوبِ عَلَیۡهِمۡ وَلَا ٱلضَّاۤلِّینََ",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: Column(
        children: [
          //todo:green Container
          Container(
            width: double.infinity,
            height: 120.h,
            color: AppColors.DarkGreenColor,
            child: Padding(
              padding: EdgeInsets.only(
                top: 25.0.h,
                left: 20.w,
                right: 20.w,
                bottom: 24.h,
              ),
              child: Row(
                children: [
                  Image(image: AssetImage(AppImages.saveIcon)),
                  SizedBox(width: 12.w),
                  Image(image: AssetImage(AppImages.SoundIcon)),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        "سورة ${widget.SuraName} ",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cairo",
                        ),
                      ),
                      SizedBox(height: 4.w),

                      Text(
                        "${widget.MakiaOrMadenia2} -  ${widget.AyahCount2} آية",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cairo",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ),
          //todo:(Zoom + language) Container
          Container(
            width: double.infinity,
            height: 61,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.BlackColor.withOpacity(0.10),
                  blurRadius: 15,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 60.88,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.DarkGreenColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        SelectedLanguage,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cairo",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 37.w),
                  Image(image: AssetImage(AppImages.languageIcon2)),
                  SizedBox(width: 5.w),

                  DropdownButton<String>(
                    value: SelectedLanguage,
                    underline: SizedBox(),

                    icon: Icon(Icons.keyboard_arrow_down),
                    // شكل السهم
                    iconSize: 24,
                    // حجم السهم
                    iconEnabledColor: AppColors.GreyColor,
                    // لون السهم
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.BlackColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cairo",
                    ),
                    items:
                        ["العربية", "English", "اردو", "Français"].map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(width: 50.w),
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.semiwhiteColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppColors.lightGreyColor,
                        width: 1,
                      ),
                    ),
                    child: Icon(Icons.zoom_in, color: AppColors.BlackColor),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "20px",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.GreyColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.semiwhiteColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppColors.lightGreyColor,
                        width: 1,
                      ),
                    ),
                    child: Icon(Icons.zoom_out, color: AppColors.BlackColor),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: AlFatihaVerses.length,
              itemBuilder: (context, index) {
                final fatihaIndex = AlFatihaVerses[index];
                return AyahContainer(
                  counter: (index + 1).toString(),
                  ayah: fatihaIndex["ayah"],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 50.h),
            child: Row(
              children: [
                Container(
                  width: 188.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    border: Border.all(
                      color: AppColors.lightGreyColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8.0.h,
                      bottom: 8.h,
                      left: 30.w,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "السورة السابقة",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.lightGreyColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Cairo",
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: AppColors.lightGreyColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 13.w),
                Container(
                  width: 188.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: AppColors.DarkGreenColor,
                    border: Border.all(
                      color: AppColors.lightGreyColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8.0.h,
                      bottom: 8.h,
                      left: 30.w,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, color: AppColors.whiteColor),
                        SizedBox(width: 14.w),

                        Text(
                          "السورة التالية ",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
