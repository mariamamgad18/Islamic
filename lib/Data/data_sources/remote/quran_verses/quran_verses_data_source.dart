import 'package:islamic/api/Models/response/quran_verses/quran_verses_dto.dart';

abstract class QuranVersesRemoteDataSource {
  Future<QuranVersesDto> getVersesByChapter(int chapterId);
}
