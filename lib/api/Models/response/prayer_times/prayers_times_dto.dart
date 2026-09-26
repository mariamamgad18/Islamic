import 'package:islamic/api/Models/response/prayer_times/prayer_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prayers_times_dto.g.dart';

// ده الريسبونس كله
@JsonSerializable()
class PrayersTimesDto {
  final int code;
  final String status;
  final PrayerDataDto data;

  PrayersTimesDto({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PrayersTimesDto.fromJson(Map<String, dynamic> json) =>
      _$PrayersTimesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PrayersTimesDtoToJson(this);
}
