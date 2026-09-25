// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_verses_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranVersesDto _$QuranVersesDtoFromJson(Map<String, dynamic> json) =>
    QuranVersesDto(
      code: IntConverter.fromJson(json['code']),
      status: json['status'] as String,
      data: QuranVersesDataDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuranVersesDtoToJson(QuranVersesDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'data': instance.data,
    };
