import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'Models/response/nearby_mosques/nearby_mosques_dto.dart';
import 'Models/response/prayer_times/prayers_times_dto.dart';
import 'Models/response/quran_info/quran_info_dto.dart';
import 'Models/response/quran_verses/quran_verses_dto.dart';
import 'api_endpoint.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiEndpoint.aladhanBaseUrl)
abstract class AladhanApiServices {
  factory AladhanApiServices(Dio dio, {String? baseUrl}) = _AladhanApiServices;

  // =========================
  // Prayer Times API
  // =========================

  @GET(ApiEndpoint.prayersTimesApi)
  Future<HttpResponse<PrayersTimesDto>> getPrayerTimes(
    @Path('date') String date,
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('method') int method,
  );
}

@RestApi(baseUrl: ApiEndpoint.quranBaseUrl)
abstract class QuranApiServices {
  factory QuranApiServices(Dio dio, {String? baseUrl}) = _QuranApiServices;

  // =========================
  // Quran Info API
  // =========================

  @GET(ApiEndpoint.chaptersApi)
  Future<HttpResponse<QuranInfoDto>> getQuranInfo();

  @GET(ApiEndpoint.versesByChapterApi)
  Future<HttpResponse<QuranVersesDto>> getVersesByChapter(
    @Path('chapterId') int chapterId,
  );
}

@RestApi(baseUrl: ApiEndpoint.googlePlacesBaseUrl)
abstract class GooglePlacesApiServices {
  factory GooglePlacesApiServices(Dio dio, {String? baseUrl}) =
      _GooglePlacesApiServices;

  @POST(ApiEndpoint.nearbySearchApi)
  Future<HttpResponse<NearbyMosquesDto>> getNearbyMosques(
    @Body() Map<String, dynamic> body,
    @Header('X-Goog-Api-Key') String apiKey,
    @Header('X-Goog-FieldMask') String fieldMask,
  );
}
