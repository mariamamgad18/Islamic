import 'package:json_annotation/json_annotation.dart';

import '../quran_info/int_converter.dart';
import 'quran_verses_data_dto.dart';

part 'quran_verses_dto.g.dart';

@JsonSerializable()
class QuranVersesDto {
  @JsonKey(fromJson: IntConverter.fromJson)
  final int code;

  final String status;
  final QuranVersesDataDto data;

  QuranVersesDto({
    required this.code,
    required this.status,
    required this.data,
  });

  factory QuranVersesDto.fromJson(Map<String, dynamic> json) =>
      _$QuranVersesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuranVersesDtoToJson(this);
}
