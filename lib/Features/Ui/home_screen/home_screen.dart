import 'package:flutter/material.dart';
import 'package:islamic/Features/Ui/home_screen/green_container.dart';
import 'package:islamic/Features/Ui/home_screen/home_content.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            GreenContainer(),
            //SizedBox(height: 20.h,),
            Column(children: [HomeContent()]),
          ],
        ),
      ),
    );
  }
}
