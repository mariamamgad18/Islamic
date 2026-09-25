import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Domain/entities/response/quran_info/chapter.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/l10n/app_localizations.dart';

import '../quran_inside/quran_inside_page.dart';

class SurahContainer extends StatelessWidget {
  final Chapter chapter;

// =========================================================
// All chapters from API
// Used for Previous / Next Surah navigation
// =========================================================

  final List<Chapter> chapters;

  const SurahContainer({
    super.key,
    required this.chapter,
    required this.chapters,
  });

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    final bool isMakki =
        chapter.revelationPlace.toLowerCase() ==
            'makkah';

// =========================================================
// Localized revelation place
// =========================================================

    final String revelationPlace = isMakki
        ? localizations.meccan
        : localizations.medinan;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  QuranInsidePage(
// =================================================
// Current Surah
// =================================================

                    chapterId: chapter.id,

// =================================================
// All 114 Surahs from API
// =================================================

                    chapters: chapters,
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
// ==========================================
// Surah number
// ==========================================

                SizedBox(
                  width: 48.w,
                  height: 48.h,
                  child: Stack(
                    children: [
                      const Image(
                        image: AssetImage(
                          AppImages.numberIcon,
                        ),
                      ),

                      Center(
                        child: Text(
                          chapter.id.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color:
                            AppColors.DarkGreenColor,
                            fontWeight:
                            FontWeight.w400,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

// ==========================================
// Names + Ayah count
// ==========================================

                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.end,
                  children: [
                    Text(
                      chapter.nameArabic,
                      style: TextStyle(
                        fontSize: 18,
                        color:
                        AppColors.BlackColor,
                        fontWeight:
                        FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      "${chapter.nameSimple} · ${localizations.ayahCount(
                          chapter.versesCount)}",
                      style: TextStyle(
                        fontSize: 12,
                        color:
                        AppColors.GreyColor,
                        fontWeight:
                        FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 16.w),

// ==========================================
// Makki / Madani
// ==========================================

                Container(
                  width: 55.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: isMakki
                        ? AppColors.lightGreenColor2
                        : AppColors.lightYellowColor,
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      revelationPlace,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isMakki
                            ? AppColors.DarkGreenColor
                            : AppColors.DarkYellowColor,
                        fontWeight:
                        FontWeight.w400,
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
