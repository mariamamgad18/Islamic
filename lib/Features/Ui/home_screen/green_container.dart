import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/home_screen/prayer_times_container.dart';
import 'package:islamic/core/Utils/app_routes.dart';
import 'package:islamic/l10n/app_localizations.dart';

import '../../../Domain/entities/response/prayer_times/timing.dart';
import '../../../core/Utils/app_colors.dart';
import '../../../core/Utils/app_images.dart';

class GreenContainer extends StatelessWidget {
  const GreenContainer({
    super.key,
    required this.timings,
    this.onLocationUpdated,
  });

  final Timings? timings;

  // =========================================================
  // CALLBACK
  // =========================================================
  //
  // HomeScreen هيبعت الدالة دي.
  //
  // لما نرجع من Settings بعد تغيير الـ Location،
  // هننادي عليها علشان Home يعمل reload.
  //
  // =========================================================

  final Future<void> Function()? onLocationUpdated;

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    return Container(
      width: 430.w,
      height: 478.h,
      decoration: BoxDecoration(
        color: AppColors.DarkGreenColor,
        borderRadius: BorderRadius.circular(48),
        image: DecorationImage(
          image: AssetImage(
            AppImages.GreenContainer,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 20.0.w,
        ),
        child: Column(
          children: [
            Row(
              children: [
                // =================================================
                // SETTINGS
                // =================================================

                InkWell(
                  onTap: () async {
                    final result =
                    await Navigator.pushNamed(
                      context,
                      AppRoutes.settingScreenRoutename,
                    );

                    // =================================================
                    // LOCATION WAS UPDATED
                    // =================================================

                    if (result == true) {
                      await onLocationUpdated?.call();
                    }
                  },
                  child: Image(
                    image: AssetImage(
                      AppImages.settinIcon,
                    ),
                  ),
                ),

                SizedBox(width: 18.w),

                // =================================================
                // THEME
                // =================================================

                Image(
                  image: AssetImage(
                    AppImages.themeIcon,
                  ),
                ),

                const Spacer(),

                // =================================================
                // TITLE
                // =================================================

                Column(
                  children: [
                    Text(
                      localizations.mushaf,
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColors.whiteColor,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      localizations.assalamuAlaikum,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // =================================================
            // PRAYER TIMES
            // =================================================

            PrayerTimesContainer(
              timings: timings,
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}