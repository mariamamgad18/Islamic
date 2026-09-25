import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

@JsonSerializable()
class PaginationDto {
  final int total;
  final int page;

  @JsonKey(name: 'per_page')
  final int perPage;

  final int pages;

  PaginationDto({
    required this.total,
    required this.page,
    required this.perPage,
    required this.pages,
  });

  factory PaginationDto.fromJson(Map<String, dynamic> json) =>
      _$PaginationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationDtoToJson(this);
}
