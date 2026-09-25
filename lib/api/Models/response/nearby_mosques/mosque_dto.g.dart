// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mosque_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MosqueDto _$MosqueDtoFromJson(Map<String, dynamic> json) => MosqueDto(
  id: json['id'] as String?,
  displayName:
      json['displayName'] == null
          ? null
          : DisplayNameDto.fromJson(
            json['displayName'] as Map<String, dynamic>,
          ),
  formattedAddress: json['formattedAddress'] as String?,
  location:
      json['location'] == null
          ? null
          : LocationDto.fromJson(json['location'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MosqueDtoToJson(MosqueDto instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'formattedAddress': instance.formattedAddress,
  'location': instance.location,
};

DisplayNameDto _$DisplayNameDtoFromJson(Map<String, dynamic> json) =>
    DisplayNameDto(text: json['text'] as String?);

Map<String, dynamic> _$DisplayNameDtoToJson(DisplayNameDto instance) =>
    <String, dynamic>{'text': instance.text};

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
