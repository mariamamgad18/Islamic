import 'package:json_annotation/json_annotation.dart';

import 'chapter_dto.dart';

part 'quran_info_data_dto.g.dart';

@JsonSerializable()
class QuranInfoDataDto {
  final List<ChapterDto> chapters;

  QuranInfoDataDto({required this.chapters});

  factory QuranInfoDataDto.fromJson(Map<String, dynamic> json) =>
      _$QuranInfoDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuranInfoDataDtoToJson(this);
}
