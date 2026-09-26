import 'package:json_annotation/json_annotation.dart';

import 'pagination_dto.dart';
import 'verse_dto.dart';

part 'quran_verses_data_dto.g.dart';

@JsonSerializable()
class QuranVersesDataDto {
  final List<VerseDto> verses;
  final PaginationDto pagination;

  QuranVersesDataDto({required this.verses, required this.pagination});

  factory QuranVersesDataDto.fromJson(Map<String, dynamic> json) =>
      _$QuranVersesDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuranVersesDataDtoToJson(this);
}
