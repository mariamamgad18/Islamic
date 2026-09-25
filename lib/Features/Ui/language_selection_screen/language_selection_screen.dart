import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/language_selection_screen/language_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/core/Utils/app_routes.dart';
import 'package:islamic/core/Utils/language_manager.dart';

import '../../../l10n/app_localizations.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {

// اللغة المختارة
  int selectedLanguage = -1;

// اللغات
  final List<Map<String, String>> languages = [
    {
      "first": "العربية",
      "second": "Arabic",
      "flag": AppImages.ArIcon,
      "code": "ar",
    },
    {
      "first": "English",
      "second": "English",
      "flag": AppImages.EnIcon,
      "code": "en",
    },
    {
      "first": "اردو",
      "second": "Urdu",
      "flag": AppImages.UrIcon,
      "code": "ur",
    },
    {
      "first": "Français",
      "second": "French",
      "flag": AppImages.FrIcon,
      "code": "fr",
    },
  ];

  @override
  void initState() {
    super.initState();

// لو فيه لغة محفوظة قبل كده نحددها تلقائيًا
    _loadSelectedLanguage();
  }

  void _loadSelectedLanguage() {
    final currentLanguage =
        LanguageManager.currentLanguageCode;

    final index = languages.indexWhere(
          (language) => language["code"] == currentLanguage,
    );

    if (index != -1) {
      setState(() {
        selectedLanguage = index;
      });
    }
  }

  Future<void> _continue() async {
    if (selectedLanguage == -1) {
      return;
    }

    final languageCode = languages[selectedLanguage]['code']!;

    await LanguageManager.changeLanguage(languageCode);

    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed(
      AppRoutes.LocationPermissionScreenRoutename,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage(
              AppImages.SelectLanguageScreenBackGround,
            ),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
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
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: AppColors.DarkGreenColor,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Image(
                      image: AssetImage(
                        AppImages.LanguageIcon,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    AppLocalizations.of(context)!.chooseLanguage,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: AppColors.BlackColor,
                      fontFamily: "Cairo",
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    "Select Your Preferred Language",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.BlackColor,
                      fontFamily: "Cairo",
                    ),
                  ),

                  SizedBox(height: 40.h),

                  ...List.generate(
                    languages.length,
                        (index) {
                      final language = languages[index];

                      return LanguageContainer(
                        firstLanguageTitle:
                        language["first"]!,
                        SecondtLanguageTitle:
                        language["second"]!,
                        flagImage:
                        language["flag"]!,
                        isSelected:
                        selectedLanguage == index,
                        onTap: () {
                          setState(() {
                            selectedLanguage = index;
                          });
                        },
                      );
                    },
                  ),

                  SizedBox(height: 20.h),

                  SizedBox(
                    width: 382.w,
                    height: 56.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(24),
                        ),
                        backgroundColor:
                        AppColors.DarkGreenColor,
                      ),
                      onPressed: _continue,
                      child: Text(
                        AppLocalizations.of(context)!.continuee,
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
