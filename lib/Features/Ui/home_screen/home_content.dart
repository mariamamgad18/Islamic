import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/home_screen/ayah_container.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/core/Utils/app_routes.dart';

import 'category_item.dart';

class HomeContent extends StatelessWidget {
  HomeContent({super.key});

  final List<Map<String, String>> CategoriesList = [
    {
      "Title": "المصحف",
      "desc": "قراءة القرآن الكريم",
      "isyellow": "false",
      "image": AppImages.categ1,
    },
    {
      "Title": "الأدعية والأذكار",
      "desc": "حصن المسلم",
      "isyellow": "true",
      "image": AppImages.categ2,
    },
    {
      "Title": "تعليم القرآن",
      "desc": "دروس وتلاوات",
      "isyellow": "false",
      "image": AppImages.categ3,
    },

    {
      "Title": "الأذان",
      "desc": "مواقيت الصلاة",
      "isyellow": "true",
      "image": AppImages.categ4,
    },
    {
      "Title": "التذكيرات",
      "desc": "تنبيهات يومية",
      "isyellow": "false",
      "image": AppImages.categ5,
    },
    {
      "Title": "المساجد",
      "desc": "أقرب المساجد",
      "isyellow": "true",
      "image": AppImages.categ6,
    },
  ];
  final List<Map<String, String>> CategoriesList2 = [
    {
      "Title": "المسبحة",
      "desc": "عداد التسبيح",
      "isyellow": "false",
      "image": AppImages.categ7,
      "isGridview": "false",
    },
    {
      "Title": "اتجاه القبلة",
      "desc": "تحديد اتجاه القبلة",
      "isyellow": "true",
      "image": AppImages.categ8,
      "isGridview": "false",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //todo:Ayah Container
        AyahContainerr(),
        //todo:__________________gridview____________________________
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Container(
            height: 600,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12, // المسافة الأفقية بين الأعمدة
                mainAxisSpacing: 12,
              ),
              itemCount: CategoriesList.length,
              itemBuilder: (context, index) {
                final categoryindex = CategoriesList[index];
                String targetPage = "";
                if (categoryindex["Title"] == "المصحف") {
                  targetPage = AppRoutes.QuranScreenRoutename;
                } else if (categoryindex["Title"] == "الأدعية والأذكار") {
                  targetPage = AppRoutes.AzkarScreenRoutename;
                } else if (categoryindex["Title"] == "الأذان") {
                  targetPage = AppRoutes.AzanScreenRoutename;
                } else if (categoryindex["Title"] == "التذكيرات") {
                  targetPage = AppRoutes.RemindersScreenRoutename;
                } else if (categoryindex["Title"] == "المساجد") {
                  targetPage = AppRoutes.NearbyMosquesScreenRoutename;
                }
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, targetPage);
                  },
                  child: CategoryItem(
                    iconImage: categoryindex["image"]!,
                    CategoryDesc: categoryindex["desc"]!,
                    CategoryTitle: categoryindex["Title"]!,
                    isYellow: categoryindex["isyellow"]!,
                  ),
                );
              },
            ),
          ),
        ),
        //todo:__________________listview____________________________
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 300,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final categoryindex = CategoriesList2[index];
                String targetPage2 = "";
                if (categoryindex["Title"] == "المسبحة") {
                  targetPage2 = AppRoutes.TasbihScreenRoutename;
                } else if (categoryindex["Title"] == "اتجاه القبلة") {
                  targetPage2 = AppRoutes.QiblaScreenRoutename;
                }

                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, targetPage2);
                  },

                  child: CategoryItem(
                    iconImage: categoryindex["image"]!,
                    CategoryDesc: categoryindex["desc"]!,
                    CategoryTitle: categoryindex["Title"]!,
                    isYellow: categoryindex["isyellow"]!,
                    isGridView: categoryindex["isGridview"]!,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 12.h);
              },
              itemCount: CategoriesList2.length,
            ),
          ),
        ),
      ],
    );
  }
}
