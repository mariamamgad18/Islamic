import 'package:islamic/api/Models/response/prayer_times/timing_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prayer_data_dto.g.dart';

@JsonSerializable()
class PrayerDataDto {
  final TimingsDto timings;

  PrayerDataDto({required this.timings});

  factory PrayerDataDto.fromJson(Map<String, dynamic> json) =>
      _$PrayerDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PrayerDataDtoToJson(this);
}
