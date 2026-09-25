// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranInfoDto _$QuranInfoDtoFromJson(Map<String, dynamic> json) => QuranInfoDto(
  code: IntConverter.fromJson(json['code']),
  status: json['status'] as String,
  data: QuranInfoDataDto.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$QuranInfoDtoToJson(QuranInfoDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
