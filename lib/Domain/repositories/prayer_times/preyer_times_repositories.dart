import '../../entities/response/prayer_times/prayers_times.dart';

abstract class PreyerTimesRepositories {
  Future<PrayersTimes> getPrayerTimes({
    required String date,
    required double latitude,
    required double longitude,
    required int method,
  });
}
