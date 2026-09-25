// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azkar_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AzkarDto _$AzkarDtoFromJson(Map<String, dynamic> json) => AzkarDto(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  reference: json['reference'] as String?,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$AzkarDtoToJson(AzkarDto instance) => <String, dynamic>{
  'id': instance.id,
  'count': instance.count,
  'text': instance.text,
  'reference': instance.reference,
};
