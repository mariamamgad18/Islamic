import 'package:islamic/api/Mappers/prayer_data_dto_mapper.dart';

import '../../Domain/entities/response/prayer_times/prayers_times.dart';
import '../Models/response/prayer_times/prayers_times_dto.dart';

extension PrayersTimesDtoMapper on PrayersTimesDto {
  PrayersTimes toEntity() {
    return PrayersTimes(code: code, status: status, data: data.toEntity());
  }
}
