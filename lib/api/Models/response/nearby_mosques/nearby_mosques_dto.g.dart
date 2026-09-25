// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_mosques_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyMosquesDto _$NearbyMosquesDtoFromJson(Map<String, dynamic> json) =>
    NearbyMosquesDto(
      places:
          (json['places'] as List<dynamic>?)
              ?.map((e) => MosqueDto.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$NearbyMosquesDtoToJson(NearbyMosquesDto instance) =>
    <String, dynamic>{'places': instance.places};
