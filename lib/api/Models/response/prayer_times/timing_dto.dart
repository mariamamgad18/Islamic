import 'package:json_annotation/json_annotation.dart';

part 'timing_dto.g.dart';

@JsonSerializable()
class TimingsDto {
  @JsonKey(name: 'Fajr')
  final String fajr;

  @JsonKey(name: 'Sunrise')
  final String sunrise;

  @JsonKey(name: 'Dhuhr')
  final String dhuhr;

  @JsonKey(name: 'Asr')
  final String asr;

  @JsonKey(name: 'Sunset')
  final String sunset;

  @JsonKey(name: 'Maghrib')
  final String maghrib;

  @JsonKey(name: 'Isha')
  final String isha;

  @JsonKey(name: 'Imsak')
  final String imsak;

  @JsonKey(name: 'Midnight')
  final String midnight;

  @JsonKey(name: 'Firstthird')
  final String firstthird;

  @JsonKey(name: 'Lastthird')
  final String lastthird;

  TimingsDto({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory TimingsDto.fromJson(Map<String, dynamic> json) =>
      _$TimingsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TimingsDtoToJson(this);
}
