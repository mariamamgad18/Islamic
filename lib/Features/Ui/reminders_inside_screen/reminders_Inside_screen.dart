import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/reminders/reminder_model.dart';
import 'package:islamic/Features/Ui/reminders_inside_screen/clock_container.dart';
import 'package:islamic/Features/Ui/reminders_inside_screen/daily_repetition_container.dart';
import 'package:islamic/Features/Ui/reminders_inside_screen/reminder_summary_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

import '../../../l10n/app_localizations.dart';

class RemindersInsideScreen extends StatefulWidget {
  const RemindersInsideScreen({
    super.key,
  });

  @override
  State<RemindersInsideScreen> createState() =>
      _RemindersInsideScreenState();
}

class _RemindersInsideScreenState extends State<RemindersInsideScreen> {

  String selectedTitle = "";

  TimeOfDay? selectedTime;

  String? selectedIcon;

  Color? selectedColor;

  bool isDaily = false;

  final List<String> iconsList = [
    AppImages.alarmIcon,
    AppImages.heartIcon,
    AppImages.clockIcon2,
    AppImages.nightIcon,
    AppImages.lightIcon,
    AppImages.StarIcon,
    AppImages.DownIcon,
    AppImages.upIcon,
    AppImages.coffeIcon,
    AppImages.bookIcon,
  ];

  final List<Color> colorsList = [
    AppColors.hotPink,
    AppColors.hotBlue,
    AppColors.hotPurple,
    AppColors.hotRed,
    AppColors.lightYellowColor,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final bool canSave =
        selectedTitle
            .trim()
            .isNotEmpty &&
            selectedTime != null &&
            selectedIcon != null &&
            selectedColor != null;

    return Scaffold(
      backgroundColor:
      AppColors.semiwhiteColor,

      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 30.h,
          horizontal: 25.w,
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,

            children: [

// Close

              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },

                child: Icon(
                  Icons.close,
                  color: AppColors.BlackColor,
                ),
              ),

              SizedBox(height: 23.h),

// Title

              Text(
                l10n.addNewReminder,
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo",
                ),
              ),

              SizedBox(height: 23.h),

// =========================
// عنوان التذكير
// =========================

              Text(
                l10n.reminderTitle,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),

              SizedBox(height: 8.h),

              Container(
                width: 462.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color:
                  AppColors.whiteColor,
                  borderRadius:
                  BorderRadius.circular(12),
                ),

                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 10.w,
                ),

                child: TextField(
                  textDirection:
                  TextDirection.rtl,

                  onChanged: (value) {
                    setState(() {
                      selectedTitle = value;
                    });
                  },

                  style: TextStyle(
                    color:
                    AppColors.BlackColor,
                    fontSize: 16,
                  ),

                  decoration:
                  InputDecoration(
                    border:
                    InputBorder.none,

                    hintText:
                    l10n.reminderExample,

                    hintStyle: TextStyle(
                      color:
                      AppColors.GreyColor,
                      fontWeight:
                      FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

// =========================
// وقت التذكير
// =========================

              SizedBox(height: 24.h),

              Text(
                l10n.reminderTime,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),

              SizedBox(height: 8.h),

              ClockContainer(
                onTimeSelected: (time) {
                  setState(() {
                    selectedTime = time;
                  });
                },
              ),

// =========================
// اختيار الأيقونة
// =========================

              SizedBox(height: 24.h),

              Text(
                l10n.chooseIcon,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),

              SizedBox(height: 8.h),

              GridView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.7,
                ),

                itemCount:
                iconsList.length,

                itemBuilder:
                    (context, index) {
                  final String icon =
                  iconsList[index];

                  final bool isSelected =
                      selectedIcon == icon;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIcon = icon;
                      });
                    },

                    child: Container(
                      width: 86.w,
                      height: 48.h,

                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                          20,
                        ),

                        color: isSelected
                            ? AppColors
                            .lightGreenColor2
                            : AppColors
                            .semiwhiteColor,

                        border: Border.all(
                          color: isSelected
                              ? AppColors
                              .DarkGreenColor
                              : AppColors
                              .lightGreenColor2,

                          width: isSelected
                              ? 2
                              : 1,
                        ),
                      ),

                      child: Center(
                        child: Image(
                          image: AssetImage(
                            icon,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

// =========================
// اختيار اللون
// =========================

              SizedBox(height: 24.h),

              Text(
                l10n.chooseColor,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),

              SizedBox(height: 8.h),

              Row(
                children: [
                  ...List.generate(
                    colorsList.length,
                        (index) {
                      final Color color =
                      colorsList[index];

                      final bool isSelected =
                          selectedColor == color;

                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedColor =
                                  color;
                            });
                          },

                          child: Container(
                            height: 48.h,

                            margin:
                            EdgeInsets.symmetric(
                              horizontal: 2.w,
                            ),

                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                20,
                              ),

                              color: color,

                              border:
                              Border.all(
                                color: isSelected
                                    ? AppColors
                                    .DarkGreenColor
                                    : Colors
                                    .transparent,

                                width: isSelected
                                    ? 2
                                    : 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

// =========================
// التكرار اليومي
// =========================

              SizedBox(height: 24.h),

              DailyRepetitionContainer(
                isDaily: isDaily,

                onChanged: (value) {
                  setState(() {
                    isDaily = value;
                  });
                },
              ),

// =========================
// Preview
// =========================

              SizedBox(height: 24.h),

              ReminderSummaryContainer(
                selectedTime:
                selectedTime,

                selectedTitle:
                selectedTitle,

                selectedIcon:
                selectedIcon,

                selectedColor:
                selectedColor,
              ),

              SizedBox(height: 10.h),

// =========================
// Buttons
// =========================

              Row(
                children: [

// حفظ

                  Expanded(
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        canSave
                            ? AppColors
                            .DarkGreenColor
                            : AppColors
                            .lightGreenColor2,
                      ),

                      onPressed: canSave
                          ? () {
                        final ReminderModel
                        reminder =
                        ReminderModel(
                          title:
                          selectedTitle
                              .trim(),

                          time:
                          selectedTime!,

                          icon:
                          selectedIcon!,

                          color:
                          selectedColor!,

                          isDaily:
                          isDaily,
                        );

                        Navigator.of(
                          context,
                        ).pop(
                          reminder,
                        );
                      }
                          : null,

                      child: Text(
                        l10n.saveReminder,
                        style: TextStyle(
                          fontSize: 14,
                          color:
                          AppColors.whiteColor,
                          fontWeight:
                          FontWeight.w500,
                          fontFamily:
                          "Cairo",
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10.w),

// إلغاء

                  Expanded(
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        AppColors.whiteColor,
                      ),

                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pop();
                      },

                      child: Text(
                        l10n.cancel,
                        style: TextStyle(
                          fontSize: 14,
                          color:
                          AppColors.BlackColor,
                          fontWeight:
                          FontWeight.w500,
                          fontFamily:
                          "Cairo",
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
