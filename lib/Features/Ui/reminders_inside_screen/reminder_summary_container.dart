import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

import '../../../l10n/app_localizations.dart';

class ReminderSummaryContainer extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final String selectedTitle;
  final String? selectedIcon;
  final Color? selectedColor;

  const ReminderSummaryContainer({
    super.key,
    required this.selectedTime,
    required this.selectedTitle,
    required this.selectedIcon,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: 462.w,
      height: 134.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppImages.reminderContainerbackground,
          ),
          fit: BoxFit.fill,
        ),
        borderRadius:
        BorderRadius.circular(22),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.end,
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [

            Text(
              l10n.reminderPreview,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.GreyColor,
                fontWeight: FontWeight.w400,
                fontFamily: "Cairo",
              ),
            ),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [

                    Icon(
                      Icons.access_alarm,
                      color:
                      AppColors.GreyColor,
                      size: 12,
                    ),

                    SizedBox(width: 3.w),

                    Text(
                      selectedTime != null
                          ? selectedTime!.format(
                        context,
                      )
                          : l10n.defaultTime,
                      style: TextStyle(
                        fontSize: 12,
                        color:
                        AppColors.GreyColor,
                        fontWeight:
                        FontWeight.w400,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [

                    Text(
                      selectedTitle.isNotEmpty
                          ? selectedTitle
                          : l10n.reminderTitle,
                      style: TextStyle(
                        fontSize: 16,
                        color:
                        AppColors.BlackColor,
                        fontWeight:
                        FontWeight.w500,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(width: 12.w),

                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: selectedColor ??
                            AppColors.DarkGreenColor,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: selectedIcon != null
                            ? Image(
                          image: AssetImage(
                            selectedIcon!,
                          ),
                        )
                            : Icon(
                          Icons.access_alarm,
                          color:
                          AppColors.whiteColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
