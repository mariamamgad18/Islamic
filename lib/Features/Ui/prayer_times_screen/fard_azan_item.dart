import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final Future<void> Function(
      bool value,
      )? onToggle;

  @override
  State<FardAzanItem> createState() =>
      _FardAzanItemState();
}

class _FardAzanItemState extends State<FardAzanItem> {
  bool azanEnabled = false;

  // =========================================================
  // GET PREFERENCE ID
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
  // AZAN KEY
  // =========================================================

  String get _azanKey {
    return 'azan_enabled_${_getPreferenceId()}';
  }

  // =========================================================
  // GET LOCALIZED PRAYER NAME
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
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    _loadAzanState();
  }

  // =========================================================
  // LOAD SWITCH STATE
  // =========================================================

  Future<void> _loadAzanState() async {
    final prefs =
    await SharedPreferences.getInstance();

    final savedState =
        prefs.getBool(_azanKey) ?? false;

    if (!mounted) return;

    setState(() {
      azanEnabled =
      widget.isLocationAvailable
          ? savedState
          : false;
    });
  }

  // =========================================================
  // TOGGLE
  // =========================================================

  Future<void> _toggleAzan(bool value,) async {
    if (!widget.isLocationAvailable) {
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      azanEnabled = value;
    });

    final prefs =
    await SharedPreferences.getInstance();

    // Save switch state.
    await prefs.setBool(
      _azanKey,
      value,
    );

    // Save localized prayer name.
    await prefs.setString(
      'azan_prayer_name_${widget.fardName}',
      _getLocalizedPrayerName(context),
    );

    debugPrint(
      'SAVE ${widget.fardName} => $value',
    );

    // Let PrayerTimesScreen handle scheduling.
    if (widget.onToggle != null) {
      await widget.onToggle!(value);
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context,) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 12.h,
        right: 28.w,
        left: 28.w,
      ),
      child: Opacity(
        opacity:
        widget.isLocationAvailable
            ? (azanEnabled ? 1 : 0.5)
            : 0.5,
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
                            AppImages
                                .notficationIcon,
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
                          AppColors.GreyColor,
                          onChanged:
                          widget
                              .isLocationAvailable
                              ? _toggleAzan
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

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

                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration:
                  BoxDecoration(
                    color: AppColors
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