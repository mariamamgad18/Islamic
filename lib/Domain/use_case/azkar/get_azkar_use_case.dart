import 'package:injectable/injectable.dart';

import '../../entities/response/azkar/azkar.dart';
import '../../repositories/azkar/azkar_repository.dart';

@injectable
class GetAzkarUseCase {
  final AzkarRepository repository;

  GetAzkarUseCase(this.repository);

  Future<List<Azkar>> call(String category) {
    return repository.getAzkar(category);
  }
}
