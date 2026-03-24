import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class ZekrContainer extends StatefulWidget {
  ZekrContainer({
    super.key,
    required this.hadeeth,
    required this.rawaah,
    required this.hadeethCount,
  });

  String hadeeth;
  String rawaah;
  String hadeethCount;

  @override
  State<ZekrContainer> createState() => _ZekrContainerState();
}

class _ZekrContainerState extends State<ZekrContainer> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        width: 375.w,
        //   height: 140.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child:
                    isFavorite
                        ? Icon(Icons.favorite, color: AppColors.hotRed)
                        : Icon(
                          Icons.favorite_border,
                          color: AppColors.GreyColor,
                        ),
              ),

              SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.hadeeth,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Container(
                      height: 22.h,
                      //width: 70.81.w,
                      decoration: BoxDecoration(
                        color: AppColors.lightOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Expanded(
                        child: Text(
                          widget.rawaah,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.BlackColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.lightOrange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    widget.hadeethCount,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cairo",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
