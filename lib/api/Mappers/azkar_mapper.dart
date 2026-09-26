import '../../Domain/entities/response/azkar/azkar.dart';
import '../Models/response/azkar/azkar_dto.dart';

extension AzkarMapper on AzkarDto {
  Azkar toDomain() {
    return Azkar(id: id, text: text, reference: reference, count: count);
  }
}
