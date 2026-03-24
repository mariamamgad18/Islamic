import 'package:flutter/widgets.dart';
import 'package:islamic/Features/Ui/prayer_times_screen/fard_azan_item.dart';
import 'package:islamic/core/Utils/app_images.dart';

class PrayersListView extends StatelessWidget {
  PrayersListView({super.key});

  final List<Map<String, String>> froodAzan = [
    {"time": " 5:15", "Name": "الفجر", "image": AppImages.fajr},
    {"time": " 12:30", "Name": "الظهر", "image": AppImages.duhr},
    {"time": "3:45", "Name": "العصر", "image": AppImages.asr},
    {"time": "6:15", "Name": "المغرب", "image": AppImages.maghreb},
    {"time": "7:45", "Name": "العشاء", "image": AppImages.ishaa},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 300),
      child: Expanded(
        child: ListView.builder(
          itemCount: froodAzan.length,
          itemBuilder: (context, index) {
            final froodAzanIndex = froodAzan[index];
            return FardAzanItem(
              AzanTime: froodAzanIndex["time"]!,
              fardName: froodAzanIndex["Name"]!,
              fardImage: froodAzanIndex["image"]!,
            );
          },
        ),
      ),
    );
  }
}
