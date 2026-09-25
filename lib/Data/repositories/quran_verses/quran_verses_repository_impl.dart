import 'package:injectable/injectable.dart';
import 'package:islamic/api/Mappers/quran_verses_mapper.dart';

import '../../../Domain/entities/response/quran_verses/quran_verses.dart';
import '../../../Domain/repositories/quran_verses/quran_verses_repository.dart';
import '../../data_sources/remote/quran_verses/quran_verses_data_source.dart';

@Injectable(as: QuranVersesRepository)
class QuranVersesRepositoryImpl implements QuranVersesRepository {
  final QuranVersesRemoteDataSource remoteDataSource;

  QuranVersesRepositoryImpl(this.remoteDataSource);

  @override
  Future<QuranVerses> getVersesByChapter(int chapterId) async {
    final quranVersesDto = await remoteDataSource.getVersesByChapter(chapterId);

    return quranVersesDto.toQuranVerses();
  }
}
