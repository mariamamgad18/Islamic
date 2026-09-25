import 'package:injectable/injectable.dart';
import 'package:islamic/Domain/entities/response/quran_info/quran_info.dart';

import '../../repositories/quran_info/quran_info_repository.dart';

@injectable
class GetQuranInfoUseCase {
  final QuranInfoRepository repository;

  GetQuranInfoUseCase(this.repository);

  Future<QuranInfo> call() {
    return repository.getQuranInfo();
  }
}
