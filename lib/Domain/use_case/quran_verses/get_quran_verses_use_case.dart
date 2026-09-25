import 'package:injectable/injectable.dart';
import 'package:islamic/Domain/entities/response/quran_verses/quran_verses.dart';

import '../../repositories/quran_verses/quran_verses_repository.dart';

@injectable
class GetQuranVersesUseCase {
  final QuranVersesRepository repository;

  GetQuranVersesUseCase(this.repository);

  Future<QuranVerses> call(int chapterId) {
    return repository.getVersesByChapter(chapterId);
  }
}
