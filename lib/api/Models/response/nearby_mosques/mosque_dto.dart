import 'package:json_annotation/json_annotation.dart';

part 'mosque_dto.g.dart';

@JsonSerializable()
class MosqueDto {
  final String? id;

  final DisplayNameDto? displayName;

  final String? formattedAddress;

  final LocationDto? location;

  const MosqueDto({
    this.id,
    this.displayName,
    this.formattedAddress,
    this.location,
  });

  factory MosqueDto.fromJson(Map<String, dynamic> json) =>
      _$MosqueDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MosqueDtoToJson(this);
}

@JsonSerializable()
class DisplayNameDto {
  final String? text;

  const DisplayNameDto({this.text});

  factory DisplayNameDto.fromJson(Map<String, dynamic> json) =>
      _$DisplayNameDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DisplayNameDtoToJson(this);
}

@JsonSerializable()
class LocationDto {
  final double? latitude;
  final double? longitude;

  const LocationDto({this.latitude, this.longitude});

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}
