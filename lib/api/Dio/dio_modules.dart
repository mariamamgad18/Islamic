import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_endpoint.dart';
import '../api_services.dart';

@module
abstract class DioModules {
  // =========================
  // Aladhan Dio
  // =========================

  @lazySingleton
  @Named('AladhanDio')
  Dio provideAladhanDio() {
    return Dio(BaseOptions(baseUrl: ApiEndpoint.aladhanBaseUrl));
  }

  // =========================
  // Quran Dio
  // =========================

  @lazySingleton
  @Named('QuranDio')
  Dio provideQuranDio() {
    return Dio(BaseOptions(baseUrl: ApiEndpoint.quranBaseUrl));
  }

  // =========================
  // Google Places Dio
  // =========================

  @lazySingleton
  @Named('GooglePlacesDio')
  Dio provideGooglePlacesDio() {
    return Dio(BaseOptions(baseUrl: ApiEndpoint.googlePlacesBaseUrl));
  }

  // =========================
  // Aladhan API
  // =========================

  @lazySingleton
  AladhanApiServices provideAladhanApiServices(@Named('AladhanDio') Dio dio) {
    return AladhanApiServices(dio);
  }

  // =========================
  // Quran API
  // =========================

  @lazySingleton
  QuranApiServices provideQuranApiServices(@Named('QuranDio') Dio dio) {
    return QuranApiServices(dio);
  }

  // =========================
  // Google Places API
  // =========================

  @lazySingleton
  GooglePlacesApiServices provideGooglePlacesApiServices(
    @Named('GooglePlacesDio') Dio dio,
  ) {
    return GooglePlacesApiServices(dio);
  }
}
