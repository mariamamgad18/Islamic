import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic/core/Utils/app_colors.dart';
import 'package:islamic/core/Utils/app_images.dart';

import '../../../l10n/app_localizations.dart';

class QeblaIndicator extends StatelessWidget {
  final double? deviceHeading;
  final double? qiblaDirection;
  final bool loading;
  final String? errorMessage;

  const QeblaIndicator({
    super.key,
    required this.deviceHeading,
    required this.qiblaDirection,
    required this.loading,
    required this.errorMessage,
  });

  double get _qiblaAngle {
    if (deviceHeading == null || qiblaDirection == null) {
      return 0;
    }

    double angle = qiblaDirection! - deviceHeading!;

    if (angle > 180) {
      angle -= 360;
    }

    if (angle < -180) {
      angle += 360;
    }

    return angle;
  }

  double get _qiblaAngleRadians {
    return _qiblaAngle * math.pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // =========================
    // LOADING
    // =========================

    if (loading) {
      return SizedBox(
        width: 384.w,
        height: 384.h,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // =========================
    // ERROR
    // =========================

    if (errorMessage != null) {
      return SizedBox(
        width: 384.w,
        height: 384.h,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.w),
            child: Text(
              '${l10n.qiblaDirectionError}\n\n'
                  '${l10n.qiblaLocationCompassTip}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.BlackColor,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ),
      );
    }

    // =========================
    // COMPASS
    // =========================

    return Stack(
      alignment: Alignment.center,
      children: [
        // =========================
        // COMPASS BACKGROUND
        // =========================

        Container(
          width: 384.w,
          height: 384.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImages.Bosla,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 30.h),

              Text(
                l10n.north,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Cairo',
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 126.h,
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.west,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Cairo',
                      ),
                    ),

                    const Spacer(),

                    Text(
                      l10n.east,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.BlackColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                l10n.south,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.BlackColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),

        // =========================
        // QIBLA ARROW
        // =========================

        Transform.rotate(
          angle: _qiblaAngleRadians,
          child: CustomPaint(
            size: Size(
              80.w,
              150.h,
            ),
            painter: QiblaArrowPainter(
              color: AppColors.DarkGreenColor,
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================
// QIBLA ARROW PAINTER
// =====================================================

class QiblaArrowPainter extends CustomPainter {
  final Color color;

  QiblaArrowPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas,
      Size size,) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;

    final Path path = Path();

    path.moveTo(centerX, 0);

    path.lineTo(
      size.width,
      55,
    );

    path.lineTo(
      centerX + 18,
      48,
    );

    path.lineTo(
      centerX + 18,
      size.height,
    );

    path.lineTo(
      centerX - 18,
      size.height,
    );

    path.lineTo(
      centerX - 18,
      48,
    );

    path.lineTo(
      0,
      55,
    );

    path.close();

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant QiblaArrowPainter oldDelegate,) {
    return oldDelegate.color != color;
  }
}