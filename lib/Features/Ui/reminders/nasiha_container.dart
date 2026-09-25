import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

import '../../../l10n/app_localizations.dart';

class NasihaContainer extends StatelessWidget {
  const NasihaContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: 382.w,
      height: 156.25.h,
      decoration: BoxDecoration(
        color: AppColors.semiYellowColor,
        border: Border.all(
          color: AppColors.DarkYellowColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l10n.tip,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.BlackColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    textDirection: TextDirection.rtl,
                    l10n.azkarTip,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.GreyColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cairo",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              children: [
                Container(
                  width: 40.h,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.DarkYellowColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Image(
                      image: AssetImage(
                        AppImages.nasihaIcon,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
