import 'package:islamic/api/Models/response/azkar/azkar_dto.dart';

abstract class AzkarLocalDataSource {
  Future<List<AzkarDto>> getAzkar(String category);
}
