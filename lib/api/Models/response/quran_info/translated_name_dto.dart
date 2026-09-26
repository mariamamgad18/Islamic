import 'package:json_annotation/json_annotation.dart';

part 'translated_name_dto.g.dart';

@JsonSerializable()
class TranslatedNameDto {
  @JsonKey(name: 'language_name')
  final String languageName;

  final String name;

  TranslatedNameDto({required this.languageName, required this.name});

  factory TranslatedNameDto.fromJson(Map<String, dynamic> json) =>
      _$TranslatedNameDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TranslatedNameDtoToJson(this);
}
