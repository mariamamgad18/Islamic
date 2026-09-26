import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_device_compass/flutter_device_compass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:islamic/core/Utils/app_colors.dart';

import '../../../l10n/app_localizations.dart';
import 'qebla_indicator.dart';
import 'qibla_service.dart';

class QeblaScreen extends StatefulWidget {
  const QeblaScreen({super.key});

  @override
  State<QeblaScreen> createState() => _QeblaScreenState();
}

class _QeblaScreenState extends State<QeblaScreen> {
  // =====================================================
  // SUBSCRIPTIONS
  // =====================================================

  StreamSubscription<ServiceStatus>?
  _locationServiceSubscription;

  StreamSubscription<CompassEvent>?
  _compassSubscription;

  // =====================================================
  // QIBLA DATA
  // =====================================================

  double? _qiblaDirection;
  double? _distanceKm;

  // =====================================================
  // DEVICE COMPASS
  // =====================================================

  double? _deviceHeading;

  // =====================================================
  // STATES
  // =====================================================

  bool _loading = true;
  bool _isLoadingLocation = false;

  String? _errorMessage;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void initState() {
    super.initState();

    _loadQiblaData();

    // Listen for Location ON/OFF.
    _locationServiceSubscription =
        Geolocator.getServiceStatusStream().listen(
              (ServiceStatus status) {
            if (status == ServiceStatus.enabled) {
              _loadQiblaData();
            }
          },
        );
  }

  // =====================================================
  // LOAD QIBLA DATA
  // =====================================================

  Future<void> _loadQiblaData() async {
    // Prevent duplicate requests.
    if (_isLoadingLocation) {
      return;
    }

    _isLoadingLocation = true;

    if (mounted) {
      setState(() {
        _loading = true;

        _qiblaDirection = null;
        _distanceKm = null;
        _deviceHeading = null;

        _errorMessage = null;
      });
    }

    try {
      // ===================================================
      // GET LOCATION
      // ===================================================

      final Position position =
      await QiblaService.getCurrentLocation();

      // ===================================================
      // CALCULATE QIBLA
      // ===================================================

      final double direction =
      QiblaService.calculateQiblaDirection(
        position.latitude,
        position.longitude,
      );

      // ===================================================
      // CALCULATE DISTANCE
      // ===================================================

      final double distance =
      QiblaService.calculateDistanceKm(
        position.latitude,
        position.longitude,
      );

      if (!mounted) {
        return;
      }

      // ===================================================
      // UPDATE UI
      // ===================================================

      setState(() {
        _qiblaDirection = direction;
        _distanceKm = distance;

        _loading = false;
        _errorMessage = null;
      });

      // ===================================================
      // START COMPASS
      // ===================================================

      _startCompass();
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;

        _qiblaDirection = null;
        _distanceKm = null;
        _deviceHeading = null;

        _errorMessage = e.toString();
      });
    } finally {
      _isLoadingLocation = false;
    }
  }

  // =====================================================
  // START COMPASS
  // =====================================================

  void _startCompass() {
    // Cancel old subscription first.
    _compassSubscription?.cancel();

    _compassSubscription =
        FlutterCompass.events?.listen(
              (CompassEvent event) {
            final double? heading = event.heading;

            // Some devices can return null.
            if (heading == null) {
              return;
            }

            if (!mounted) {
              return;
            }

            // First valid compass reading.
            setState(() {
              _deviceHeading = heading;
            });
          },
        );
  }

  // =====================================================
  // GET DIRECTION NAME
  // =====================================================

  String _getDirectionName(BuildContext context,
      double? direction,) {
    if (direction == null) {
      return '--';
    }

    final l10n =
    AppLocalizations.of(context)!;

    final double normalizedDirection =
        direction % 360;

    if (normalizedDirection >= 337.5 ||
        normalizedDirection < 22.5) {
      return l10n.north;
    }

    if (normalizedDirection >= 22.5 &&
        normalizedDirection < 67.5) {
      return l10n.northEast;
    }

    if (normalizedDirection >= 67.5 &&
        normalizedDirection < 112.5) {
      return l10n.east;
    }

    if (normalizedDirection >= 112.5 &&
        normalizedDirection < 157.5) {
      return l10n.southEast;
    }

    if (normalizedDirection >= 157.5 &&
        normalizedDirection < 202.5) {
      return l10n.south;
    }

    if (normalizedDirection >= 202.5 &&
        normalizedDirection < 247.5) {
      return l10n.southWest;
    }

    if (normalizedDirection >= 247.5 &&
        normalizedDirection < 292.5) {
      return l10n.west;
    }

    return l10n.northWest;
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void dispose() {
    _compassSubscription?.cancel();

    _locationServiceSubscription?.cancel();

    super.dispose();
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    final l10n =
    AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor:
      AppColors.semiwhiteColor,
      body: Column(
        children: [
          // =================================================
          // HEADER
          // =================================================

          Container(
            width: double.infinity,
            height: 110.h,
            decoration: BoxDecoration(
              color: AppColors.DarkGreenColor,
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
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: [
                      Text(
                        l10n.qibla,
                        style: TextStyle(
                          fontSize: 24.sp,
                          color:
                          AppColors.whiteColor,
                          fontWeight:
                          FontWeight.w500,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        l10n.qiblaMakkahDescription,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color:
                          AppColors.whiteColor,
                          fontWeight:
                          FontWeight.w400,
                          fontFamily: 'Cairo',
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
                      size: 18.sp,
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25.h),

                  // =================================================
                  // QIBLA INDICATOR
                  // =================================================

                  QeblaIndicator(
                    deviceHeading:
                    _deviceHeading,
                    qiblaDirection:
                    _qiblaDirection,
                    loading: _loading,
                    errorMessage:
                    _errorMessage,
                  ),

                  SizedBox(height: 15.h),

                  // =================================================
                  // INFORMATION CARD
                  // =================================================

                  Padding(
                    padding:
                    EdgeInsets.symmetric(
                      horizontal: 23.w,
                    ),
                    child:
                    QiblaInformationCard(
                      qiblaDirection:
                      _qiblaDirection,
                      distanceKm:
                      _distanceKm,
                      loading: _loading,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // =================================================
                  // STATUS MESSAGE
                  // =================================================

                  QiblaStatusMessage(
                    deviceHeading:
                    _deviceHeading,
                    qiblaDirection:
                    _qiblaDirection,
                  ),

                  SizedBox(height: 12.h),

                  // =================================================
                  // TIP
                  // =================================================

                  Padding(
                    padding:
                    EdgeInsets.symmetric(
                      horizontal: 23.w,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration:
                      BoxDecoration(
                        color:
                        AppColors
                            .lightYellowColor,
                        borderRadius:
                        BorderRadius.circular(
                          20.r,
                        ),
                        border: Border.all(
                          color:
                          AppColors.YellowColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          l10n.phoneFlatTip,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color:
                            AppColors.GreyColor,
                            fontWeight:
                            FontWeight.w400,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// INFORMATION CARD
// =====================================================

class QiblaInformationCard extends StatelessWidget {
  final double? qiblaDirection;
  final double? distanceKm;
  final bool loading;

  const QiblaInformationCard({
    super.key,
    required this.qiblaDirection,
    required this.distanceKm,
    required this.loading,
  });

  String _getDirectionName(BuildContext context,
      double? direction,) {
    if (direction == null) {
      return '--';
    }

    final l10n =
    AppLocalizations.of(context)!;

    final double normalizedDirection =
        direction % 360;

    if (normalizedDirection >= 337.5 ||
        normalizedDirection < 22.5) {
      return l10n.north;
    }

    if (normalizedDirection >= 22.5 &&
        normalizedDirection < 67.5) {
      return l10n.northEast;
    }

    if (normalizedDirection >= 67.5 &&
        normalizedDirection < 112.5) {
      return l10n.east;
    }

    if (normalizedDirection >= 112.5 &&
        normalizedDirection < 157.5) {
      return l10n.southEast;
    }

    if (normalizedDirection >= 157.5 &&
        normalizedDirection < 202.5) {
      return l10n.south;
    }

    if (normalizedDirection >= 202.5 &&
        normalizedDirection < 247.5) {
      return l10n.southWest;
    }

    if (normalizedDirection >= 247.5 &&
        normalizedDirection < 292.5) {
      return l10n.west;
    }

    return l10n.northWest;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 82.h,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius:
        BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            // =================================================
            // QIBLA DIRECTION
            // =================================================

            Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Text(
                  loading ||
                      qiblaDirection == null
                      ? '--°'
                      : '${qiblaDirection!.round()}°',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color:
                    AppColors.DarkGreenColor,
                    fontWeight:
                    FontWeight.w400,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  loading ||
                      qiblaDirection == null
                      ? '--'
                      : _getDirectionName(
                    context,
                    qiblaDirection,
                  ),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.GreyColor,
                    fontWeight:
                    FontWeight.w400,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),

            const Spacer(),

            // =================================================
            // DISTANCE
            // =================================================

            Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context)!
                      .distanceToMakkah,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.GreyColor,
                    fontWeight:
                    FontWeight.w400,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text(
                  loading ||
                      distanceKm == null
                      ? '--'
                      : '${distanceKm!.round()} كم',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.BlackColor,
                    fontWeight:
                    FontWeight.w500,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),

            SizedBox(width: 12.w),

            // =================================================
            // ICON
            // =================================================

            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color:
                AppColors.DarkGreenColor,
                borderRadius:
                BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.navigation,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// STATUS MESSAGE
// =====================================================

class QiblaStatusMessage extends StatelessWidget {
  final double? deviceHeading;
  final double? qiblaDirection;

  const QiblaStatusMessage({
    super.key,
    required this.deviceHeading,
    required this.qiblaDirection,
  });

  @override
  Widget build(BuildContext context) {
    final l10n =
    AppLocalizations.of(context)!;

    // ===================================================
    // SUCCESS
    // ===================================================

    final bool directionDetected =
        deviceHeading != null &&
            qiblaDirection != null;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 23.w,
      ),
      child: Container(
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          color:
          AppColors.lightGreenColor2,
          borderRadius:
          BorderRadius.circular(20.r),
          border: Border.all(
            color:
            AppColors.DarkGreenColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.end,
            children: [
              Text(
                directionDetected
                    ? l10n.qiblaSuccess
                    : l10n.detectingDeviceDirection,
                style: TextStyle(
                  fontSize: 14.sp,
                  color:
                  AppColors.BlackColor,
                  fontWeight:
                  FontWeight.w400,
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                width: 8.w,
                height: 8.h,
                decoration:
                BoxDecoration(
                  color:
                  AppColors.DarkGreenColor,
                  borderRadius:
                  BorderRadius.circular(20.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}