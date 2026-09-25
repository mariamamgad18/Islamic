import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/Sebha/counter_sebha_container.dart';
import 'package:islamic/Features/Ui/Sebha/tasbeeh_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

import '../../../l10n/app_localizations.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  String selectedTasbeeh = " ";

  // العدد الافتراضي
  int targetCount = 33;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, String>> tasbeehList = [
      {"Title": l10n.subhanAllah},
      {"Title": l10n.alhamdulillah},
      {"Title": l10n.allahuAkbar},
      {"Title": l10n.laIlahaIllallah},
    ];

    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================

            Container(
              width: 430.w,
              height: 110.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.GreenContainerBackground,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 24.w,
                ),
                child: Row(
                  children: [
                    // زر تحديد العدد
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        _showTargetDialog();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(6.w),
                        child: Icon(
                          Icons.tune,
                          size: 24,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),

                    const Spacer(),

                    Column(
                      children: [
                        Text(
                          l10n.electronicTasbeeh,
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Cairo",
                          ),
                        ),

                        SizedBox(height: 5.h),

                        Text(
                          l10n.rememberAllahAnytime,
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

                    // Back
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

            // ================= TASBEEH TYPES =================

            Padding(
              padding: EdgeInsets.all(16.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasbeehList.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.8,
                ),
                itemBuilder: (context, index) {
                  final tasbeehIndex = tasbeehList[index];

                  return TasbeehContainer(
                    tasbeehTitle: tasbeehIndex["Title"]!,
                    isSelected:
                    selectedTasbeeh ==
                        tasbeehIndex["Title"],
                    onTap: () {
                      setState(() {
                        selectedTasbeeh =
                        tasbeehIndex["Title"]!;
                      });
                    },
                  );
                },
              ),
            ),

            // ================= COUNTER =================

            CounterSebhaContainer(
              tasbeehTitle: selectedTasbeeh,
              targetCount: targetCount,
            ),

            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // TARGET COUNT DIALOG
  // =========================================================

  void _showTargetDialog() {
    final TextEditingController controller =
    TextEditingController(
      text: targetCount.toString(),
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: Text(
            "تحديد عدد التسبيحات",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21.sp,
              color: AppColors.DarkGreenColor,
              fontWeight: FontWeight.w600,
              fontFamily: "Cairo",
            ),
          ),

          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,

            // أرقام فقط
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 25.sp,
              color: AppColors.BlackColor,
              fontFamily: "Cairo",
            ),

            decoration: InputDecoration(
              hintText: "مثال: 100",
              hintStyle: TextStyle(
                color: AppColors.GreyColor,
                fontFamily: "Cairo",
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: AppColors.lightGreyColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: AppColors.DarkGreenColor,
                  width: 2,
                ),
              ),
            ),
          ),

          actionsAlignment: MainAxisAlignment.center,

          actions: [
            // إلغاء
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                "إلغاء",
                style: TextStyle(
                  color: AppColors.GreyColor,
                  fontFamily: "Cairo",
                ),
              ),
            ),

            SizedBox(width: 10.w),

            // تأكيد
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.DarkGreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final String valueText =
                controller.text.trim();

                final int? newTarget =
                int.tryParse(valueText);

                // ممنوع صفر أو قيمة غير صحيحة
                if (newTarget == null || newTarget <= 0) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        "من فضلك أدخل عدد أكبر من صفر",
                        style: TextStyle(
                          fontFamily: "Cairo",
                        ),
                      ),
                      backgroundColor:
                      AppColors.DarkGreenColor,
                    ),
                  );

                  return;
                }

                setState(() {
                  targetCount = newTarget;
                });

                Navigator.pop(dialogContext);
              },
              child: Text(
                "تأكيد",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontFamily: "Cairo",
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}