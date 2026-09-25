import 'package:json_annotation/json_annotation.dart';

part 'verse_dto.g.dart';

@JsonSerializable()
class VerseDto {
  final int id;

  @JsonKey(name: 'verse_number')
  final int verseNumber;

  @JsonKey(name: 'verse_key')
  final String verseKey;

  @JsonKey(name: 'chapter_id')
  final int chapterId;

  final int juz;
  final int hizb;
  final int rub;
  final int ruku;
  final int manzil;
  final int page;

  @JsonKey(name: 'text_uthmani')
  final String textUthmani;

  VerseDto({
    required this.id,
    required this.verseNumber,
    required this.verseKey,
    required this.chapterId,
    required this.juz,
    required this.hizb,
    required this.rub,
    required this.ruku,
    required this.manzil,
    required this.page,
    required this.textUthmani,
  });

  factory VerseDto.fromJson(Map<String, dynamic> json) =>
      _$VerseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerseDtoToJson(this);
}
