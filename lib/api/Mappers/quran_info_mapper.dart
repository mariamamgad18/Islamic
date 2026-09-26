import 'package:islamic/Domain/entities/response/quran_info/chapter.dart';
import 'package:islamic/Domain/entities/response/quran_info/quran_info.dart';
import 'package:islamic/Domain/entities/response/quran_info/quran_info_data.dart';
import 'package:islamic/Domain/entities/response/quran_info/translated_name.dart';
import 'package:islamic/api/Models/response/quran_info/chapter_dto.dart';
import 'package:islamic/api/Models/response/quran_info/quran_info_data_dto.dart';
import 'package:islamic/api/Models/response/quran_info/quran_info_dto.dart';
import 'package:islamic/api/Models/response/quran_info/translated_name_dto.dart';

extension QuranInfoMapper on QuranInfoDto {
  QuranInfo toQuranInfo() {
    return QuranInfo(code: code, status: status, data: data.toQuranInfoData());
  }
}

extension QuranInfoDataMapper on QuranInfoDataDto {
  QuranInfoData toQuranInfoData() {
    return QuranInfoData(
      chapters: chapters.map((chapter) => chapter.toChapter()).toList(),
    );
  }
}

extension ChapterMapper on ChapterDto {
  Chapter toChapter() {
    return Chapter(
      id: id,
      revelationPlace: revelationPlace,
      revelationOrder: revelationOrder,
      bismillahPre: bismillahPre,
      nameSimple: nameSimple,
      nameArabic: nameArabic,
      versesCount: versesCount,
      pages: pages,
      translatedName: translatedName.toTranslatedName(),
    );
  }
}

extension TranslatedNameMapper on TranslatedNameDto {
  TranslatedName toTranslatedName() {
    return TranslatedName(languageName: languageName, name: name);
  }
}
