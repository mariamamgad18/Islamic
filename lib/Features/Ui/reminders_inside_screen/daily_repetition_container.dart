import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

import '../../../l10n/app_localizations.dart';

class DailyRepetitionContainer extends StatelessWidget {
  final bool isDaily;
  final ValueChanged<bool> onChanged;

  const DailyRepetitionContainer({
    super.key,
    required this.isDaily,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: 470.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 16.w,
        ),
        child: Row(
          children: [
            Switch(
              value: isDaily,
              activeTrackColor:
              AppColors.DarkGreenColor,
              activeColor:
              AppColors.whiteColor,
              inactiveThumbColor:
              AppColors.GreyColor,
              onChanged: onChanged,
            ),

            const Spacer(),

            Text(
              l10n.dailyRepeat,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.BlackColor,
                fontWeight: FontWeight.w500,
                fontFamily: "Cairo",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
