import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/Sebha/counter_sebha_container.dart';
import 'package:islamic/Features/Ui/Sebha/tasbeeh_container.dart';
import 'package:islamic/Features/Ui/home_screen/ayah_container.dart';

import '../../../core/Utils/app_colors.dart';
import '../../../core/Utils/app_images.dart';

class SebhaScreen extends StatefulWidget {
  SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  String SelectedTasbeeh = "سبحان الله";
  final List<Map<String, String>> tasbeehList = [
    {"Title": "سبحان الله"},
    {"Title": "الحمد لله"},
    {"Title": "الله أكبر"},
    {"Title": "لا إله إلا الله"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 430.w,
              height: 110.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.GreenContainerBackground),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0.h,
                  horizontal: 24.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.volume_down_sharp,
                      size: 24,
                      color: AppColors.whiteColor,
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "المسبحة الإلكترونية",
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Cairo",
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "سبّح واذكر الله في كل وقت",
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
                        Icons.arrow_forward_outlined,
                        size: 18,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: tasbeehList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.8,
                ),
                itemBuilder: (context, index) {
                  final tasbeehIndex = tasbeehList[index];
                  return TasbeehContainer(
                    tasbeehTitle: tasbeehIndex["Title"]!,
                    isSelected: SelectedTasbeeh == tasbeehIndex["Title"],
                    onTap: () {
                      setState(() {
                        SelectedTasbeeh = tasbeehIndex["Title"]!;
                      });
                    },
                  );
                },
              ),
            ),
            CounterSebhaContainer(tasbeehTitle: SelectedTasbeeh),
            AyahContainerr(
              title: "فضل التسبيح",
              lastLine: "رواه البخاري ومسلم",
              subTitle:
                  "مَنْ قَالَ سُبْحَانَ اللَّهِ وَبِحَمۡدِهِ فِي يَوۡمٍ مِائَةَ مَرَّةٍ حُطَّتۡ خَطَايَاهُ وَإِنۡ كَانَتۡ مِثۡلَ زَبَدِ ٱلۡبَحۡرِ",
              topPadding: 10,
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}
