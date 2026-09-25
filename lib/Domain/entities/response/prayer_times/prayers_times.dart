// ده الريسبونس كله
import 'package:islamic/Domain/entities/response/prayer_times/prayer_data.dart';

class PrayersTimes {
  final int code;
  final String status;
  final PrayerData data;

  PrayersTimes({required this.code, required this.status, required this.data});
}
