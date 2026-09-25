import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/DI/injection.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/l10n/app_localizations.dart';

import 'cubit/quran_info_states.dart';
import 'cubit/quran_info_view_model.dart';
import 'makkeia_or_madenia_or_all_container.dart';
import 'surah_ayah_safha_container.dart';
import 'surah_container.dart';

class QuranListPage extends StatefulWidget {
  const QuranListPage({super.key});

  @override
  State<QuranListPage> createState() => _QuranListPageState();
}

class _QuranListPageState extends State<QuranListPage> {
// 0 = مكية
// 1 = مدنية
// 2 = الكل
  int selectedItem = 2;

  final TextEditingController searchController =
  TextEditingController();

  late QuranInfoViewModel viewModel;

  @override
  void initState() {
    super.initState();

    viewModel = getIt<QuranInfoViewModel>();

// Get all 114 surahs from API
    viewModel.getQuranInfo();
  }

  @override
  void dispose() {
    searchController.dispose();
    viewModel.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

// =========================================================
// Filter items
// =========================================================

    final List<Map<String, String>> makkeiaOrMadeniaList = [
      {
        "Title": localizations.meccan,
        "num": "86",
      },
      {
        "Title": localizations.medinan,
        "num": "28",
      },
      {
        "Title": localizations.all,
        "num": "114",
      },
    ];

// =========================================================
// Quran statistics
// =========================================================

    final List<Map<String, dynamic>> surahAyahSafhaList = [
      {
        "Title": localizations.page,
        "num": "604",
        "image": AppImages.safhaIcon,
      },
      {
        "Title": localizations.ayah,
        "num": "6236",
        "image": AppImages.ayahIcon,
        "fontColor": AppColors.DarkYellowColor,
        "borderColor": AppColors.DarkYellowColor,
        "bgColor": AppColors.lightYellowColor,
      },
      {
        "Title": localizations.surah,
        "num": "114",
        "image": AppImages.SurahIcon,
      },
    ];

    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        backgroundColor: AppColors.semiwhiteColor,
        body: Column(
          children: [
// =========================================================
// Header
// =========================================================

            Container(
              width: double.infinity,
              height: 180.h,
              decoration: BoxDecoration(
                color: AppColors.DarkGreenColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),

                        Column(
                          children: [
                            Text(
                              localizations.quranPageTitle,
                              style: TextStyle(
                                fontSize: 24,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Cairo",
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              localizations.surahsCount(114),
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

                    SizedBox(height: 24.h),

// =================================================
// Search
// =================================================

                    Container(
                      width: 350.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.GreyColor,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        textDirection: TextDirection.rtl,
                        onChanged: (_) {
                          setState(() {});
                        },
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.whiteColor,
                          fontFamily: "Cairo",
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                          localizations.searchForSurah,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: AppColors.semiwhiteColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cairo",
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.semiwhiteColor,
                          ),
                          contentPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

// =========================================================
// Filter
// =========================================================

            Container(
              width: double.infinity,
              height: 57.h,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 20.w,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: List.generate(
                          makkeiaOrMadeniaList.length,
                              (index) {
                            final item =
                            makkeiaOrMadeniaList[index];

                            return Padding(
                              padding: EdgeInsets.only(
                                right: index ==
                                    makkeiaOrMadeniaList
                                        .length -
                                        1
                                    ? 0
                                    : 8,
                              ),
                              child:
                              MakkeiaOrMadeniaOrAllContainer(
                                isSelectd:
                                selectedItem == index,
                                onTap: () {
                                  setState(() {
                                    selectedItem = index;
                                  });
                                },
                                title: item["Title"]!,
                                number: item["num"]!,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

// =========================================================
// Statistics
// =========================================================

            Padding(
              padding: EdgeInsets.only(
                top: 16.h,
                right: 20.w,
                left: 20.w,
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: List.generate(
                  surahAyahSafhaList.length,
                      (index) {
                    final item =
                    surahAyahSafhaList[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        right: index ==
                            surahAyahSafhaList.length - 1
                            ? 0
                            : 4,
                      ),
                      child: SurahAyahSafhaContainer(
                        Image2: item["image"],
                        Title2: item["Title"],
                        num: item["num"],
                        bgColor: item["bgColor"] ??
                            AppColors.lightGreenColor,
                        borderColor:
                        item["borderColor"] ??
                            AppColors.DarkGreenColor,
                        TitleColor:
                        item["fontColor"] ??
                            AppColors.DarkGreenColor,
                      ),
                    );
                  },
                ),
              ),
            ),

// =========================================================
// Surahs from API
// =========================================================

            Expanded(
              child: BlocBuilder<QuranInfoViewModel,
                  QuranInfoStates>(
                builder: (context, state) {
// ===================================================
// Loading
// ===================================================

                  if (state is QuranInfoLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

// ===================================================
// Error
// ===================================================

                  if (state is QuranInfoErrorState) {
                    return Center(
                      child: Padding(
                        padding:
                        const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              localizations
                                  .loadingSurahsError,
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
                                    .getQuranInfo();
                              },
                              child: Text(
                                localizations.retry,
                                style: const TextStyle(
                                  fontFamily: "Cairo",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

// ===================================================
// Success
// ===================================================

                  if (state is QuranInfoSuccessState) {
// =================================================
// IMPORTANT:
// Keep the complete list from API.
// We use it for Previous / Next Surah navigation.
// =================================================

                    final allChapters =
                        state.quranInfo.data.chapters;

// =================================================
// Filter only for displaying the list
// =================================================

                    final chapters =
                    viewModel.filterChapters(
                      chapters: allChapters,
                      selectedIndex: selectedItem,
                      searchText:
                      searchController.text,
                    );

// =================================================
// No results
// =================================================

                    if (chapters.isEmpty) {
                      return Center(
                        child: Text(
                          localizations.noSurahFound,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.GreyColor,
                            fontFamily: "Cairo",
                          ),
                        ),
                      );
                    }

// =================================================
// All / filtered surahs
// =================================================

                    return ListView.builder(
                      padding: EdgeInsets.only(
                        top: 8.h,
                        bottom: 20.h,
                      ),
                      itemCount: chapters.length,
                      itemBuilder: (context, index) {
                        final chapter =
                        chapters[index];

                        return SurahContainer(
                          chapter: chapter,

// IMPORTANT:
// Pass ALL 114 chapters,
// not the filtered list.
                          chapters: allChapters,
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
