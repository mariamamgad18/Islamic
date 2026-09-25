import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islamic/Features/Ui/setting/setting_option.dart';
import 'package:islamic/core/Services/athan_scheduler.dart';
import 'package:islamic/core/Services/notification_service.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:islamic/core/Utils/language_manager.dart';

import '../../../Core/DI/injection.dart';
import '../../../l10n/app_localizations.dart';
import '../location_permission_screen/cubit/location_states.dart';
import '../location_permission_screen/cubit/location_view_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool athanEnabled = true;

  bool dark = false;

  late final LocationViewModel _locationViewModel;

  bool notificationsEnabled = false;

  late final AthanScheduler _athanScheduler;

  final List<Map<String, String>> languages = [
    {
      "name": "العربية",
      "code": "ar",
    },
    {
      "name": "English",
      "code": "en",
    },
    {
      "name": "اردو",
      "code": "ur",
    },
    {
      "name": "Français",
      "code": "fr",
    },
  ];

// =========================================================
// INIT
// =========================================================

  @override
  void initState() {
    super.initState();

    _athanScheduler = getIt<AthanScheduler>();

    _locationViewModel = getIt<LocationViewModel>();

    _initializeSettings();
  }

// =========================================================
// INITIALIZE SETTINGS
// =========================================================

  Future<void> _initializeSettings() async {
    await _athanScheduler.initializeAthanMasterState();

    await _loadAthanState();

    await _loadNotificationState();
  }

// =========================================================
// LOAD ATHAN MASTER STATE
// =========================================================

  Future<void> _loadAthanState() async {
    final enabled = await _athanScheduler.isAthanEnabled();

    if (!mounted) return;

    setState(() {
      athanEnabled = enabled;
    });
  }

// =========================================================
// TOGGLE MASTER ATHAN
// =========================================================

  Future<void> _toggleMasterAthan(bool value,
      StateSetter setDialogState,) async {
    await _athanScheduler.setAthanEnabled(value);

    if (!mounted) return;

    setDialogState(() {
      athanEnabled = value;
    });

    setState(() {
      athanEnabled = value;
    });
  }

// =========================================================
// LOAD NOTIFICATION STATE
// =========================================================

  Future<void> _loadNotificationState() async {
    final enabled =
    await NotificationService.areNotificationsEnabled();

    if (!mounted) return;

    setState(() {
      notificationsEnabled = enabled;
    });
  }

// =========================================================
// LANGUAGE
// =========================================================

  String _getCurrentLanguageName() {
    final currentCode =
        LanguageManager.currentLanguageCode;

    final language = languages.firstWhere(
          (language) => language["code"] == currentCode,
      orElse: () => languages.first,
    );

    return language["name"]!;
  }

  Future<void> _showLanguageDialog() async {
    final currentCode =
        LanguageManager.currentLanguageCode;

    await showDialog(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            l10n.chooseLanguage,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: "Cairo",
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((language) {
              final code = language["code"]!;
              final name = language["name"]!;

              final isSelected = currentCode == code;

              return ListTile(
                onTap: () async {
                  await LanguageManager.changeLanguage(code);

                  if (!mounted) return;

                  Navigator.of(context).pop();

                  setState(() {});
                },
                title: Text(
                  name,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                  Icons.check_circle,
                  color: AppColors.DarkGreenColor,
                )
                    : const Icon(
                  Icons.radio_button_unchecked,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

// =========================================================
// LOCATION PERMISSION
// =========================================================

  Future<void> _requestLocationPermission() async {
    final l10n = AppLocalizations.of(context)!;

    LocationPermission permission =
    await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              l10n.locationPermissionRequired,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: "Cairo",
              ),
            ),
            content: Text(
              l10n.locationPermissionSettingsMessage,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: "Cairo",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text(
                  l10n.cancel,
                  style: TextStyle(
                    color: AppColors.GreyColor,
                    fontFamily: "Cairo",
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(dialogContext).pop();

                  await Geolocator.openAppSettings();
                },
                child: Text(
                  l10n.openSettings,
                  style: TextStyle(
                    color: AppColors.DarkGreenColor,
                    fontFamily: "Cairo",
                  ),
                ),
              ),
            ],
          );
        },
      );

      return;
    }

    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.locationPermissionDenied,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Cairo",
            ),
          ),
        ),
      );

      return;
    }

    await _locationViewModel.getCurrentLocation();
  }

// =========================================================
// ABOUT APP DIALOG
// =========================================================

  Future<void> _showAboutDialog() async {
    final l10n = AppLocalizations.of(context)!;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: 28.w,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72.w,
                  height: 72.h,
                  decoration: BoxDecoration(
                    color: AppColors.DarkGreenColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.w),
                    child: Image(
                      image: AssetImage(
                        AppImages.isalmicIcon,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  l10n.aboutAppTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.DarkGreenColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Cairo",
                  ),
                ),

                SizedBox(height: 14.h),

                Container(
                  width: 60.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: AppColors.DarkYellowColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                SizedBox(height: 18.h),

                Text(
                  l10n.aboutAppDescription1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.9,
                    color: AppColors.BlackColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cairo",
                  ),
                ),

                SizedBox(height: 14.h),

                Text(
                  l10n.aboutAppDescription2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.8,
                    color: AppColors.GreyColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cairo",
                  ),
                ),

                SizedBox(height: 22.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.semiwhiteColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    l10n.appVersion,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.GreyColor,
                      fontFamily: "Cairo",
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      AppColors.DarkGreenColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      l10n.ok,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.whiteColor,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// =========================================================
// NOTIFICATIONS DIALOG
// =========================================================

  Future<void> _showNotificationsDialog() async {
    await _loadNotificationState();
    await _loadAthanState();

    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context,
              setDialogState,) {
            final l10n =
            AppLocalizations.of(context)!;

            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(
                horizontal: 28.w,
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(22.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
// =====================================
// ICON
// =====================================

                    Container(
                      width: 68.w,
                      height: 68.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreenColor2,
                        borderRadius:
                        BorderRadius.circular(22),
                      ),
                      child: Icon(
                        Icons.notifications_active_outlined,
                        size: 34,
                        color: AppColors.DarkGreenColor,
                      ),
                    ),

                    SizedBox(height: 14.h),

// =====================================
// TITLE
// =====================================

                    Text(
                      l10n.notificationsDialogTitle,
                      style: TextStyle(
                        fontSize: 21,
                        color: AppColors.DarkGreenColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      l10n.notificationsDialogDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.7,
                        color: AppColors.GreyColor,
                        fontFamily: "Cairo",
                      ),
                    ),

                    SizedBox(height: 20.h),

// =====================================
// SYSTEM NOTIFICATIONS
// =====================================

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.semiwhiteColor,
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Switch(
                            value: notificationsEnabled,
                            activeTrackColor:
                            AppColors.DarkGreenColor,
                            activeColor:
                            AppColors.whiteColor,
                            inactiveThumbColor:
                            AppColors.GreyColor,
                            onChanged: (value) async {
                              if (value) {
                                final result =
                                await NotificationService
                                    .requestNotificationPermission();

                                if (!mounted) {
                                  return;
                                }

                                setDialogState(() {
                                  notificationsEnabled =
                                      result;
                                });

                                setState(() {
                                  notificationsEnabled =
                                      result;
                                });
                              } else {
                                await _athanScheduler
                                    .cancelAll();

                                if (!mounted) {
                                  return;
                                }

                                setDialogState(() {
                                  notificationsEnabled =
                                  false;
                                });

                                setState(() {
                                  notificationsEnabled =
                                  false;
                                });
                              }
                            },
                          ),

                          const Spacer(),

                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Text(
                                l10n.appNotifications,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                  AppColors.BlackColor,
                                  fontWeight:
                                  FontWeight.w500,
                                  fontFamily: "Cairo",
                                ),
                              ),

                              SizedBox(height: 3.h),

                              Text(
                                notificationsEnabled
                                    ? l10n.notificationsEnabled
                                    : l10n.notificationsDisabled,
                                style: TextStyle(
                                  fontSize: 11,
                                  color:
                                  AppColors.GreyColor,
                                  fontFamily: "Cairo",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 12.w),

                          Container(
                            width: 42.w,
                            height: 42.h,
                            decoration: BoxDecoration(
                              color:
                              AppColors.whiteColor,
                              borderRadius:
                              BorderRadius.circular(14),
                            ),
                            child: Icon(
                              notificationsEnabled
                                  ? Icons.notifications_active
                                  : Icons.notifications_off_outlined,
                              color:
                              AppColors.DarkGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 14.h),

// =====================================
// MASTER ATHAN SWITCH
// =====================================

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.semiwhiteColor,
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Switch(
                            value: athanEnabled,
                            activeTrackColor:
                            AppColors.DarkGreenColor,
                            activeColor:
                            AppColors.whiteColor,
                            inactiveThumbColor:
                            AppColors.GreyColor,
                            onChanged: (value) async {
                              await _toggleMasterAthan(
                                value,
                                setDialogState,
                              );
                            },
                          ),

                          const Spacer(),

                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Text(
                                athanEnabled
                                    ? l10n.athanEnabled
                                    : l10n.athanDisabled,
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                  AppColors.BlackColor,
                                  fontWeight:
                                  FontWeight.w500,
                                  fontFamily: "Cairo",
                                ),
                              ),

                              SizedBox(height: 3.h),

                              Text(
                                athanEnabled
                                    ? l10n.athanNotificationsEnabled
                                    : l10n.allAthanNotificationsDisabled,
                                style: TextStyle(
                                  fontSize: 11,
                                  color:
                                  AppColors.GreyColor,
                                  fontFamily: "Cairo",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 12.w),

                          Container(
                            width: 42.w,
                            height: 42.h,
                            decoration: BoxDecoration(
                              color:
                              AppColors.whiteColor,
                              borderRadius:
                              BorderRadius.circular(14),
                            ),
                            child: Icon(
                              athanEnabled
                                  ? Icons.volume_up_outlined
                                  : Icons.volume_off_outlined,
                              color:
                              AppColors.DarkGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 14.h),

// =====================================
// OPEN SETTINGS
// =====================================

                    TextButton(
                      onPressed: () async {
                        await Geolocator.openAppSettings();
                      },
                      child: Text(
                        l10n.openNotificationSettings,
                        style: TextStyle(
                          color:
                          AppColors.DarkGreenColor,
                          fontSize: 13,
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

// =====================================
// CLOSE
// =====================================

                    SizedBox(
                      width: double.infinity,
                      height: 46.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(
                            dialogContext,
                          ).pop();
                        },
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.DarkGreenColor,
                          elevation: 0,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          l10n.ok,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                            AppColors.whiteColor,
                            fontFamily: "Cairo",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    await _loadNotificationState();
    await _loadAthanState();
  }

// =========================================================
// BUILD
// =========================================================

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<
        LocationViewModel,
        LocationStates>(
      bloc: _locationViewModel,
      listener: (context,
          state,) {
        if (state is LocationSuccessState) {
          WidgetsBinding.instance
              .addPostFrameCallback(
                (_) {
              if (!mounted) return;

              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(true);
              }
            },
          );
        }

        if (state is LocationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor:
        AppColors.semiwhiteColor,
        body: Column(
          children: [
// =================================================
// HEADER
// =================================================

            Container(
              width: 430.w,
              height: 110.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.GreenContainerBackground,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 24.w,
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text(
                          l10n.settings,
                          style: TextStyle(
                            fontSize: 24,
                            color:
                            AppColors.whiteColor,
                            fontWeight:
                            FontWeight.w500,
                            fontFamily: "Cairo",
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          l10n.customizeExperience,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                            AppColors.whiteColor,
                            fontWeight:
                            FontWeight.w400,
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
                        color:
                        AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

// =================================================
// CONTENT
// =================================================

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 5.h,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: [
                      Text(
                        l10n.generalSettings,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                          AppColors.GreyColor,
                          fontWeight:
                          FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Container(
                        height: 390.h,
                        width: 390.w,
                        clipBehavior:
                        Clip.antiAlias,
                        decoration:
                        BoxDecoration(
                          color:
                          AppColors.whiteColor,
                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: SettingOption(
                                buttonOrRow: Switch(
                                  value: dark,
                                  activeTrackColor:
                                  AppColors
                                      .DarkGreenColor,
                                  activeColor:
                                  AppColors
                                      .whiteColor,
                                  inactiveThumbColor:
                                  AppColors
                                      .GreyColor,
                                  onChanged:
                                      (bool value) {
                                    setState(() {
                                      dark = value;
                                    });
                                  },
                                ),
                                title:
                                l10n.darkMode,
                                subTitle:
                                l10n
                                    .darkModeDescription,
                                SettingImage:
                                AppImages
                                    .themeIcon2,
                              ),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap:
                                _showLanguageDialog,
                                child: SettingOption(
                                  buttonOrRow: Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .arrow_back_ios_new,
                                        size: 14,
                                        color:
                                        AppColors
                                            .GreyColor,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Text(
                                        _getCurrentLanguageName(),
                                        style:
                                        TextStyle(
                                          fontSize: 14,
                                          color:
                                          AppColors
                                              .GreyColor,
                                          fontFamily:
                                          "Cairo",
                                        ),
                                      ),
                                    ],
                                  ),
                                  title:
                                  l10n.language,
                                  subTitle:
                                  l10n
                                      .languageDescription,
                                  SettingImage:
                                  AppImages
                                      .language2Icon2,
                                ),
                              ),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap:
                                _requestLocationPermission,
                                child: SettingOption(
                                  buttonOrRow:
                                  const Icon(
                                    Icons
                                        .arrow_back_ios_new,
                                    size: 14,
                                    color:
                                    AppColors
                                        .GreyColor,
                                  ),
                                  title:
                                  l10n.location,
                                  subTitle:
                                  l10n
                                      .locationDescription,
                                  SettingImage:
                                  AppImages
                                      .LocationIcon,
                                ),
                              ),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap:
                                _showNotificationsDialog,
                                child: SettingOption(
                                  buttonOrRow:
                                  const Icon(
                                    Icons
                                        .arrow_back_ios_new,
                                    size: 14,
                                    color:
                                    AppColors
                                        .GreyColor,
                                  ),
                                  title:
                                  l10n.notifications,
                                  subTitle:
                                  l10n
                                      .notificationsDescription,
                                  SettingImage:
                                  AppImages
                                      .notficationIcon,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),

                      Text(
                        l10n.aboutApp,
                        style: TextStyle(
                          fontSize: 12,
                          color:
                          AppColors.GreyColor,
                          fontWeight:
                          FontWeight.w500,
                          fontFamily: "Cairo",
                        ),
                      ),

                      SizedBox(height: 12.h),

                      Container(
                        height: 175.h,
                        width: 390.w,
                        clipBehavior:
                        Clip.antiAlias,
                        decoration:
                        BoxDecoration(
                          color:
                          AppColors.whiteColor,
                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap:
                                _showAboutDialog,
                                child: SettingOption(
                                  buttonOrRow:
                                  const Icon(
                                    Icons
                                        .arrow_back_ios_new,
                                    size: 14,
                                    color:
                                    AppColors
                                        .GreyColor,
                                  ),
                                  title:
                                  l10n.about,
                                  subTitle:
                                  l10n
                                      .aboutDescription,
                                  SettingImage:
                                  AppImages
                                      .aboutIcon,
                                ),
                              ),
                            ),

                            Expanded(
                              child: SettingOption(
                                buttonOrRow:
                                Container(
                                  width: 53.63.w,
                                  height: 28.h,
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors
                                        .lightGreyColor,
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      16,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "1.0.0",
                                      style:
                                      TextStyle(
                                        fontSize: 14,
                                        color: AppColors
                                            .GreyColor,
                                        fontFamily:
                                        "Cairo",
                                      ),
                                    ),
                                  ),
                                ),
                                title:
                                l10n.version,
                                subTitle:
                                l10n
                                    .currentAppVersion,
                                SettingImage:
                                AppImages
                                    .aboutIcon,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Container(
                        width: double.infinity,
                        color:
                        AppColors.transparent,
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                AppImages
                                    .isalmicIcon,
                              ),
                            ),

                            SizedBox(height: 8.h),

                            Text(
                              l10n.mushaf,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors
                                    .GreyColor,
                                fontWeight:
                                FontWeight.w500,
                                fontFamily:
                                "Cairo",
                              ),
                            ),

                            SizedBox(height: 4.h),

                            Text(
                              l10n.madeWithLove,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors
                                    .GreyColor,
                                fontWeight:
                                FontWeight.w500,
                                fontFamily:
                                "Cairo",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
