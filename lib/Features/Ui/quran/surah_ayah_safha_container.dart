import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class SurahAyahSafhaContainer extends StatelessWidget {
  SurahAyahSafhaContainer({
    super.key,
    required this.Image2,
    required this.Title2,
    required this.num,
    this.borderColor = AppColors.lightGreenColor2,
    this.TitleColor = AppColors.lightGreenColor2,
    this.bgColor = AppColors.lightGreenColor,
  });

  String Image2;
  String num;
  Color borderColor;
  Color bgColor;

  Color TitleColor;

  String Title2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 119.w,
      height: 142.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(13.0),
        child: Column(
          children: [
            Image(image: AssetImage(Image2)),
            SizedBox(height: 23),
            Text(
              Title2,
              style: TextStyle(
                fontSize: 18,
                color: TitleColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Cairo",
              ),
            ),
            SizedBox(height: 20),
            Text(
              num,
              style: TextStyle(
                fontSize: 12,
                color: TitleColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Cairo",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
