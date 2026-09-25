class Verse {
  final int id;

  final int verseNumber;

  final String verseKey;

  final int chapterId;

  final int juz;
  final int hizb;
  final int rub;
  final int ruku;
  final int manzil;
  final int page;

  final String textUthmani;

  Verse({
    required this.id,
    required this.verseNumber,
    required this.verseKey,
    required this.chapterId,
    required this.juz,
    required this.hizb,
    required this.rub,
    required this.ruku,
    required this.manzil,
    required this.page,
    required this.textUthmani,
  });
}
