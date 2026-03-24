import 'package:flutter/material.dart';
import 'package:islamic/Features/Ui/prayer_times_screen/location_and_date_container.dart';
import 'package:islamic/Features/Ui/prayer_times_screen/prayers_list_view.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: Stack(children: [LocationAndDateContainer(), PrayersListView()]),
    );
  }
}
