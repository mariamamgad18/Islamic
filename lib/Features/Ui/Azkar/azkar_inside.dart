import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/Azkar/zekr_container.dart';
import 'package:islamic/l10n/app_localizations.dart';

import '../../../core/Utils/app_colors.dart';
import 'cubit/azkar_states.dart';
import 'cubit/azkar_view_model.dart';

class AzkarInside extends StatelessWidget {
  final VoidCallback onBack;

  const AzkarInside({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(
        top: 220.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      child: Column(
        children: [
// =========================
// Back
// =========================

          InkWell(
            onTap: onBack,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [
                Text(
                  localizations.backToCategories,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.GreyColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cairo",
                  ),
                ),

                SizedBox(width: 15.w),

                Icon(
                  Icons.arrow_forward_outlined,
                  color: AppColors.GreyColor,
                  size: 14.sp,
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

// =========================
// Azkar
// =========================

          Expanded(
            child: BlocBuilder<
                AzkarViewModel,
                AzkarState>(
              builder: (context, state) {
                if (state is AzkarLoadingState) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (state is AzkarErrorState) {
                  return Center(
                    child: Text(
                      state.message,
                      textAlign:
                      TextAlign.center,
                    ),
                  );
                }

                if (state is AzkarSuccessState) {
                  if (state.azkar.isEmpty) {
                    return Center(
                      child: Text(
                        localizations
                            .noAzkarInCategory,
                        textAlign:
                        TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount:
                    state.azkar.length,
                    itemBuilder:
                        (context, index) {
                      final azkar =
                      state.azkar[index];

                      return ZekrContainer(
                        azkar: azkar,
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
    );
  }
}
