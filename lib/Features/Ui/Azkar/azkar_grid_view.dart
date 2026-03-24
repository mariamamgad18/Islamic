import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/Azkar/azkar_container.dart';
import 'package:islamic/core/Utils/app_images.dart';

class AzkarGridView extends StatelessWidget {
  //todo: هنعمل callback function
  final Function(String) onTabItem;

  AzkarGridView({super.key, required this.onTabItem});

  final List<Map<String, dynamic>> AzkarList = [
    {
      "Title": "أذكار الصباح",
      "azkarNumber": "5 ذكر",
      "emoji": "🌅",
      "image": AppImages.orangeAzkar,
    },
    {
      "Title": "أذكار المساء",
      "azkarNumber": "3 ذكر",
      "emoji": "🌙",
      "image": AppImages.blueAzkar,
    },

    {
      "Title": "أذكار النوم",
      "azkarNumber": "3 ذكر",
      "emoji": "🌃",
      "image": AppImages.babyBlueAzkar,
    },
    {
      "Title": "أذكار بعد الصلاة",
      "azkarNumber": "5 ذكر",
      "emoji": "🕌",
      "image": AppImages.greenAzkar,
    },

    {
      "Title": "أدعية يومية",
      "azkarNumber": "3 ذكر",
      "emoji": "🤲",
      "image": AppImages.pinkAzkar,
    },
    {
      "Title": "آيات للحفظ",
      "azkarNumber": "3 ذكر",
      "emoji": "📖",
      "image": AppImages.lightorangeAzkar,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 150.h,
        left: 20.w,
        right: 20.w,
        bottom: 30.h,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: AzkarList.length,
        itemBuilder: (context, index) {
          final azkarindex = AzkarList[index];
          return InkWell(
            onTap: () {
              onTabItem(azkarindex["Title"]);
            },
            child: AzkarContainer(
              containerImage: azkarindex["image"],
              containerEmoji: azkarindex["emoji"],
              azkarTitle: azkarindex["Title"],
              azkarCount: azkarindex["azkarNumber"],
            ),
          );
        },
      ),
    );
  }
}
