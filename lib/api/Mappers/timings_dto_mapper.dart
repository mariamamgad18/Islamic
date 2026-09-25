import 'package:islamic/Domain/entities/response/prayer_times/timing.dart';

import '../Models/response/prayer_times/timing_dto.dart';

extension TimingsDtoMapper on TimingsDto {
  Timings toEntity() {
    return Timings(
      fajr: fajr,
      sunrise: sunrise,
      dhuhr: dhuhr,
      asr: asr,
      sunset: sunset,
      maghrib: maghrib,
      isha: isha,
      imsak: imsak,
      midnight: midnight,
      firstthird: firstthird,
      lastthird: lastthird,
    );
  }
}
