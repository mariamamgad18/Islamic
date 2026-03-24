import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:islamic/Features/Ui/on_boarding_screens/on_boarding_page_view_model.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/core/Utils/app_routes.dart';

import '../../../core/Utils/app_colors.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  //todo:_______________________________________________________________

  int currentPage = 0;

  //todo: عايزه اعمل حاجه تتحكم ف ال activeColor  حسب ال index
  // todo: هعمل حاجه اسمها computed property
  // todo :دي شبه الفانكشن لكن بنادي عليها ك Variable
  // todo: نوعه  Color
  //todo:  get >> معناها ال Variable ده مش ثابت يعني كل مره هيتنادي عليه هيتحسب من اول و جديد
  //todo: و هسميه activeColor

  Color get activeColor {
    //الصفحه الاولي اخضر التانيه اصفر التالته اخصر
    if (currentPage == 1) {
      //currentPage == 1 >> الفصحه التانيه
      return AppColors.YellowColor;
    }
    return AppColors.DarkGreenColor;
  }

  //todo:_______________________________________________________________
  Row get buttonText {
    //  الصفحه الاولي و التانيه مكتوب التالي و سهم <
    //الصفحه التالته مكتوب ابدأ الان من غير سهم
    if (currentPage == 2) {
      //currentPage == 2 >> الفصحه التالته
      return Row(
        children: [
          SizedBox(width: 25.w),

          Text(
            "ابدأ الآن",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.whiteColor,
              fontFamily: "Cairo",
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        SizedBox(width: 8.w),

        Text(
          "التالي",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.whiteColor,
            fontFamily: "Cairo",
          ),
        ),
        SizedBox(width: 4.w),
        Icon(Icons.arrow_forward_ios, color: AppColors.whiteColor, size: 10),
      ],
    );
  }

  //todo:_______________________________________________________________

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      safeAreaList: [false, false, false, false],
      onChange: (index) {
        setState(() {
          currentPage = index;
        });
      },

      //todo:_____________________________Dots__________________________________
      dotsDecorator: DotsDecorator(
        size: Size(10, 10),
        activeSize: Size(12, 12),
        color: AppColors.GreyColor,
        activeColor: activeColor,
      ),
      //todo:______________________________زرار ال next_________________________________
      rtl: false,
      showNextButton: true,
      next: Container(
        width: 200.w,
        height: 56.h,
        alignment: Alignment.center,
        //margin:
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          child: buttonText,
        ),
      ),
      //todo:______________________________زرار ال Done_________________________________
      showDoneButton: true,
      onDone: () {
        Navigator.of(
          context,
        ).pushNamed(AppRoutes.LanguageSelectionScreenRoutename);
      },
      done: Container(
        width: 200.w,
        height: 56.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: activeColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: buttonText,
      ),
      //todo:______________________________زرار ال Skip_________________________________
      showSkipButton: true,
      onSkip: () {
        Navigator.of(
          context,
        ).pushNamed(AppRoutes.LanguageSelectionScreenRoutename);
      },
      skip: Text(
        "تخطي",
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Cairo",
          color: AppColors.GreyColor,
        ),
      ),

      //todo:______________________________محتوي ال pages _________________________________
      pages: [
        //todo :1
        PageViewModel(
          titleWidget: SizedBox(),
          decoration: PageDecoration(bodyPadding: EdgeInsets.zero),
          bodyWidget: OnBoardingPageViewModel(
            OnBoardingimage: AppImages.onBoarding1,
            OnBoardingTitle: "القرآن الكريم",
            OnBoardingDescription:
                "اقرأ القرآن الكريم بخط واضح وتصميم جميل مع إمكانية الاستماع للتلاوات",
          ),
        ),
        //todo :2
        PageViewModel(
          titleWidget: SizedBox(),
          decoration: PageDecoration(bodyPadding: EdgeInsets.zero),
          bodyWidget: OnBoardingPageViewModel(
            OnBoardingimage: AppImages.onBoarding2,
            OnBoardingTitle: "مواقيت الصلاة",
            OnBoardingDescription:
                "تنبيهات دقيقة لمواقيت الصلاة حسب موقعك مع صوت الأذان",
          ),
        ),
        //todo :3
        PageViewModel(
          titleWidget: SizedBox(),
          decoration: PageDecoration(bodyPadding: EdgeInsets.zero),
          bodyWidget: OnBoardingPageViewModel(
            OnBoardingimage: AppImages.onBoarding3,
            OnBoardingTitle: "رفيقك الروحاني",
            OnBoardingDescription:
                "تذكيرات يومية، أذكار، تسبيح، وكل ما تحتاجه في رحلتك الإيمانية",
          ),
        ),
      ],
    );
  }
}
