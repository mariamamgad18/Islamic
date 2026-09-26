import 'package:json_annotation/json_annotation.dart';

part 'azkar_dto.g.dart';

@JsonSerializable()
class AzkarDto {
  final int id;
  final int count;

  final String text;
  final String? reference;

  AzkarDto({
    required this.id,
    required this.text,
    this.reference,
    required this.count,
  });

  factory AzkarDto.fromJson(Map<String, dynamic> json) =>
      _$AzkarDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AzkarDtoToJson(this);
}
