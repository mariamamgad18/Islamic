import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/reminders_inside_screen/daily_repetition_container.dart';
import 'package:islamic/Features/Ui/reminders_inside_screen/reminder_color_container.dart';
import 'package:islamic/Features/Ui/reminders_inside_screen/reminder_icon_container.dart';
import 'package:islamic/Features/Ui/reminders_inside_screen/reminder_summary_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

import 'clock_container.dart';

class RemindersInsideScreen extends StatefulWidget {
  RemindersInsideScreen({super.key});

  @override
  State<RemindersInsideScreen> createState() => _RemindersInsideScreenState();
}

class _RemindersInsideScreenState extends State<RemindersInsideScreen> {
  String selectedTitle = "";
  TimeOfDay? selectedTime;
  final List<Map<String, dynamic>> IconsList = [
    {"icon": AppImages.alarmIcon},
    {"icon": AppImages.heartIcon},
    {"icon": AppImages.clockIcon2},
    {"icon": AppImages.nightIcon},
    {"icon": AppImages.lightIcon},
    {"icon": AppImages.StarIcon},
    {"icon": AppImages.DownIcon},
    {"icon": AppImages.upIcon},
    {"icon": AppImages.coffeIcon},
    {"icon": AppImages.bookIcon},
  ];

  final List<Map<String, dynamic>> colorsList = [
    {"color": AppColors.hotPink},
    {"color": AppColors.hotBlue},
    {"color": AppColors.hotPurple},
    {"color": AppColors.hotRed},
    {"color": AppColors.lightYellowColor},
  ];

  @override
  Widget build(BuildContext context) {
    String SelectedTime = "صباحاً";
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 25.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close, color: AppColors.BlackColor),
              ),
              SizedBox(height: 23.h),
              Text(
                "إضافة تذكير جديد",
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo",
                ),
              ),
              SizedBox(height: 23.h),

              //todo : عنوان التذكير
              Text(
                "عنوان التذكير",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: 462,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      selectedTitle = value;
                    });
                  },
                  style: TextStyle(color: AppColors.BlackColor, fontSize: 16),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "... مثال: صلاة الضحى، قراءة ورد",
                    hintStyle: TextStyle(
                      color: AppColors.GreyColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              //todo : وقت التذكير
              SizedBox(height: 24.h),
              Text(
                "وقت التذكير",
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

              //todo  :choose icon
              SizedBox(height: 24.h),
              Text(
                "اختر الأيقونة",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8, // المسافة الأفقية بين الأعمدة
                  mainAxisSpacing: 8,
                ),
                itemCount: IconsList.length,
                itemBuilder: (context, index) {
                  final IconsListIndex = IconsList[index];
                  return ReminderIconContainer(
                    containerImage2: IconsListIndex["icon"],
                  );
                },
              ),

              //todo:choose color
              //SizedBox(height: 24.h,),
              Text(
                "اختر اللون",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cairo",
                ),
              ),
              Row(
                children: [
                  ...List.generate(colorsList.length, (index) {
                    final colorsListindex = colorsList[index];
                    return Expanded(
                      child: ReminderColorContainer(
                        ContainerColor: colorsListindex["color"],
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: 24.h),
              DailyRepetitionContainer(),
              SizedBox(height: 24.h),
              ReminderSummaryContainer(
                selecetdTime: selectedTime,
                selectedTitle: selectedTitle,
              ),
              SizedBox(height: 10.h),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            (selectedTime != null && selectedTitle.isNotEmpty)
                                ? AppColors.DarkGreenColor
                                : AppColors.lightGreenColor2,
                      ),
                      onPressed: () {},
                      child: Text(
                        "حفظ التذكير",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whiteColor,
                      ),
                      onPressed: () {},
                      child: Text(
                        "إلغاء",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.BlackColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
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
