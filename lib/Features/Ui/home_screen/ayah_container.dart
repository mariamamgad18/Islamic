import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/DI/injection.dart';
import '../../../core/Utils/app_colors.dart';
import '../../../core/Utils/app_images.dart';
import '../../../l10n/app_localizations.dart';
import '../quran_inside/cubit/quran_inside_states.dart';
import '../quran_inside/cubit/quran_inside_view_model.dart';

class AyahContainerr extends StatefulWidget {
  const AyahContainerr({
    super.key,
    this.topPadding = 415,
    this.ayahWidth = 500,
  });

  final int topPadding;
  final int ayahWidth;

  @override
  State<AyahContainerr> createState() => _AyahContainerrState();
}

class _AyahContainerrState extends State<AyahContainerr> {
  // =========================================================
  // Preferences Keys
  // =========================================================

  static const String dailyAyahKey = 'daily_ayah_data';

  // =========================================================
  // ViewModel
  // =========================================================

  late QuranInsideViewModel viewModel;

  // =========================================================
  // UI Data
  // =========================================================

  String subTitle = "";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    viewModel = getIt<QuranInsideViewModel>();

    _loadDailyAyah();
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  // =========================================================
  // LOAD DAILY AYAH
  // =========================================================

  Future<void> _loadDailyAyah() async {
    final prefs = await SharedPreferences.getInstance();

    final String today = _getTodayDate();

    final String? savedData = prefs.getString(dailyAyahKey);

    // =======================================================
    // We already have an ayah for today
    // =======================================================

    if (savedData != null) {
      try {
        final Map<String, dynamic> data = jsonDecode(savedData);

        final String savedDate = data['date'] ?? "";

        if (savedDate == today) {
          if (!mounted) return;

          setState(() {
            subTitle = data['ayahText'] ?? "";
            isLoading = false;
          });

          return;
        }
      } catch (_) {
        // If saved data is corrupted,
        // generate a new ayah.
      }
    }

    // =======================================================
    // New day -> Generate new random ayah
    // =======================================================

    await _generateRandomAyah();
  }

  // =========================================================
  // GENERATE RANDOM AYAH
  // =========================================================

  Future<void> _generateRandomAyah() async {
    final random = Random();

    // =======================================================
    // Random Surah
    // 1 -> 114
    // =======================================================

    final int randomChapterId = random.nextInt(114) + 1;

    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    // =======================================================
    // Get all verses of the random Surah
    // using your existing Quran API
    // =======================================================

    viewModel.getQuranVerses(
      randomChapterId,
    );

    // =======================================================
    // Wait for API state
    // =======================================================

    await for (final state in viewModel.stream) {
      if (state is QuranInsideSuccessState) {
        final verses = state.quranVerses.data.verses;

        if (verses.isEmpty) {
          if (!mounted) return;

          setState(() {
            isLoading = false;
          });

          return;
        }

        // ===================================================
        // Random Ayah from this Surah
        // ===================================================

        final int randomIndex = random.nextInt(verses.length);

        final verse = verses[randomIndex];

        final String ayahText = verse.textUthmani;

        final String today = _getTodayDate();

        // ===================================================
        // Save today's ayah
        // ===================================================

        await _saveDailyAyah(
          date: today,
          chapterId: randomChapterId,
          ayahIndex: randomIndex,
          ayahText: ayahText,
        );

        if (!mounted) return;

        setState(() {
          subTitle = ayahText;
          isLoading = false;
        });

        return;
      }

      if (state is QuranInsideErrorState) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        return;
      }
    }
  }

  // =========================================================
  // SAVE DAILY AYAH
  // =========================================================

  Future<void> _saveDailyAyah({
    required String date,
    required int chapterId,
    required int ayahIndex,
    required String ayahText,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> data = {
      "date": date,
      "chapterId": chapterId,
      "ayahIndex": ayahIndex,
      "ayahText": ayahText,
    };

    await prefs.setString(
      dailyAyahKey,
      jsonEncode(data),
    );
  }

  // =========================================================
  // TODAY DATE
  // =========================================================

  String _getTodayDate() {
    final now = DateTime.now();

    return "${now.year}-"
        "${now.month.toString().padLeft(2, '0')}-"
        "${now.day.toString().padLeft(2, '0')}";
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(
        top: widget.topPadding.h,
        right: 10.w,
        left: 10.w,
        bottom: 5.h,
      ),
      child: Container(
        width: widget.ayahWidth.w,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.lightYellowColor,
          border: Border.all(
            width: 1,
            color: AppColors.YellowColor,
          ),
        ),
        child: Stack(
          children: [
            // =========================================
            // Background Image
            // =========================================

            // Positioned.fill(
            //   child: ClipRRect(
            //     child: Image.asset(
            //       AppImages.ayahBackGround,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),

            // =========================================
            // Content
            // =========================================

            Padding(
              padding: const EdgeInsets.all(26.0),
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                  children: [
                    // =========================================
                    // Star
                    // =========================================

                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColors.DarkYellowColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Image(
                        image: AssetImage(
                          AppImages.starIcon,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // =========================================
                    // Localized Title
                    // =========================================

                    Text(
                      localization.dailyAyah,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppColors.GreyColor,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // =========================================
                    // Divider
                    // =========================================

                    Container(
                      width: 64.w,
                      height: 1.h,
                      color: AppColors.DarkYellowColor,
                    ),

                    SizedBox(height: 16.h),

                    // =========================================
                    // Ayah
                    // =========================================

                    Center(
                      child: Text(
                        subTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.BlackColor,
                          fontFamily: "Amiri",
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // =========================================
                    // Divider
                    // =========================================

                    Container(
                      width: 64.w,
                      height: 1.h,
                      color: AppColors.DarkYellowColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}