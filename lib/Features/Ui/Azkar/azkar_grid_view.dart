import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/Azkar/azkar_container.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/l10n/app_localizations.dart';

class AzkarGridView extends StatelessWidget {
  final Function(String category) onTabItem;

  const AzkarGridView({
    super.key,
    required this.onTabItem,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final List<Map<String, String>> azkarList = [
      {
        "key": "morning",
        "title": localizations.morningAzkar,
        "emoji": "🌅",
        "image": AppImages.orangeAzkar,
      },
      {
        "key": "evening",
        "title": localizations.eveningAzkar,
        "emoji": "🌙",
        "image": AppImages.blueAzkar,
      },
      {
        "key": "sleep",
        "title": localizations.sleepAzkar,
        "emoji": "🌃",
        "image": AppImages.babyBlueAzkar,
      },
      {
        "key": "after_prayer",
        "title": localizations.afterPrayerAzkar,
        "emoji": "🕌",
        "image": AppImages.greenAzkar,
      },
      {
        "key": "general_dua",
        "title": localizations.comprehensiveDuas,
        "emoji": "🤲",
        "image": AppImages.pinkAzkar,
      },
      {
        "key": "quranic_dua",
        "title": localizations.quranicDuas,
        "emoji": "📖",
        "image": AppImages.lightorangeAzkar,
      },
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: 150.h,
        left: 20.w,
        right: 20.w,
        bottom: 30.h,
      ),
      child: GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: azkarList.length,
        itemBuilder: (context, index) {
          final azkar = azkarList[index];

          return AzkarContainer(
            containerImage: azkar["image"]!,
            containerEmoji: azkar["emoji"]!,
            azkarTitle: azkar["title"]!,
            azkarCount: "",
            onTap: () {
              debugPrint(
                "CARD CLICKED: ${azkar["key"]}",
              );

              onTabItem(
                azkar["key"]!,
              );
            },
          );
        },
      ),
    );
  }
}