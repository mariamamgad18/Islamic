import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../../core/Utils/app_colors.dart';
import '../../../l10n/app_localizations.dart';

class LocationAndDateContainer extends StatelessWidget {
  final String cityName;

  const LocationAndDateContainer({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final now = DateTime.now();

// ==========================================
// Gregorian Month
// ==========================================

    final List<String> months = [
      localizations.january,
      localizations.february,
      localizations.march,
      localizations.april,
      localizations.may,
      localizations.june,
      localizations.july,
      localizations.august,
      localizations.september,
      localizations.october,
      localizations.november,
      localizations.december,
    ];

    final String monthName =
    months[now.month - 1];

// ==========================================
// Real Hijri Date
// ==========================================

    final hijriDate =
    HijriCalendar.fromDate(now);

    final List<String> hijriMonths = [
      localizations.muharram,
      localizations.safar,
      localizations.rabiAlAwwal,
      localizations.rabiAlThani,
      localizations.jumadaAlAwwal,
      localizations.jumadaAlThani,
      localizations.rajab,
      localizations.shaban,
      localizations.ramadan,
      localizations.shawwal,
      localizations.dhulQidah,
      localizations.dhulHijjah,
    ];

    final String hijriMonthName =
    hijriMonths[hijriDate.hMonth - 1];

    return Container(
      width: 430.w,
      height: 373.h,
      decoration: BoxDecoration(
        color: AppColors.DarkGreenColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 24.h,
          left: 24.w,
          right: 24.w,
        ),
        child: Column(
          children: [
// ==========================================
// Header
// ==========================================

            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      localizations.prayerTimesTitle,
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      localizations.accurateTimesBasedOnLocation,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 16.w),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

// ==========================================
// Location
// ==========================================

            Container(
              width: 367.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.lightGreenColor,
                borderRadius:
                BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: [
                    Text(
                      cityName,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight:
                        FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(width: 8.w),

                    Icon(
                      Icons.location_on_outlined,
                      color:
                      AppColors.whiteColor,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

// ==========================================
// Date
// ==========================================

            Container(
              width: 367.w,
              height: 153.h,
              decoration: BoxDecoration(
                color: AppColors.lightGreenColor,
                borderRadius:
                BorderRadius.circular(24),
              ),
              child: Padding(
                padding:
                const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      _getArabicDayName(
                        context,
                        now.weekday,
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color:
                        AppColors.whiteColor,
                        fontWeight:
                        FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 8.h),

// Gregorian date
                    Text(
                      "${now.day} $monthName ${now.year}",
                      style: TextStyle(
                        fontSize: 30,
                        color:
                        AppColors.whiteColor,
                        fontWeight:
                        FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 8.h),

// Hijri date
                    Text(
                      "${hijriDate.hDay} $hijriMonthName ${hijriDate
                          .hYear} ${localizations.hijriYearSuffix}",
                      style: TextStyle(
                        fontSize: 14,
                        color:
                        AppColors.whiteColor,
                        fontWeight:
                        FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
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

  String _getArabicDayName(BuildContext context,
      int weekday,) {
    final localizations =
    AppLocalizations.of(context)!;

    switch (weekday) {
      case DateTime.monday:
        return localizations.monday;

      case DateTime.tuesday:
        return localizations.tuesday;

      case DateTime.wednesday:
        return localizations.wednesday;

      case DateTime.thursday:
        return localizations.thursday;

      case DateTime.friday:
        return localizations.friday;

      case DateTime.saturday:
        return localizations.saturday;

      case DateTime.sunday:
        return localizations.sunday;

      default:
        return "";
    }
  }
}
