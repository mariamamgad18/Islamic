import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/Azkar/azkar_grid_view.dart';
import 'package:islamic/Features/Ui/Azkar/azkar_inside.dart';
import 'package:islamic/Features/Ui/Azkar/cubit/azkar_view_model.dart';
import 'package:islamic/Features/Ui/Azkar/three_categories_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/l10n/app_localizations.dart';

import '../../../Core/DI/injection.dart';
import 'cubit/azkar_states.dart';
import 'favorite_azkar_screen.dart';

class AzkarPage extends StatelessWidget {
  const AzkarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      getIt<AzkarViewModel>()
        ..loadFavorites(),
      child: const _AzkarPageContent(),
    );
  }
}


class _AzkarPageContent extends StatefulWidget {
  const _AzkarPageContent();

  @override
  State<_AzkarPageContent> createState() =>
      _AzkarPageContentState();
}

class _AzkarPageContentState extends State<_AzkarPageContent> {
  bool isShowGridView = true;

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,

      body: Stack(
        children: [
          // =========================================================
          // HEADER
          // =========================================================

          Container(
            width: 430.w,
            height: 205.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.GreenContainerBackground,
                ),
                fit: BoxFit.fill,
              ),
            ),

            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyColor,
                          borderRadius:
                          BorderRadius.circular(24.r),
                        ),
                        child: const Center(
                          child: Text(
                            "🤲",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      Column(
                        children: [
                          Text(
                            localizations.azkarPageTitle,
                            style: TextStyle(
                              fontSize: 24.sp,
                              color:
                              AppColors.whiteColor,
                              fontWeight:
                              FontWeight.w400,
                              fontFamily: "Cairo",
                            ),
                          ),

                          SizedBox(height: 5.h),

                          Text(
                            localizations.azkarPageSubtitle,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color:
                              AppColors.whiteColor,
                              fontWeight:
                              FontWeight.w400,
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
                          color:
                          AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Expanded(
                        child:
                        //المفضله
                        BlocBuilder<AzkarViewModel, AzkarState>(
                          builder: (context, state) {
                            final viewModel =
                            context.read<AzkarViewModel>();

                            return ThreeCategoriesContainer(
                              number: viewModel.favoritesCount.toString(),
                              title: localizations.favorites,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) {
                                      return BlocProvider.value(
                                        value: viewModel,
                                        child: const FavoriteAzkarScreen(),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),

                      ),
                      SizedBox(width: 10.w),

                      Expanded(
                        child: ThreeCategoriesContainer(
                          number: "6",
                          title:
                          localizations.categories,
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ),
          ),

          // =========================================================
          // CONTENT
          // =========================================================

          if (isShowGridView)
            AzkarGridView(
              onTabItem: (category) {
                debugPrint(
                  "CLICKED CATEGORY: $category",
                );

                context
                    .read<AzkarViewModel>()
                    .getAzkar(category);

                setState(() {
                  isShowGridView = false;
                });
              },
            )
          else
            AzkarInside(
              onBack: () {
                setState(() {
                  isShowGridView = true;
                });
              },
            ),
        ],
      ),
    );
  }
}