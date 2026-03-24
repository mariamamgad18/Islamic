import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/setting/setting_option.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: Column(
        children: [
          //todo: green Container :
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
              padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        "الإعدادات",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "تخصيص تجربتك",
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
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Text(
                    "الإعدادات العامة",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.GreyColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    height: 300.h,
                    width: 390.w,
                    clipBehavior: Clip.antiAlias,
                    // 👈 دي المهمة
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SettingOption(
                            buttonOrRow: Switch(
                              value: dark,
                              activeTrackColor: AppColors.DarkGreenColor,
                              activeColor: AppColors.whiteColor,
                              inactiveThumbColor: AppColors.GreyColor,
                              onChanged: (bool value) {
                                setState(() {
                                  dark = value;
                                });
                              },
                            ),
                            title: "الوضع الليلي",
                            subTitle: "تبديل بين الوضع الفاتح والداكن",
                            SettingImage: AppImages.themeIcon2,
                          ),
                        ),
                        Expanded(
                          child: SettingOption(
                            buttonOrRow: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 14,
                                  color: AppColors.GreyColor,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  "العربية",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.GreyColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                              ],
                            ),
                            title: "اللغة",
                            subTitle: "تغيير لغة التطبيق",
                            SettingImage: AppImages.language2Icon2,
                          ),
                        ),
                        Expanded(
                          child: SettingOption(
                            buttonOrRow: Icon(
                              Icons.arrow_back_ios_new,
                              size: 14,
                              color: AppColors.GreyColor,
                            ),
                            title: "الإشعارات",
                            subTitle: "إدارة التنبيهات والإشعارات",
                            SettingImage: AppImages.notficationIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "حول التطبيق",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.GreyColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 175.h,
                    width: 390.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SettingOption(
                            buttonOrRow: Icon(
                              Icons.arrow_back_ios_new,
                              size: 14,
                              color: AppColors.GreyColor,
                            ),
                            title: "عن التطبيق",
                            subTitle: "معلومات عن المصحف الشريف",
                            SettingImage: AppImages.aboutIcon,
                          ),
                        ),
                        Expanded(
                          child: SettingOption(
                            buttonOrRow: Container(
                              width: 53.63.w,
                              height: 28.h,
                              decoration: BoxDecoration(
                                color: AppColors.lightGreyColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  "1.0.0",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.GreyColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                              ),
                            ),
                            title: "الإصدار",
                            subTitle: "إصدار التطبيق الحالي",
                            SettingImage: AppImages.aboutIcon,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    color: AppColors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage(AppImages.isalmicIcon)),
                        SizedBox(height: 8.h),
                        Text(
                          "المصحف الشريف",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.GreyColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Cairo",
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "صُنع بـ ❤️ لخدمة القرآن الكريم",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.GreyColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
