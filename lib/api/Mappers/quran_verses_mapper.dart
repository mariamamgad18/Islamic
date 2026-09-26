import 'package:islamic/Domain/entities/response/quran_verses/quran_verses.dart';
import 'package:islamic/Domain/entities/response/quran_verses/quran_verses_data.dart';
import 'package:islamic/api/Models/response/quran_verses/quran_verses_dto.dart';
import 'package:islamic/api/Models/response/quran_verses/verse_dto.dart';

import '../../Domain/entities/response/quran_verses/verse_dto.dart';
import '../Models/response/quran_verses/quran_verses_data_dto.dart';

extension QuranVersesMapper on QuranVersesDto {
  QuranVerses toQuranVerses() {
    return QuranVerses(
      code: code,
      status: status,
      data: data.toQuranVersesData(),
    );
  }
}

extension QuranVersesDataMapper on QuranVersesDataDto {
  QuranVersesData toQuranVersesData() {
    return QuranVersesData(
      verses: verses.map((verse) => verse.toVerse()).toList(),
    );
  }
}

extension VerseMapper on VerseDto {
  Verse toVerse() {
    return Verse(
      id: id,
      verseNumber: verseNumber,
      verseKey: verseKey,
      chapterId: chapterId,
      juz: juz,
      hizb: hizb,
      rub: rub,
      ruku: ruku,
      manzil: manzil,
      page: page,
      textUthmani: textUthmani,
    );
  }
}
