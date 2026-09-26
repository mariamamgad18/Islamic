import '../../entities/response/azkar/azkar.dart';

abstract class AzkarRepository {
  Future<List<Azkar>> getAzkar(String category);
}
