import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/Features/Ui/location_permission_screen/cubit/location_states.dart';
import 'package:islamic/Features/Ui/location_permission_screen/cubit/location_view_model.dart';
import 'package:islamic/Features/Ui/location_permission_screen/location_container.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/core/Utils/app_preferences.dart';
import 'package:islamic/core/Utils/app_routes.dart';

import '../../../Core/DI/injection.dart';
import '../../../l10n/app_localizations.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({
    super.key,
  });

// =========================================================
// SKIP DIALOG
// =========================================================

  Future<void> _showSkipDialog(BuildContext context,) async {
    final localizations =
    AppLocalizations.of(context)!;

    final shouldSkip = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            localizations.prayerTimesDependOnLocation,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Cairo",
            ),
          ),
          content: Text(
            localizations.locationRequiredForPrayerTimes,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Cairo",
            ),
          ),
          actionsAlignment:
          MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: Text(
                localizations.allowLocation,
                style: const TextStyle(
                  fontFamily: "Cairo",
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: Text(
                localizations.skipAnyway,
                style: const TextStyle(
                  fontFamily: "Cairo",
                ),
              ),
            ),
          ],
        );
      },
    );

// =======================================================
// SKIP
// =======================================================

    if (shouldSkip == true) {
      await AppPreferences
          .setLocationFlowCompleted();

      if (!context.mounted) return;

      Navigator.of(context).pushReplacementNamed(
        AppRoutes.HomeScreenRoutename,
      );
    }

// =======================================================
// ALLOW
// =======================================================

    if (shouldSkip == false) {
      if (!context.mounted) return;

      context
          .read<LocationViewModel>()
          .getCurrentLocation();
    }
  }

// =========================================================
// BUILD
// =========================================================

  @override
  Widget build(BuildContext context) {
    final localizations =
    AppLocalizations.of(context)!;

    final List<Map<String, String>>
    locationOptions = [
      {
        "firstTitle":
        localizations.accuratePrayerTimes,
        "SecondTitle":
        localizations.accurateBasedOnLocation,
        "image":
        AppImages.secondIcon,
      },
      {
        "firstTitle":
        localizations.nearbyMosques,
        "SecondTitle":
        localizations.discoverMosques,
        "image":
        AppImages.firstIcon,
      },
      {
        "firstTitle":
        localizations.privacyProtected,
        "SecondTitle":
        localizations.dataSafe,
        "image":
        AppImages.thirdIcon,
      },
    ];

    return BlocProvider(
      create: (_) =>
          getIt<LocationViewModel>(),
      child: BlocConsumer<
          LocationViewModel,
          LocationStates>(
        listener: (context,
            state,) async {
// =================================================
// SUCCESS
// =================================================

          if (state is LocationSuccessState) {
            if (!context.mounted) return;

            Navigator.of(context)
                .pushReplacementNamed(
              AppRoutes.HomeScreenRoutename,
            );
          }

// =================================================
// ERROR
// =================================================

          if (state is LocationErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMsg,
                ),
              ),
            );
          }
        },
        builder: (context,
            state,) {
          return Scaffold(
            body: Stack(
              children: [
// =================================================
// BACKGROUND
// =================================================

                Image(
                  image: AssetImage(
                    AppImages
                        .SelectLocationScreenBackGround,
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),

// =================================================
// CONTENT
// =================================================

                Padding(
                  padding:
                  EdgeInsets.symmetric(
                    vertical: 91.h,
                    horizontal: 24.w,
                  ),
                  child:
                  SingleChildScrollView(
                    child: Column(
                      children: [
// =========================================
// LOCATION ICON
// =========================================

                        Container(
                          width: 154.24.w,
                          height: 154.24.h,
                          decoration:
                          BoxDecoration(
                            color: AppColors
                                .transparent,
                            borderRadius:
                            BorderRadius
                                .circular(
                              32,
                            ),
                            border:
                            Border.all(
                              color: AppColors
                                  .semiYellowColor,
                              width: 4,
                            ),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets
                                .all(13.1),
                            child: Container(
                              decoration:
                              BoxDecoration(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  32,
                                ),
                                color: AppColors
                                    .transparent,
                                border:
                                Border.all(
                                  color: AppColors
                                      .semiGreenColor,
                                  width: 4,
                                ),
                              ),
                              child:
                              Container(
                                decoration:
                                BoxDecoration(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    32,
                                  ),
                                  color: AppColors
                                      .DarkGreenColor,
                                ),
                                child: Image(
                                  image:
                                  AssetImage(
                                    AppImages
                                        .LocationIcon,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 18.h),

// =========================================
// TITLE
// =========================================

                        Text(
                          localizations
                              .locationPermission,
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColors
                                .BlackColor,
                            fontFamily: "Cairo",
                          ),
                        ),

                        SizedBox(height: 12.h),

// =========================================
// DESCRIPTION
// =========================================

                        Text(
                          localizations
                              .accurateBasedOnLocation,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors
                                .GreyColor,
                            fontFamily: "Cairo",
                          ),
                        ),

                        SizedBox(height: 32.h),

// =========================================
// OPTIONS
// =========================================

                        ...List.generate(
                          locationOptions
                              .length,
                              (index) {
                            final loc =
                            locationOptions[
                            index];

                            return LocationContainer(
                              firstLocationTitle:
                              loc[
                              "firstTitle"]!,
                              secondLocationTitle:
                              loc[
                              "SecondTitle"]!,
                              LocationImage:
                              loc["image"]!,
                            );
                          },
                        ),

                        SizedBox(height: 20.h),

// =========================================
// ALLOW BUTTON
// =========================================

                        SizedBox(
                          width: 382.w,
                          height: 56.h,
                          child:
                          ElevatedButton(
                            style:
                            ElevatedButton
                                .styleFrom(
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  24,
                                ),
                              ),
                              backgroundColor:
                              AppColors
                                  .DarkGreenColor,
                            ),
                            onPressed:
                            state
                            is LocationLoadingState
                                ? null
                                : () {
                              context
                                  .read<
                                  LocationViewModel>()
                                  .getCurrentLocation();
                            },
                            child:
                            state
                            is LocationLoadingState
                                ? const CircularProgressIndicator()
                                : Padding(
                              padding:
                              EdgeInsets.symmetric(
                                vertical:
                                10.h,
                                horizontal:
                                50.w,
                              ),
                              child:
                              Row(
                                children: [
                                  Text(
                                    localizations
                                        .allowLocationAccess,
                                    style:
                                    TextStyle(
                                      fontSize:
                                      18,
                                      color:
                                      AppColors.whiteColor,
                                      fontFamily:
                                      "Cairo",
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                    8.w,
                                  ),
                                  Image(
                                    image:
                                    AssetImage(
                                      AppImages
                                          .fourthIcon,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

// =========================================
// SKIP
// =========================================

                        TextButton(
                          onPressed: () {
                            _showSkipDialog(
                              context,
                            );
                          },
                          child: Text(
                            localizations
                                .skipForNow,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors
                                  .GreyColor,
                              fontFamily: "Cairo",
                            ),
                          ),
                        ),

                        SizedBox(height: 15.h),

// =========================================
// FOOTER
// =========================================

                        Padding(
                          padding:
                          EdgeInsets.symmetric(
                            horizontal: 60.w,
                          ),
                          child: Row(
                            children: [
                              Text(
                                localizations
                                    .changeSettingLater,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors
                                      .GreyColor,
                                  fontFamily:
                                  "Cairo",
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Image(
                                image:
                                AssetImage(
                                  AppImages
                                      .fifthIcon,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
