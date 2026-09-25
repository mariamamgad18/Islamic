import 'package:islamic/api/Mappers/timings_dto_mapper.dart';

import '../../Domain/entities/response/prayer_times/prayer_data.dart';
import '../Models/response/prayer_times/prayer_data_dto.dart';

extension PrayerDataDtoMapper on PrayerDataDto {
  PrayerData toEntity() {
    return PrayerData(timings: timings.toEntity());
  }
}
