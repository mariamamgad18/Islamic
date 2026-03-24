import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/qebla/qebla_indicator.dart';
import 'package:islamic/core/Utils/app_colors.dart';

class QeblaScreen extends StatelessWidget {
  const QeblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.semiwhiteColor,
      body: Column(
        children: [
          Container(
            width: 430.w,
            height: 110.h,
            decoration: BoxDecoration(color: AppColors.DarkGreenColor),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        "اتجاه القبلة",
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "القاهرة، مصر",
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
          //SizedBox(height: 60.h,),
          Stack(
            children: [
              Center(child: QeblaIndicator()),
              Padding(
                padding: EdgeInsets.only(right: 23.0.w, left: 23.w, top: 380.h),
                child: Column(
                  children: [
                    Container(
                      width: 384.w,
                      height: 82.h,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "٤٥°",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.DarkGreenColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                                Text(
                                  "شمال شرق",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.GreyColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  "المسافة إلى مكة",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.GreyColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                                Text(
                                  "٢٬٤٢٥ كم",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.BlackColor,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Cairo",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: AppColors.DarkGreenColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.send_outlined,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: 384.w,
                      height: 54.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenColor2,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.DarkGreenColor,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "✓ تم تحديد اتجاه القبلة بنجاح",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.BlackColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Cairo",
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: AppColors.DarkGreenColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: 384.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightYellowColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.YellowColor),
                      ),
                      child: Center(
                        child: Text(
                          "💡 اجعل هاتفك مستوياً للحصول على أفضل دقة",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.GreyColor,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
