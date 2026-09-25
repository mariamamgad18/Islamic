import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/app_colors.dart';

class FardColumn extends StatelessWidget {
  const FardColumn({
    super.key,
    required this.fardImage,
    required this.fardName,
    required this.fardTime,
  });

  final String fardImage;
  final String fardName;
  final String fardTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 35.w,
      height: 80.h,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image(
              image: AssetImage(fardImage),
              width: 35.w,
              height: 35.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5.h),

          Expanded(
            child: Text(
              fardName,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.GreyColor,
                fontFamily: "Cairo",
              ),
            ),
          ),
          Text(
            fardTime,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.BlackColor,
              fontFamily: "Cairo",
            ),
          ),
        ],
      ),
    );
  }
}
