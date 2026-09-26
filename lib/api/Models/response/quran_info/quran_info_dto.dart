import 'package:islamic/api/Models/response/quran_info/int_converter.dart';
import 'package:islamic/api/Models/response/quran_info/quran_info_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quran_info_dto.g.dart';

@JsonSerializable()
class QuranInfoDto {
  @JsonKey(fromJson: IntConverter.fromJson)
  final int code;

  final String status;

  final QuranInfoDataDto data;

  QuranInfoDto({required this.code, required this.status, required this.data});

  factory QuranInfoDto.fromJson(Map<String, dynamic> json) =>
      _$QuranInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuranInfoDtoToJson(this);
}
