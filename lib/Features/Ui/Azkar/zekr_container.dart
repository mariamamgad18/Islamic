import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

import '../../../../Domain/entities/response/azkar/azkar.dart';
import 'cubit/azkar_states.dart';
import 'cubit/azkar_view_model.dart';

class ZekrContainer extends StatelessWidget {
  final Azkar azkar;

  const ZekrContainer({
    super.key,
    required this.azkar,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarViewModel, AzkarState>(
      builder: (context, state) {
        final viewModel =
        context.read<AzkarViewModel>();

        final bool isFavorite =
        viewModel.isFavorite(azkar);


        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius:
              BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
// =========================
// Favorite
// =========================

                  InkWell(
                    onTap: () async {
                      await viewModel.toggleFavorite(
                        azkar,
                      );
                    },
                    child: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite
                          ? AppColors.hotRed
                          : AppColors.GreyColor,
                    ),
                  ),

                  SizedBox(width: 30.w),

// =========================
// Text
// =========================

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.end,
                      children: [
                        Text(
                          azkar.text,
                          textAlign:
                          TextAlign.right,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color:
                            AppColors.BlackColor,
                            fontWeight:
                            FontWeight.w400,
                            fontFamily: "Cairo",
                          ),
                        ),

                        SizedBox(height: 8.h),

// =========================
// Reference
// =========================
                      ],
                    ),
                  ),

                  SizedBox(width: 12.w),

// =========================
// Count
// =========================

                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color:
                      AppColors.lightOrange,
                      borderRadius:
                      BorderRadius.circular(
                        20.r,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        azkar.count.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color:
                          AppColors.whiteColor,
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
        );
      },
    );
  }
}
