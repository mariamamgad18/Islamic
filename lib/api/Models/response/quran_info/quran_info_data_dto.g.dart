// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_info_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranInfoDataDto _$QuranInfoDataDtoFromJson(Map<String, dynamic> json) =>
    QuranInfoDataDto(
      chapters:
          (json['chapters'] as List<dynamic>)
              .map((e) => ChapterDto.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$QuranInfoDataDtoToJson(QuranInfoDataDto instance) =>
    <String, dynamic>{'chapters': instance.chapters};
