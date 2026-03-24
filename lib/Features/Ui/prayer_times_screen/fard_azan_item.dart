import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

class FardAzanItem extends StatefulWidget {
  FardAzanItem({
    super.key,
    required this.AzanTime,
    required this.fardName,
    required this.fardImage,
  });

  String AzanTime;
  String fardName;
  String fardImage;

  @override
  State<FardAzanItem> createState() => _FardAzanItemState();
}

class _FardAzanItemState extends State<FardAzanItem> {
  bool AzanOn = false;

  bool Dark = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, right: 28.w, left: 28.w),
      child: Opacity(
        opacity: Dark ? 1 : 0.5,
        child: Container(
          width: 375.w,
          height: 116.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.AzanTime,
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                    Row(
                      children: [
                        Image(image: AssetImage(AppImages.notficationIcon)),
                        SizedBox(width: 10.w),
                        Switch(
                          value: Dark,
                          activeTrackColor: AppColors.DarkGreenColor,
                          activeColor: AppColors.whiteColor,
                          inactiveThumbColor: AppColors.GreyColor,
                          onChanged: (bool value) {
                            setState(() {
                              Dark = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  widget.fardName,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.BlackColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cairo",
                  ),
                ),
                SizedBox(width: 16.w),
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                      image: AssetImage(widget.fardImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
