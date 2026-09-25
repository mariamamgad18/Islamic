// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerseDto _$VerseDtoFromJson(Map<String, dynamic> json) => VerseDto(
  id: (json['id'] as num).toInt(),
  verseNumber: (json['verse_number'] as num).toInt(),
  verseKey: json['verse_key'] as String,
  chapterId: (json['chapter_id'] as num).toInt(),
  juz: (json['juz'] as num).toInt(),
  hizb: (json['hizb'] as num).toInt(),
  rub: (json['rub'] as num).toInt(),
  ruku: (json['ruku'] as num).toInt(),
  manzil: (json['manzil'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  textUthmani: json['text_uthmani'] as String,
);

Map<String, dynamic> _$VerseDtoToJson(VerseDto instance) => <String, dynamic>{
  'id': instance.id,
  'verse_number': instance.verseNumber,
  'verse_key': instance.verseKey,
  'chapter_id': instance.chapterId,
  'juz': instance.juz,
  'hizb': instance.hizb,
  'rub': instance.rub,
  'ruku': instance.ruku,
  'manzil': instance.manzil,
  'page': instance.page,
  'text_uthmani': instance.textUthmani,
};
