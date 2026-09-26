import 'package:islamic/api/Models/response/prayer_times/prayers_times_dto.dart';

abstract class PrayerTimesRemoteDataSource {
  Future<PrayersTimesDto> getPrayerTimes({
    required String date,
    required double latitude,
    required double longitude,
    required int method,
  });
}
