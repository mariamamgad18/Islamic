import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/Utils/app_colors.dart';

class AthanScreen extends StatelessWidget {
  const AthanScreen({
    super.key,
    required this.athanId,
    required this.prayerName,
  });

  final int athanId;
  final String prayerName;

  // =========================================================
  // NATIVE ATHAN ACTIVITY CHANNEL
  // =========================================================

  static const MethodChannel athanActivityChannel = MethodChannel(
    'athan_activity_channel',
  );

  // =========================================================
  // STOP ATHAN
  // =========================================================

  Future<void> _stopAthan(BuildContext context) async {
    try {
      await athanActivityChannel.invokeMethod('stopAthan');

      debugPrint('ATHAN STOPPED SUCCESSFULLY');
    } catch (e) {
      debugPrint('ERROR STOPPING ATHAN: $e');
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.DarkGreenColor,

      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // =================================================
              // ICON
              // =================================================
              Container(
                width: 120.w,
                height: 120.w,

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.mosque_rounded,
                  color: Colors.white,
                  size: 65.sp,
                ),
              ),

              SizedBox(height: 35.h),

              // =================================================
              // TITLE
              // =================================================
              Text(
                'حان الآن موعد الأذان',

                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),

              SizedBox(height: 15.h),

              // =================================================
              // PRAYER NAME
              // =================================================
              Text(
                'أذان $prayerName',

                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo',
                ),
              ),

              SizedBox(height: 60.h),

              // =================================================
              // STOP BUTTON
              // =================================================
              SizedBox(
                width: 250.w,
                height: 60.h,

                child: ElevatedButton(
                  onPressed: () {
                    _stopAthan(context);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,

                    foregroundColor: AppColors.DarkGreenColor,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),

                  child: Text(
                    'إيقاف الأذان',

                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
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
