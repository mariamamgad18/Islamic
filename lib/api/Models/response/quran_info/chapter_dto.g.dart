// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterDto _$ChapterDtoFromJson(Map<String, dynamic> json) => ChapterDto(
  id: IntConverter.fromJson(json['id']),
  revelationPlace: json['revelation_place'] as String,
  revelationOrder: IntConverter.fromJson(json['revelation_order']),
  bismillahPre: json['bismillah_pre'] as bool,
  nameSimple: json['name_simple'] as String,
  nameArabic: json['name_arabic'] as String,
  versesCount: IntConverter.fromJson(json['verses_count']),
  pages: ChapterDto._pagesFromJson(json['pages']),
  translatedName: TranslatedNameDto.fromJson(
    json['translated_name'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ChapterDtoToJson(ChapterDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'revelation_place': instance.revelationPlace,
      'revelation_order': instance.revelationOrder,
      'bismillah_pre': instance.bismillahPre,
      'name_simple': instance.nameSimple,
      'name_arabic': instance.nameArabic,
      'verses_count': instance.versesCount,
      'pages': instance.pages,
      'translated_name': instance.translatedName,
    };
