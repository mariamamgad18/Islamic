import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/language_selection_screen/language_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_routes.dart';

import '../../../core/Utils/app_images.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  //لو 0 ف هيبقي اول عنصر Selected
  int SelectedLanguage = -1;
  final List<Map<String, String>> Languages = [
    {"first": "العربية", "second": "Arabic", "flag": AppImages.ArIcon},
    {"first": "English", "second": "English", "flag": AppImages.EnIcon},
    {"first": "اردو", "second": "Urdu", "flag": AppImages.UrIcon},
    {"first": "Français", "second": "French", "flag": AppImages.FrIcon},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage(AppImages.SelectLanguageScreenBackGround),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 102.h,
              bottom: 94.h,
              left: 24.w,
              right: 24.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 96.w,
                    height: 96.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 25,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: AppColors.DarkGreenColor,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Image(image: AssetImage(AppImages.LanguageIcon)),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    " اختر اللغة",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: AppColors.BlackColor,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    " Select Your Preferred Language",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.BlackColor,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 40.h),

                  ...List.generate(Languages.length, (index) {
                    final lang = Languages[index];
                    return LanguageContainer(
                      firstLanguageTitle: lang["first"]!,
                      SecondtLanguageTitle: lang["second"]!,
                      flagImage: lang["flag"]!,
                      isSelected: SelectedLanguage == index,
                      onTap: () {
                        setState(() {
                          SelectedLanguage = index;
                        });
                      },
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
                        Navigator.of(context).pushReplacementNamed(
                          AppRoutes.LocationPermissionScreenRoutename,
                        );
                      },
                      child: Text(
                        "متابعة",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.whiteColor,
                          fontFamily: "Cairo",
                        ),
                      ),
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
