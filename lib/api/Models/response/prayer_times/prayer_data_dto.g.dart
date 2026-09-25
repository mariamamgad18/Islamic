// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrayerDataDto _$PrayerDataDtoFromJson(Map<String, dynamic> json) =>
    PrayerDataDto(
      timings: TimingsDto.fromJson(json['timings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrayerDataDtoToJson(PrayerDataDto instance) =>
    <String, dynamic>{'timings': instance.timings};
