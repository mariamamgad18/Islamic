import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/home_screen/ayah_container.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/core/Utils/app_routes.dart';
import 'package:islamic/l10n/app_localizations.dart';

import '../../../core/Utils/app_colors.dart';
import 'category_item.dart';

class HomeContent extends StatelessWidget {
  HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

// =========================================================
// GRID CATEGORIES
// =========================================================

    final List<Map<String, String>> categoriesList = [
      {
        "key": "mushaf",
        "Title": localizations.mushafShort,
        "desc": localizations.readQuran,
        "isyellow": "false",
        "image": AppImages.categ1,
      },
      {
        "key": "azkar",
        "Title": localizations.duasAndAzkar,
        "desc": localizations.hisnAlMuslim,
        "isyellow": "true",
        "image": AppImages.categ2,
      },
      {
        "key": "quranLearning",
        "Title": localizations.quranLearning,
        "desc": localizations.lessonsAndRecitations,
        "isyellow": "false",
        "image": AppImages.categ3,
      },
      {
        "key": "adhan",
        "Title": localizations.adhan,
        "desc": localizations.prayerTimesShort,
        "isyellow": "true",
        "image": AppImages.categ4,
      },
      {
        "key": "reminders",
        "Title": localizations.reminders,
        "desc": localizations.dailyNotifications,
        "isyellow": "false",
        "image": AppImages.categ5,
      },
      {
        "key": "mosques",
        "Title": localizations.mosques,
        "desc": localizations.nearestMosques,
        "isyellow": "true",
        "image": AppImages.categ6,
      },
    ];

// =========================================================
// LIST CATEGORIES
// =========================================================

    final List<Map<String, String>> categoriesList2 = [
      {
        "key": "tasbeeh",
        "Title": localizations.tasbeeh,
        "desc": localizations.tasbeehCounter,
        "isyellow": "false",
        "image": AppImages.categ7,
        "isGridview": "false",
      },
      {
        "key": "qibla",
        "Title": localizations.qiblaDirection,
        "desc": localizations.findQiblaDirection,
        "isyellow": "true",
        "image": AppImages.categ8,
        "isGridview": "false",
      },
    ];

    return Column(
      children: [
// =====================================================
// AYAH CONTAINER
// =====================================================

        AyahContainerr(),

// =====================================================
// GRID VIEW
// =====================================================

        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Container(
            height: 600,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                final category = categoriesList[index];

                final key = category["key"]!;

                return InkWell(
                  onTap: () {
// ==========================================
// FEATURES UNDER DEVELOPMENT
// ==========================================

                    if (key == "mosques" ||
                        key == "quranLearning") {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),

                            title: Text(
                              localizations.comingSoon,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            content: Text(
                              localizations.featureUnderDevelopment,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "Cairo",
                                fontSize: 14,
                              ),
                            ),

                            actionsAlignment: MainAxisAlignment.center,

                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  localizations.ok,
                                  style: TextStyle(
                                    fontFamily: "Cairo",
                                    color: AppColors.DarkGreenColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

// ==========================================
// AVAILABLE FEATURES
// ==========================================

                    String targetPage = "";

                    if (key == "mushaf") {
                      targetPage =
                          AppRoutes.QuranScreenRoutename;
                    } else if (key == "azkar") {
                      targetPage =
                          AppRoutes.AzkarScreenRoutename;
                    } else if (key == "adhan") {
                      targetPage =
                          AppRoutes.AzanScreenRoutename;
                    } else if (key == "reminders") {
                      targetPage =
                          AppRoutes.RemindersScreenRoutename;
                    }

                    if (targetPage.isNotEmpty) {
                      Navigator.pushNamed(
                        context,
                        targetPage,
                      );
                    }
                  },

                  child: CategoryItem(
                    iconImage: category["image"]!,
                    CategoryDesc: category["desc"]!,
                    CategoryTitle: category["Title"]!,
                    isYellow: category["isyellow"]!,
                  ),
                );
              },
            ),
          ),
        ),

// =====================================================
// LIST VIEW
// =====================================================

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Container(
            height: 300,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),

              itemBuilder: (context, index) {
                final category =
                categoriesList2[index];

                final key = category["key"]!;

                String targetPage = "";

                if (key == "tasbeeh") {
                  targetPage =
                      AppRoutes.TasbihScreenRoutename;
                } else if (key == "qibla") {
                  targetPage =
                      AppRoutes.QiblaScreenRoutename;
                }

                return InkWell(
                  onTap: () {
                    if (targetPage.isNotEmpty) {
                      Navigator.pushNamed(
                        context,
                        targetPage,
                      );
                    }
                  },

                  child: CategoryItem(
                    iconImage: category["image"]!,
                    CategoryDesc: category["desc"]!,
                    CategoryTitle: category["Title"]!,
                    isYellow: category["isyellow"]!,
                    isGridView:
                    category["isGridview"]!,
                  ),
                );
              },

              separatorBuilder: (context, index) {
                return SizedBox(height: 12.h);
              },

              itemCount: categoriesList2.length,
            ),
          ),
        ),
      ],
    );
  }
}
