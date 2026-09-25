class ApiEndpoint {
  // =========================
  // Aladhan API
  // =========================

  static const String aladhanBaseUrl = 'https://api.aladhan.com/v1/';

  static const String prayersTimesApi = 'timings/{date}';

  // =========================
  // Quran API
  // =========================

  static const String quranBaseUrl = 'https://api.islamic.app/v1/';

  static const String chaptersApi = 'chapters';

  static const String versesByChapterApi = 'verses/by_chapter/{chapterId}';

  // =========================
  // Google Places API
  // =========================

  static const String googlePlacesBaseUrl = 'https://places.googleapis.com/';

  static const String nearbySearchApi = 'v1/places:searchNearby';
}
