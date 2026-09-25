import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';

import '../../../l10n/app_localizations.dart';

class MosqueContainer extends StatelessWidget {
  MosqueContainer({
    super.key,
    required this.address,
    required this.distanceBetweenYourCurrentLocationAndMosque,
    required this.MosqueName,
    required this.counter,
  });

  double distanceBetweenYourCurrentLocationAndMosque;

  String MosqueName;
  String address;
  int counter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h),
      child: Container(
        width: 382.w,
        height: 85.h,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                " ${l10n.distanceToMosque(
                  distanceBetweenYourCurrentLocationAndMosque,
                )} ",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.DarkGreenColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cairo",
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    MosqueName,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.BlackColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cairo",
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.GreyColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cairo",
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.GreyColor,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.DarkGreenColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    counter.toString(),
                    style: TextStyle(
                      fontSize: 18,
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
