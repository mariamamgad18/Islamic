import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Domain/entities/response/quran_info/chapter.dart';
import 'package:islamic/Features/Ui/quran_inside/ayah_container.dart';
import 'package:islamic/Features/Ui/quran_inside/cubit/quran_inside_states.dart';
import 'package:islamic/Features/Ui/quran_inside/cubit/quran_inside_view_model.dart';
import 'package:islamic/core/DI/injection.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

class QuranInsidePage extends StatefulWidget {
  const QuranInsidePage({
    super.key,
    required this.chapterId,
    required this.chapters,
  });

  final int chapterId;

// كل السور اللي جايين من الـ API
  final List<Chapter> chapters;

  @override
  State<QuranInsidePage> createState() => _QuranInsidePageState();
}

class _QuranInsidePageState extends State<QuranInsidePage> {
  String selectedLanguage = "العربية";

  late QuranInsideViewModel viewModel;

  double ayahFontSize = 20;

  static const double minFontSize = 14;
  static const double maxFontSize = 40;

// =========================================================
// Current Chapter
// =========================================================

  Chapter get currentChapter {
    return widget.chapters.firstWhere(
          (chapter) => chapter.id == widget.chapterId,
    );
  }

// =========================================================
// Current Chapter Index
// =========================================================

  int get currentChapterIndex {
    return widget.chapters.indexWhere(
          (chapter) => chapter.id == widget.chapterId,
    );
  }

  @override
  void initState() {
    super.initState();

    viewModel = getIt<QuranInsideViewModel>();

    viewModel.getQuranVerses(widget.chapterId);
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

// =========================================================
// Zoom In
// =========================================================

  void zoomIn() {
    setState(() {
      if (ayahFontSize < maxFontSize) {
        ayahFontSize += 2;
      }
    });
  }

// =========================================================
// Zoom Out
// =========================================================

  void zoomOut() {
    setState(() {
      if (ayahFontSize > minFontSize) {
        ayahFontSize -= 2;
      }
    });
  }

// =========================================================
// Previous Surah
// =========================================================

  void goToPreviousSurah() {
    final int index = currentChapterIndex;

// لو إحنا في أول سورة
    if (index <= 0) {
      return;
    }

    final Chapter previousChapter =
    widget.chapters[index - 1];

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QuranInsidePage(
              chapterId: previousChapter.id,
              chapters: widget.chapters,
            ),
      ),
    );
  }

// =========================================================
// Next Surah
// =========================================================

  void goToNextSurah() {
    final int index = currentChapterIndex;

// لو إحنا في آخر سورة
    if (index == -1 ||
        index >= widget.chapters.length - 1) {
      return;
    }

    final Chapter nextChapter =
    widget.chapters[index + 1];

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QuranInsidePage(
              chapterId: nextChapter.id,
              chapters: widget.chapters,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Chapter chapter = currentChapter;

    final int currentIndex = currentChapterIndex;

    final bool isFirstSurah = currentIndex <= 0;

    final bool isLastSurah =
        currentIndex == -1 ||
            currentIndex >= widget.chapters.length - 1;

    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: AppColors.semiwhiteColor,
        body: Column(
          children: [

// =========================================================
// Green Header
// =========================================================

            Container(
              width: double.infinity,
              height: 120.h,
              color: AppColors.DarkGreenColor,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 25.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 24.h,
                ),
                child: Row(
                  children: [

                    const Spacer(),

                    Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [

                        Text(
                          "سورة ${chapter.nameArabic}",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cairo",
                          ),
                        ),

                        SizedBox(height: 4.h),

                        Text(
                          "${chapter.revelationPlace == "makkah"
                              ? "مكية"
                              : "مدنية"} - ${chapter.versesCount} آية",
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

                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

// =========================================================
// Zoom + Language Container
// =========================================================

            Container(
              width: double.infinity,
              height: 61.h,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.BlackColor
                        .withOpacity(0.10),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [

// ===================================================
// Selected Language
// ===================================================

                    Container(
                      width: 60.88.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: AppColors.DarkGreenColor,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          selectedLanguage,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 25.w),

// ===================================================
// Language Icon
// ===================================================

                    Image(
                      image: AssetImage(
                        AppImages.languageIcon2,
                      ),
                    ),

                    const SizedBox(width: 5),

// ===================================================
// Language Dropdown
// ===================================================

                    DropdownButton<String>(
                      value: selectedLanguage,
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      iconSize: 24,
                      iconEnabledColor:
                      AppColors.GreyColor,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                      items: [
                        "العربية",
                        "English",
                        "اردو",
                        "Français",
                      ].map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          selectedLanguage = value;
                        });
                      },
                    ),

                    const Spacer(),

// ===================================================
// Zoom In Button
// ===================================================

                    _buildZoomButton(
                      icon: Icons.zoom_in,
                      onTap: zoomIn,
                    ),

                    SizedBox(width: 8.w),

// ===================================================
// Current Font Size
// ===================================================

                    SizedBox(
                      width: 45.w,
                      child: Text(
                        "${ayahFontSize.toInt()}px",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.GreyColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),
                    ),

                    SizedBox(width: 8.w),

// ===================================================
// Zoom Out Button
// ===================================================

                    _buildZoomButton(
                      icon: Icons.zoom_out,
                      onTap: zoomOut,
                    ),
                  ],
                ),
              ),
            ),

// =========================================================
// Verses
// =========================================================

            Expanded(
              child: BlocBuilder<
                  QuranInsideViewModel,
                  QuranInsideStates>(
                builder: (context, state) {
// =====================================================
// Loading
// =====================================================

                  if (state
                  is QuranInsideLoadingState) {
                    return const Center(
                      child:
                      CircularProgressIndicator(),
                    );
                  }

// =====================================================
// Error
// =====================================================

                  if (state
                  is QuranInsideErrorState) {
                    return Center(
                      child: Padding(
                        padding:
                        const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            Text(
                              "حدث خطأ أثناء تحميل الآيات",
                              textAlign:
                              TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                AppColors.BlackColor,
                                fontFamily: "Cairo",
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              state.errorMsg,
                              textAlign:
                              TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                AppColors.GreyColor,
                                fontFamily: "Cairo",
                              ),
                            ),

                            const SizedBox(height: 20),

                            ElevatedButton(
                              onPressed: () {
                                viewModel
                                    .getQuranVerses(
                                  widget.chapterId,
                                );
                              },
                              child: const Text(
                                "إعادة المحاولة",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

// =====================================================
// Success
// =====================================================

                  if (state
                  is QuranInsideSuccessState) {
                    final verses =
                        state.quranVerses.data.verses;

                    if (verses.isEmpty) {
                      return Center(
                        child: Text(
                          "لا توجد آيات",
                          style: TextStyle(
                            fontSize: 16,
                            color:
                            AppColors.BlackColor,
                            fontFamily: "Cairo",
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.only(
                        top: 8.h,
                        bottom: 20.h,
                      ),
                      itemCount: verses.length,
                      itemBuilder:
                          (context, index) {
                        final verse =
                        verses[index];

                        return AyahContainer(
                          counter:
                          (index + 1).toString(),
                          ayah:
                          verse.textUthmani,
                          fontSize:
                          ayahFontSize,
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),

// =========================================================
// Previous / Next Surah
// =========================================================

            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: 50.h,
              ),
              child: Row(
                children: [

// =====================================================
// Previous Surah
// =====================================================

                  Expanded(
                    child: GestureDetector(
                      onTap: isFirstSurah
                          ? null
                          : goToPreviousSurah,
                      child: Container(
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          border: Border.all(
                            color:
                            AppColors.lightGreyColor,
                            width: 1,
                          ),
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            Text(
                              "السورة السابقة",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors
                                    .lightGreyColor,
                                fontWeight:
                                FontWeight.w500,
                                fontFamily: "Cairo",
                              ),
                            ),

                            SizedBox(width: 10.w),

                            Icon(
                              Icons.arrow_forward_outlined,
                              color: AppColors
                                  .lightGreyColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 13.w),

// =====================================================
// Next Surah
// =====================================================

                  Expanded(
                    child: GestureDetector(
                      onTap: isLastSurah
                          ? null
                          : goToNextSurah,
                      child: Container(
                        height: 36.h,
                        decoration: BoxDecoration(
                          color:
                          AppColors.DarkGreenColor,
                          border: Border.all(
                            color:
                            AppColors.lightGreyColor,
                            width: 1,
                          ),
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            Icon(
                              Icons.arrow_back,
                              color:
                              AppColors.whiteColor,
                              size: 20,
                            ),

                            SizedBox(width: 10.w),

                            Text(
                              "السورة التالية",
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                AppColors.whiteColor,
                                fontWeight:
                                FontWeight.w500,
                                fontFamily: "Cairo",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// =========================================================
// Zoom Button Widget
// =========================================================

  Widget _buildZoomButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Icon(
          icon,
          color: AppColors.BlackColor,
          size: 20,
        ),
      ),
    );
  }
}

