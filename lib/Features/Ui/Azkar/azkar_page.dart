import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/Azkar/azkar_grid_view.dart';
import 'package:islamic/Features/Ui/Azkar/azkar_inside.dart';
import 'package:islamic/Features/Ui/Azkar/three_categories_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

class AzkarPage extends StatefulWidget {
  const AzkarPage({super.key});

  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  bool isShowGridView = true;
  String SelectedAzkarItem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: Stack(
        children: [
          //todo:Green Container
          Container(
            width: 430.w,
            height: 205.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.GreenContainerBackground),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text("🤲", style: TextStyle(fontSize: 25)),
                        ),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "الأدعية والأذكار",
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Cairo",
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "حصن المسلم اليومي",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Cairo",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_forward_outlined,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      ThreeCategoriesContainer(number: "0", title: "المفضلة"),
                      SizedBox(width: 11.w),
                      ThreeCategoriesContainer(
                        number: "0",
                        title: "مكتملة اليوم",
                      ),
                      SizedBox(width: 11.w),

                      ThreeCategoriesContainer(number: "6", title: "الفئات"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          isShowGridView
              ? AzkarGridView(
                onTabItem: (title) {
                  setState(() {
                    SelectedAzkarItem = title;
                    isShowGridView = false;
                  });
                },
              )
              : AzkarInside(
                onBack: () {
                  setState(() {
                    isShowGridView = true;
                  });
                },
              ),
        ],
      ),
    );
  }
}
