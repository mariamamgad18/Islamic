import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/Services/athan_scheduler.dart';
import '../../../core/Utils/app_routes.dart';
import '../../../l10n/app_localizations.dart';

class FardAzanItem extends StatefulWidget {
  const FardAzanItem({
    super.key,
    required this.azanTime,
    required this.fardName,
    required this.fardImage,
    this.isLocationAvailable = true,
    this.onToggle,
  });

  final String azanTime;
  final String fardName;
  final String fardImage;
  final bool isLocationAvailable;

  final Future<void> Function(bool value)? onToggle;

  @override
  State<FardAzanItem> createState() =>
      _FardAzanItemState();
}

class _FardAzanItemState extends State<FardAzanItem> {
  bool azanEnabled = false;

  // =========================================================
  // PREFERENCE ID
  // =========================================================

  int _getPreferenceId() {
    switch (widget.fardName) {
      case 'fajr':
        return 1001;

      case 'dhuhr':
        return 1002;

      case 'asr':
        return 1003;

      case 'maghrib':
        return 1004;

      case 'isha':
        return 1005;

      default:
        return 1099;
    }
  }

  // =========================================================
  // PRAYER STATE KEY
  // =========================================================

  String get _azanKey =>
      'azan_enabled_${_getPreferenceId()}';

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    // Listen to Master Athan changes from Settings
    AthanScheduler.athanEnabledNotifier
        .addListener(_onMasterAthanChanged);

    _loadState();
  }

  // =========================================================
  // MASTER ATHAN CHANGED
  // =========================================================

  void _onMasterAthanChanged() {
    if (!mounted) return;

    final masterEnabled =
        AthanScheduler.athanEnabledNotifier.value;

    // -------------------------------------------------------
    // MASTER OFF
    // -------------------------------------------------------

    if (!masterEnabled) {
      setState(() {
        azanEnabled = false;
      });

      return;
    }

    // -------------------------------------------------------
    // MASTER ON
    // -------------------------------------------------------

    _loadState();
  }

  // =========================================================
  // LOAD STATE
  // =========================================================

  Future<void> _loadState() async {
    final prefs =
    await SharedPreferences.getInstance();

    final masterEnabled =
        prefs.getBool(
          AthanScheduler.athanMasterKey,
        ) ??
            false;

    final savedPrayerState =
        prefs.getBool(_azanKey) ?? false;

    if (!mounted) return;

    setState(() {
      azanEnabled =
          widget.isLocationAvailable &&
              masterEnabled &&
              savedPrayerState;
    });
  }

  // =========================================================
  // NOTIFICATION DIALOG
  // =========================================================
  Future<void> _showNotificationDialog() async {
    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: 28.w,
          ),
          child: Container(
            padding: EdgeInsets.all(22.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Notification Icon
                Container(
                  width: 65.w,
                  height: 65.w,
                  decoration: BoxDecoration(
                    color: AppColors.DarkGreenColor
                        .withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: AppColors.DarkGreenColor,
                    size: 32.sp,
                  ),
                ),

                SizedBox(height: 18.h),

                // Title
                Text(
                  'إشعارات الأذان',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.BlackColor,
                  ),
                ),

                SizedBox(height: 10.h),

                // Description
                Text(
                  'يرجى تفعيل إشعارات الأذان من الإعدادات أولًا '
                      'حتى تتمكن من تشغيل الأذان.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14.sp,
                    height: 1.7,
                    color: AppColors.BlackColor
                        .withOpacity(0.65),
                  ),
                ),

                SizedBox(height: 24.h),

                // Go to Settings
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();

                      Navigator.of(context).pushNamed(
                        AppRoutes.settingScreenRoutename,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      AppColors.DarkGreenColor,
                      foregroundColor:
                      AppColors.whiteColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      'الذهاب إلى الإعدادات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                // Cancel
                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text(
                      'إلغاء',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
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
  // OPEN ANDROID NOTIFICATION SETTINGS
  // =========================================================

  Future<void> _openNotificationSettings() async {
    const intent = AndroidIntent(
      action:
      'android.settings.APP_NOTIFICATION_SETTINGS',
      arguments: <String, dynamic>{
        'android.provider.extra.APP_PACKAGE':
        'com.example.islamic',
      },
    );

    try {
      await intent.launch();
    } catch (e) {
      debugPrint(
        'Could not open notification settings: $e',
      );

      const fallbackIntent = AndroidIntent(
        action:
        'android.settings.APPLICATION_DETAILS_SETTINGS',
        data: 'package:com.example.islamic',
      );

      try {
        await fallbackIntent.launch();
      } catch (e) {
        debugPrint(
          'Could not open app settings: $e',
        );
      }
    }
  }

  // =========================================================
  // TOGGLE PRAYER
  // =========================================================

  Future<void> _toggleAzan(bool value,) async {
    // -------------------------------------------------------
    // LOCATION REQUIRED
    // -------------------------------------------------------

    if (!widget.isLocationAvailable) {
      return;
    }

    // -------------------------------------------------------
    // MASTER MUST BE ON
    // -------------------------------------------------------

    final masterEnabled =
        AthanScheduler.athanEnabledNotifier.value;

    if (!masterEnabled) {
      if (mounted) {
        setState(() {
          azanEnabled = false;
        });
      }

      // Show dialog instead of silently returning
      await _showNotificationDialog();

      return;
    }

    final prefs =
    await SharedPreferences.getInstance();

    // Check again from SharedPreferences
    final savedMasterState =
        prefs.getBool(
          AthanScheduler.athanMasterKey,
        ) ??
            false;

    if (!savedMasterState) {
      if (mounted) {
        setState(() {
          azanEnabled = false;
        });
      }

      await _showNotificationDialog();

      return;
    }

    // -------------------------------------------------------
    // UPDATE UI
    // -------------------------------------------------------

    if (!mounted) return;

    setState(() {
      azanEnabled = value;
    });

    // -------------------------------------------------------
    // SAVE PRAYER STATE
    // -------------------------------------------------------

    await prefs.setBool(
      _azanKey,
      value,
    );

    // -------------------------------------------------------
    // SAVE PRAYER NAME
    // -------------------------------------------------------

    await prefs.setString(
      'azan_prayer_name_${widget.fardName}',
      _getLocalizedPrayerName(context),
    );

    debugPrint(
      'AZAN ${widget.fardName} => $value',
    );

    // -------------------------------------------------------
    // TELL PRAYER TIMES SCREEN
    // -------------------------------------------------------

    if (widget.onToggle != null) {
      await widget.onToggle!(value);
    }
  }

  // =========================================================
  // LOCALIZED PRAYER NAME
  // =========================================================

  String _getLocalizedPrayerName(BuildContext context,) {
    final localizations =
    AppLocalizations.of(context)!;

    switch (widget.fardName) {
      case 'fajr':
        return localizations.fajr;

      case 'dhuhr':
        return localizations.dhuhr;

      case 'asr':
        return localizations.asr;

      case 'maghrib':
        return localizations.maghrib;

      case 'isha':
        return localizations.isha;

      default:
        return widget.fardName;
    }
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    AthanScheduler.athanEnabledNotifier
        .removeListener(_onMasterAthanChanged);

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    // Get current Master state
    final masterAthanEnabled =
        AthanScheduler.athanEnabledNotifier.value;

    final bool canToggle =
        widget.isLocationAvailable &&
            masterAthanEnabled;

    // =======================================================
    // IMPORTANT
    //
    // We DON'T change the UI.
    //
    // The switch stays clickable when Master is OFF,
    // only so it can show the dialog.
    // =======================================================

    final bool switchEnabled =
        widget.isLocationAvailable;

    return Padding(
      padding: EdgeInsets.only(
        bottom: 12.h,
        right: 28.w,
        left: 28.w,
      ),
      child: Opacity(
        opacity:
        !widget.isLocationAvailable
            ? 0.5
            : !masterAthanEnabled
            ? 0.5
            : azanEnabled
            ? 1
            : 0.65,
        child: Container(
          width: 375.w,
          height: 116.h,
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(20),
            color: AppColors.whiteColor,
          ),
          child: Padding(
            padding:
            const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // =================================================
                // TIME + SWITCH
                // =================================================

                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.azanTime,
                      style: const TextStyle(
                        fontSize: 30,
                        color:
                        AppColors.BlackColor,
                        fontWeight:
                        FontWeight.w400,
                        fontFamily: 'Cairo',
                      ),
                    ),

                    Row(
                      children: [
                        Image(
                          image: AssetImage(
                            AppImages.notficationIcon,
                          ),
                        ),

                        SizedBox(
                          width: 10.w,
                        ),

                        Switch(
                          value: azanEnabled,

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
                          switchEnabled
                              ? _toggleAzan
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // =================================================
                // PRAYER NAME
                // =================================================

                Text(
                  _getLocalizedPrayerName(
                    context,
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    color:
                    AppColors.BlackColor,
                    fontWeight:
                    FontWeight.w500,
                    fontFamily: 'Cairo',
                  ),
                ),

                SizedBox(
                  width: 16.w,
                ),

                // =================================================
                // PRAYER IMAGE
                // =================================================

                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color:
                    AppColors
                        .lightGreyColor,
                    borderRadius:
                    BorderRadius.circular(
                      24,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                      25,
                    ),
                    child: Image(
                      image: AssetImage(
                        widget.fardImage,
                      ),
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