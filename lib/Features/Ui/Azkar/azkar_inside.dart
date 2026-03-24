import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/Azkar/zekr_container.dart';

import '../../../core/Utils/app_colors.dart';

class AzkarInside extends StatelessWidget {
  final VoidCallback onBack;

  AzkarInside({super.key, required this.onBack});

  final List<Map<String, dynamic>> AzkarContent = [
    {
      "hadeeth":
          "أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ",
      "rawaah": "رواه مسلم",
      "hadeethCount": "1",
    },
    {
      "hadeeth":
          "اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ، وَإِلَيْكَ النُّشُورُ",
      "rawaah": "رواه الترمذي",
      "hadeethCount": "1",
    },

    {
      "hadeeth": "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
      "rawaah": "متفق عليه",
      "hadeethCount": "100",
    },
    {
      "hadeeth":
          "بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ",
      "rawaah": "رواه الترمذي",
      "hadeethCount": "3",
    },

    {
      "hadeeth":
          "اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا",
      "rawaah": "رواه ابن ماجه",
      "hadeethCount": "1",
    },
    {
      "hadeeth":
          "اللَّهُمَّ اجْعَلْ فِي قُلُوبِنَا نُورًا وَفِي أَعْمَالِنَا بَرَكَةً وَفِي أَخْلاَقِنَا حُسْنًا",
      "rawaah": "رواه أحمد",
      "hadeethCount": "2",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 220.h, left: 20.w, right: 20.w),
      child: Column(
        children: [
          InkWell(
            onTap: onBack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "العودة للفئات",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.GreyColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cairo",
                  ),
                ),
                SizedBox(width: 15.w),
                Icon(
                  Icons.arrow_forward_outlined,
                  color: AppColors.GreyColor,
                  size: 14,
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: ListView.builder(
              itemCount: AzkarContent.length,
              itemBuilder: (context, index) {
                final zakrIndex = AzkarContent[index];
                return ZekrContainer(
                  hadeeth: zakrIndex["hadeeth"],
                  rawaah: zakrIndex["rawaah"],
                  hadeethCount: zakrIndex["hadeethCount"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
