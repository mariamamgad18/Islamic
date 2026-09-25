import 'package:islamic/Domain/entities/response/quran_info/translated_name.dart';

class Chapter {
  final int id;

  final String revelationPlace;

  final int revelationOrder;

  final bool bismillahPre;

  final String nameSimple;

  final String nameArabic;

  final int versesCount;

  final List<int> pages;

  final TranslatedName translatedName;

  Chapter({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
    required this.translatedName,
  });
}
