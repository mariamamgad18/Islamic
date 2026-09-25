import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:islamic/Data/data_sources/remote/prayers_times/prayer_times_remote_data_source.dart';
import 'package:islamic/api/Models/response/prayer_times/prayers_times_dto.dart';
import 'package:islamic/api/api_services.dart';

@Injectable(as: PrayerTimesRemoteDataSource)
class PrayerTimesRemoteDataSourceImpl implements PrayerTimesRemoteDataSource {
  final AladhanApiServices apiServices;

  PrayerTimesRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<PrayersTimesDto> getPrayerTimes({
    required String date,
    required double latitude,
    required double longitude,
    required int method,
  }) async {
    final response = await apiServices.getPrayerTimes(
      date,
      latitude,
      longitude,
      method,
    );

    debugPrint("========== PRAYER API ==========");
    debugPrint("DATE: $date");
    debugPrint("LATITUDE: $latitude");
    debugPrint("LONGITUDE: $longitude");
    debugPrint("METHOD: $method");

    // نشوف الـ headers والـ raw response
    debugPrint("STATUS CODE: ${response.response.statusCode}");
    debugPrint("RAW RESPONSE: ${response.response.data}");

    debugPrint("FAJR: ${response.data.data.timings.fajr}");
    debugPrint("SUNRISE: ${response.data.data.timings.sunrise}");
    debugPrint("DHUHR: ${response.data.data.timings.dhuhr}");
    debugPrint("ASR: ${response.data.data.timings.asr}");
    debugPrint("MAGHRIB: ${response.data.data.timings.maghrib}");
    debugPrint("ISHA: ${response.data.data.timings.isha}");

    debugPrint("=================================");

    return response.data;
  }
}
