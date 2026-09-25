import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/home_screen/fard_column.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/l10n/app_localizations.dart';

import '../../../Domain/entities/response/prayer_times/timing.dart';
import '../../../core/Utils/prayer_times_helper.dart';

class PrayerTimesContainer extends StatefulWidget {
  const PrayerTimesContainer({
    super.key,
    required this.timings,
  });

  final Timings? timings;

  @override
  State<PrayerTimesContainer> createState() =>
      _PrayerTimesContainerState();
}

class _PrayerTimesContainerState extends State<PrayerTimesContainer> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        if (mounted && widget.timings != null) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // =========================================================
  // GET PRAYERS
  // =========================================================

  Map<String, String> get prayers {
    if (widget.timings == null) {
      return {
        "الفجر": "00:00",
        "الظهر": "00:00",
        "العصر": "00:00",
        "المغرب": "00:00",
        "العشاء": "00:00",
      };
    }

    return {
      "الفجر": widget.timings!.fajr,
      "الظهر": widget.timings!.dhuhr,
      "العصر": widget.timings!.asr,
      "المغرب": widget.timings!.maghrib,
      "العشاء": widget.timings!.isha,
    };
  }

  // =========================================================
  // LOCALIZED PRAYER NAME
  // =========================================================

  String getLocalizedPrayerName(String prayerName,
      AppLocalizations localizations,) {
    switch (prayerName) {
      case "الفجر":
        return localizations.fajr;

      case "الظهر":
        return localizations.dhuhr;

      case "العصر":
        return localizations.asr;

      case "المغرب":
        return localizations.maghrib;

      case "العشاء":
        return localizations.isha;

      default:
        return prayerName;
    }
  }

  // =========================================================
  // REMAINING TIME
  // =========================================================

  String getRemainingText(Duration remaining,
      AppLocalizations localizations,) {
    final hours = remaining.inHours;
    final minutes =
        remaining.inMinutes % 60;

    if (hours > 0) {
      final hourText =
      hours == 1
          ? localizations.hour
          : localizations.hours;

      final minuteText =
      minutes == 1
          ? localizations.minute
          : localizations.minutes;

      return "${localizations.after} "
          "$hours $hourText "
          "${localizations.and} "
          "$minutes $minuteText";
    }

    final minuteText =
    minutes == 1
        ? localizations.minute
        : localizations.minutes;

    return "${localizations.after} "
        "$minutes $minuteText";
  }

  // =========================================================
  // CONVERT PRAYER TIME
  // =========================================================

  DateTime _parsePrayerTime(String time) {
    final cleanTime =
        time
            .split(' ')
            .first;

    final parts =
    cleanTime.split(':');

    final int hour =
    int.parse(parts[0]);

    final int minute =
    int.parse(parts[1]);

    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  }

  // =========================================================
  // GET PRAYER PROGRESS
  // =========================================================

  Map<String, dynamic> _getPrayerProgress() {
    final now = DateTime.now();

    final prayerList = [
      {
        "name": "الفجر",
        "time": widget.timings!.fajr,
      },
      {
        "name": "الظهر",
        "time": widget.timings!.dhuhr,
      },
      {
        "name": "العصر",
        "time": widget.timings!.asr,
      },
      {
        "name": "المغرب",
        "time": widget.timings!.maghrib,
      },
      {
        "name": "العشاء",
        "time": widget.timings!.isha,
      },
    ];

    final prayerDateTimes =
    prayerList.map((prayer) {
      return {
        "name": prayer["name"],
        "time": prayer["time"],
        "dateTime": _parsePrayerTime(
          prayer["time"] as String,
        ),
      };
    }).toList();

    Map<String, dynamic>? previousPrayer;
    Map<String, dynamic>? nextPrayer;

    // =========================================================
    // NEXT PRAYER
    // =========================================================

    for (final prayer in prayerDateTimes) {
      final prayerTime =
      prayer["dateTime"] as DateTime;

      if (prayerTime.isAfter(now)) {
        nextPrayer = prayer;
        break;
      }
    }

    if (nextPrayer == null) {
      final fajr =
          prayerDateTimes.first;

      final fajrTomorrow =
      (fajr["dateTime"] as DateTime)
          .add(
        const Duration(days: 1),
      );

      nextPrayer = {
        ...fajr,
        "dateTime": fajrTomorrow,
      };
    }

    // =========================================================
    // PREVIOUS PRAYER
    // =========================================================

    for (
    int i = prayerDateTimes.length - 1;
    i >= 0;
    i--
    ) {
      final prayer =
      prayerDateTimes[i];

      final prayerTime =
      prayer["dateTime"] as DateTime;

      if (prayerTime.isBefore(now)) {
        previousPrayer = prayer;
        break;
      }
    }

    if (previousPrayer == null) {
      final isha =
          prayerDateTimes.last;

      final ishaYesterday =
      (isha["dateTime"] as DateTime)
          .subtract(
        const Duration(days: 1),
      );

      previousPrayer = {
        ...isha,
        "dateTime": ishaYesterday,
      };
    }

    final previousTime =
    previousPrayer["dateTime"]
    as DateTime;

    final nextTime =
    nextPrayer["dateTime"]
    as DateTime;

    final totalDuration =
        nextTime
            .difference(previousTime)
            .inSeconds;

    final elapsedDuration =
        now
            .difference(previousTime)
            .inSeconds;

    double progress = 0;

    if (totalDuration > 0) {
      progress =
          elapsedDuration /
              totalDuration;
    }

    progress =
        progress.clamp(0.0, 1.0);

    return {
      "previous": previousPrayer,
      "next": nextPrayer,
      "progress": progress,
    };
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    // =========================================================
    // NO LOCATION
    // =========================================================

    if (widget.timings == null) {
      final fardList = [
        {
          "name": localizations.isha,
          "time": "00:00",
          "image": AppImages.ishaa,
        },
        {
          "name": localizations.maghrib,
          "time": "00:00",
          "image": AppImages.maghreb,
        },
        {
          "name": localizations.asr,
          "time": "00:00",
          "image": AppImages.asr,
        },
        {
          "name": localizations.dhuhr,
          "time": "00:00",
          "image": AppImages.duhr,
        },
        {
          "name": localizations.fajr,
          "time": "00:00",
          "image": AppImages.fajr,
        },
      ];

      return Container(
        width: 390.w,
        height: 280.h,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(20),
          color: AppColors.whiteColor,
        ),
        child: Padding(
          padding:
          const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // =================================================
              // FIRST ROW
              // =================================================

              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "--",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight:
                          FontWeight.w400,
                          color:
                          AppColors.DarkGreenColor,
                          fontFamily: "Cairo",
                        ),
                      ),

                      SizedBox(height: 4.h),

                      Row(
                        children: [
                          Text(
                            "--",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                              FontWeight.w400,
                              color:
                              AppColors.GreyColor,
                              fontFamily: "Cairo",
                            ),
                          ),

                          SizedBox(width: 3.w),

                          Container(
                            width: 6.w,
                            height: 6.h,
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(30),
                              color:
                              AppColors
                                  .lightGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),

                  Column(
                    children: [
                      Text(
                        localizations.nextPrayer,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w400,
                          color:
                          AppColors.GreyColor,
                          fontFamily: "Cairo",
                        ),
                      ),

                      SizedBox(height: 3.h),

                      Text(
                        "${localizations.prayer} --",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight:
                          FontWeight.w500,
                          color:
                          AppColors.BlackColor,
                          fontFamily: "Cairo",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 12.w),

                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration:
                    BoxDecoration(
                      color:
                      AppColors.DarkGreenColor,
                      borderRadius:
                      BorderRadius.circular(24),
                    ),
                    child: Image(
                      image: AssetImage(
                        AppImages.clockIcon,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 35.h),

              // =================================================
              // EMPTY PROGRESS LINE
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 25.h,
                child: CustomPaint(
                  painter:
                  PrayerProgressPainter(
                    progress: 0,
                    activeColor:
                    AppColors.DarkGreenColor,
                    inactiveColor:
                    AppColors.lightGreenColor,
                  ),
                ),
              ),

              SizedBox(height: 25.h),

              // =================================================
              // PRAYER TIMES
              // =================================================

              Row(
                children: List.generate(
                  fardList.length,
                      (index) {
                    final fardIndex = fardList[index];

                    return Expanded(
                      child: FardColumn(
                        fardImage: fardIndex["image"]!,
                        fardName: fardIndex["name"]!,
                        fardTime: fardIndex["time"]!,
                      ),
                    );
                  },
                ),
              ),


            ],
          ),
        ),
      );
    }

    // =========================================================
    // NORMAL MODE WITH LOCATION
    // =========================================================

    final List<Map<String, String>>
    fardList = [
      {
        "name": localizations.isha,
        "time": widget.timings!.isha,
        "image": AppImages.ishaa,
      },
      {
        "name": localizations.maghrib,
        "time": widget.timings!.maghrib,
        "image": AppImages.maghreb,
      },
      {
        "name": localizations.asr,
        "time": widget.timings!.asr,
        "image": AppImages.asr,
      },
      {
        "name": localizations.dhuhr,
        "time": widget.timings!.dhuhr,
        "image": AppImages.duhr,
      },
      {
        "name": localizations.fajr,
        "time": widget.timings!.fajr,
        "image": AppImages.fajr,
      },
    ];

    // =========================================================
    // NEXT PRAYER
    // =========================================================

    final nextPrayer = getNextPrayer(
      prayers: prayers,
    );

    final remaining =
        nextPrayer.remaining;

    final remainingText =
    getRemainingText(
      remaining,
      localizations,
    );

    final localizedNextPrayerName =
    getLocalizedPrayerName(
      nextPrayer.name,
      localizations,
    );

    // =========================================================
    // PROGRESS
    // =========================================================

    final prayerProgress =
    _getPrayerProgress();

    final double progress =
    prayerProgress["progress"]
    as double;

    return Container(
      width: 390.w,
      height: 280.h,
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(20),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding:
        const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      nextPrayer.time,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight:
                        FontWeight.w400,
                        color:
                        AppColors
                            .DarkGreenColor,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Row(
                      children: [
                        Text(
                          remainingText,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w400,
                            color:
                            AppColors
                                .GreyColor,
                            fontFamily: "Cairo",
                          ),
                        ),

                        SizedBox(width: 3.w),

                        Container(
                          width: 6.w,
                          height: 6.h,
                          decoration:
                          BoxDecoration(
                            borderRadius:
                            BorderRadius
                                .circular(
                                30),
                            color:
                            AppColors
                                .lightGreenColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                Column(
                  children: [
                    Text(
                      localizations.nextPrayer,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w400,
                        color:
                        AppColors
                            .GreyColor,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 3.h),

                    Text(
                      "${localizations.prayer} "
                          "$localizedNextPrayerName",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                        FontWeight.w500,
                        color:
                        AppColors.BlackColor,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 12.w),

                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration:
                  BoxDecoration(
                    color:
                    AppColors
                        .DarkGreenColor,
                    borderRadius:
                    BorderRadius.circular(
                        24),
                  ),
                  child: Image(
                    image: AssetImage(
                      AppImages.clockIcon,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 35.h),

            SizedBox(
              width: double.infinity,
              height: 25.h,
              child: CustomPaint(
                painter:
                PrayerProgressPainter(
                  progress: progress,
                  activeColor:
                  AppColors.DarkGreenColor,
                  inactiveColor:
                  AppColors
                      .lightGreenColor,
                ),
              ),
            ),

            SizedBox(height: 25.h),

            Row(
              children:
              List.generate(
                fardList.length,
                    (index) {
                  final fardIndex =
                  fardList[index];

                  return Padding(
                    padding:
                    EdgeInsets.only(
                      right:
                      index ==
                          fardList.length -
                              1
                          ? 0
                          : 40,
                    ),
                    child: FardColumn(
                      fardImage:
                      fardIndex["image"]!,
                      fardName:
                      fardIndex["name"]!,
                      fardTime:
                      fardIndex["time"]!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// PRAYER PROGRESS PAINTER
// =============================================================

class PrayerProgressPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  PrayerProgressPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas,
      Size size,) {
    final Paint inactivePaint =
    Paint()
      ..color = inactiveColor
      ..strokeWidth = 4
      ..strokeCap =
          StrokeCap.round;

    final Paint activePaint =
    Paint()
      ..color = activeColor
      ..strokeWidth = 5
      ..strokeCap =
          StrokeCap.round;

    final double startX = 5;
    final double endX =
        size.width - 5;
    final double centerY =
        size.height / 2;

    canvas.drawLine(
      Offset(startX, centerY),
      Offset(endX, centerY),
      inactivePaint,
    );

    final double currentX =
        startX +
            ((endX - startX) *
                progress);

    canvas.drawLine(
      Offset(startX, centerY),
      Offset(currentX, centerY),
      activePaint,
    );

    final Paint dotPaint =
    Paint()
      ..color = activeColor
      ..style =
          PaintingStyle.fill;

    canvas.drawCircle(
      Offset(currentX, centerY),
      7,
      dotPaint,
    );

    final Paint borderPaint =
    Paint()
      ..color =
          AppColors.whiteColor
      ..style =
          PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(
      Offset(currentX, centerY),
      7,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant PrayerProgressPainter
  oldDelegate,) {
    return oldDelegate.progress !=
        progress ||
        oldDelegate.activeColor !=
            activeColor ||
        oldDelegate.inactiveColor !=
            inactiveColor;
  }
}