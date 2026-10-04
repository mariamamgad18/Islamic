import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Domain/entities/response/prayer_times/timing.dart';
import 'package:islamic/Features/Ui/prayer_times_screen/fard_azan_item.dart';
import 'package:islamic/core/Utils/app_images.dart';

class PrayersListView extends StatelessWidget {
  final Timings? timings;

  final Future<void> Function(
      String prayerKey,
      bool enabled,
      )? onAzanToggle;

  const PrayersListView({
    super.key,
    required this.timings,
    this.onAzanToggle,
  });

  @override
  Widget build(BuildContext context,) {
    final bool hasLocation =
        timings != null;

    final froodAzan = [
      {
        "time":
        timings?.fajr ?? "00:00",
        "name": "fajr",
        "image": AppImages.fajr,
      },
      {
        "time":
        timings?.dhuhr ?? "00:00",
        "name": "dhuhr",
        "image": AppImages.duhr,
      },
      {
        "time":
        timings?.asr ?? "00:00",
        "name": "asr",
        "image": AppImages.asr,
      },
      {
        "time":
        timings?.maghrib ?? "00:00",
        "name": "maghrib",
        "image": AppImages.maghreb,
      },
      {
        "time":
        timings?.isha ?? "00:00",
        "name": "isha",
        "image": AppImages.ishaa,
      },
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: 300.h,
      ),
      child: ListView.builder(
        itemCount:
        froodAzan.length,
        itemBuilder:
            (context, index) {
          final prayer =
          froodAzan[index];

          final prayerName =
          prayer["name"]!;

          return FardAzanItem(
            azanTime:
            prayer["time"]!,
            fardName:
            prayerName,
            fardImage:
            prayer["image"]!,
            isLocationAvailable:
            hasLocation,
            onToggle:
                (enabled) async {
              await onAzanToggle?.call(
                prayerName,
                enabled,
              );
            },
          );
        },
      ),
    );
  }
}