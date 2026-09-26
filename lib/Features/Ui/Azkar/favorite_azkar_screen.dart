import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

import 'cubit/azkar_states.dart';
import 'cubit/azkar_view_model.dart';
import 'zekr_container.dart';

class FavoriteAzkarScreen extends StatelessWidget {
  const FavoriteAzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,

      appBar: AppBar(
        backgroundColor: AppColors.semiwhiteColor,

        title: const Text(
          "الأذكار المفضلة",
          style: TextStyle(fontFamily: "Cairo"),
        ),
      ),

      body: BlocBuilder<AzkarViewModel, AzkarState>(
        builder: (context, state) {
          final favorites = context.read<AzkarViewModel>().favoriteAzkar;

          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                "لا توجد أذكار مفضلة",
                style: TextStyle(fontFamily: "Cairo"),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final azkar = favorites[index];

              return ZekrContainer(azkar: azkar);
            },
          );
        },
      ),
    );
  }
}
