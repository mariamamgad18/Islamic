import 'package:islamic/api/Models/response/quran_info/int_converter.dart';
import 'package:islamic/api/Models/response/quran_info/translated_name_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chapter_dto.g.dart';

@JsonSerializable()
class ChapterDto {
  @JsonKey(fromJson: IntConverter.fromJson)
  final int id;

  @JsonKey(name: 'revelation_place')
  final String revelationPlace;

  @JsonKey(name: 'revelation_order', fromJson: IntConverter.fromJson)
  final int revelationOrder;

  @JsonKey(name: 'bismillah_pre')
  final bool bismillahPre;

  @JsonKey(name: 'name_simple')
  final String nameSimple;

  @JsonKey(name: 'name_arabic')
  final String nameArabic;

  @JsonKey(name: 'verses_count', fromJson: IntConverter.fromJson)
  final int versesCount;

  @JsonKey(fromJson: _pagesFromJson)
  final List<int> pages;

  @JsonKey(name: 'translated_name')
  final TranslatedNameDto translatedName;

  ChapterDto({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
    required this.translatedName,
  });

  static List<int> _pagesFromJson(dynamic value) {
    if (value is! List) {
      return [];
    }

    return value.where((e) => e is num).map((e) => (e as num).toInt()).toList();
  }

  factory ChapterDto.fromJson(Map<String, dynamic> json) =>
      _$ChapterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterDtoToJson(this);
}
