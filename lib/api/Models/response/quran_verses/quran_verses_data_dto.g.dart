// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_verses_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranVersesDataDto _$QuranVersesDataDtoFromJson(Map<String, dynamic> json) =>
    QuranVersesDataDto(
      verses:
          (json['verses'] as List<dynamic>)
              .map((e) => VerseDto.fromJson(e as Map<String, dynamic>))
              .toList(),
      pagination: PaginationDto.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$QuranVersesDataDtoToJson(QuranVersesDataDto instance) =>
    <String, dynamic>{
      'verses': instance.verses,
      'pagination': instance.pagination,
    };
