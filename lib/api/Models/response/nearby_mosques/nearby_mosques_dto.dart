import 'package:json_annotation/json_annotation.dart';

import 'mosque_dto.dart';

part 'nearby_mosques_dto.g.dart';

@JsonSerializable()
class NearbyMosquesDto {
  final List<MosqueDto>? places;

  const NearbyMosquesDto({this.places});

  factory NearbyMosquesDto.fromJson(Map<String, dynamic> json) =>
      _$NearbyMosquesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyMosquesDtoToJson(this);
}
