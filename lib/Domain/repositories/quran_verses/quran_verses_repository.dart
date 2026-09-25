import 'package:islamic/Domain/entities/response/quran_verses/quran_verses.dart';

abstract class QuranVersesRepository {
  Future<QuranVerses> getVersesByChapter(int chapterId);
}
