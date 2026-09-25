// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayers_times_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrayersTimesDto _$PrayersTimesDtoFromJson(Map<String, dynamic> json) =>
    PrayersTimesDto(
      code: (json['code'] as num).toInt(),
      status: json['status'] as String,
      data: PrayerDataDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrayersTimesDtoToJson(PrayersTimesDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
