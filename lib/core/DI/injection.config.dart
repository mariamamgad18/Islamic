// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:islamic/Data/data_sources/local/azkar/azkar_local_data_source.dart'
    as _i732;
import 'package:islamic/Data/data_sources/remote/location/location_remote_data_source.dart'
    as _i732;
import 'package:islamic/Data/data_sources/remote/nearby_mosques/nearby_mosques_remote_data_source.dart'
    as _i1008;
import 'package:islamic/Data/data_sources/remote/prayers_times/prayer_times_remote_data_source.dart'
    as _i110;
import 'package:islamic/Data/data_sources/remote/quran_info/quran_info_data_source.dart'
    as _i0;
import 'package:islamic/Data/data_sources/remote/quran_verses/quran_verses_data_source.dart'
    as _i1029;
import 'package:islamic/Data/repositories/azkar/azkar_repository_impl.dart'
    as _i682;
import 'package:islamic/Data/repositories/location/location_repository_impl.dart'
    as _i462;
import 'package:islamic/Data/repositories/nearby_mosques/nearby_mosques_repository_impl.dart'
    as _i313;
import 'package:islamic/Data/repositories/prayer_times/preyer_times_repositories_impl.dart'
    as _i165;
import 'package:islamic/Data/repositories/quran_info/quran_info_repository_impl.dart'
    as _i155;
import 'package:islamic/Data/repositories/quran_verses/quran_verses_repository_impl.dart'
    as _i478;
import 'package:islamic/Domain/repositories/azkar/azkar_repository.dart'
    as _i975;
import 'package:islamic/Domain/repositories/location/location_repository.dart'
    as _i965;
import 'package:islamic/Domain/repositories/nearby_mosques/nearby_mosques_repository.dart'
    as _i678;
import 'package:islamic/Domain/repositories/prayer_times/preyer_times_repositories.dart'
    as _i823;
import 'package:islamic/Domain/repositories/quran_info/quran_info_repository.dart'
    as _i599;
import 'package:islamic/Domain/repositories/quran_verses/quran_verses_repository.dart'
    as _i936;
import 'package:islamic/Domain/use_case/azkar/get_azkar_use_case.dart' as _i712;
import 'package:islamic/Domain/use_case/get_nearby_mosques/get_nearby_mosques_use_case.dart'
    as _i539;
import 'package:islamic/Domain/use_case/location/get_current_location_use_case.dart'
    as _i540;
import 'package:islamic/Domain/use_case/prayer_times/prayer_times_use_case.dart'
    as _i690;
import 'package:islamic/Domain/use_case/quran_info/get_quran_info_use_case.dart'
    as _i462;
import 'package:islamic/Domain/use_case/quran_verses/get_quran_verses_use_case.dart'
    as _i363;
import 'package:islamic/Features/Ui/Azkar/cubit/azkar_view_model.dart' as _i170;
import 'package:islamic/Features/Ui/Nearby_Mosques_screen/cubit/nearby_mosques_view_model.dart'
    as _i551;
import 'package:islamic/Features/Ui/location_permission_screen/cubit/location_view_model.dart'
    as _i301;
import 'package:islamic/Features/Ui/prayer_times_screen/Cubit/prayer_times_view_model.dart'
    as _i683;
import 'package:islamic/Features/Ui/quran/cubit/quran_info_view_model.dart'
    as _i223;
import 'package:islamic/Features/Ui/quran_inside/cubit/quran_inside_view_model.dart'
    as _i59;
import 'package:islamic/api/Dio/dio_modules.dart' as _i115;
import 'package:islamic/api/api_services.dart' as _i65;
import 'package:islamic/api/data_sources/local/azkar/azkar_local_data_source_impl.dart'
    as _i26;
import 'package:islamic/api/data_sources/remote/location/location_remote_data_source_impl.dart'
    as _i705;
import 'package:islamic/api/data_sources/remote/nearby_mosques/nearby_mosques_remote_data_source_impl.dart'
    as _i900;
import 'package:islamic/api/data_sources/remote/prayer_times/prayer_times_remote_data_source_impl.dart'
    as _i559;
import 'package:islamic/api/data_sources/remote/quran_info/quran_info_data_source_impl.dart'
    as _i236;
import 'package:islamic/api/data_sources/remote/quran_verses/quran_verses_data_source_impl.dart'
    as _i330;
import 'package:islamic/core/Services/athan_scheduler.dart' as _i301;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModules = _$DioModules();
    gh.lazySingleton<_i361.Dio>(
      () => dioModules.provideAladhanDio(),
      instanceName: 'AladhanDio',
    );
    gh.factory<_i732.LocationRemoteDataSource>(
      () => _i705.LocationRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i732.AzkarLocalDataSource>(
      () => _i26.AzkarLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModules.provideGooglePlacesDio(),
      instanceName: 'GooglePlacesDio',
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModules.provideQuranDio(),
      instanceName: 'QuranDio',
    );
    gh.lazySingleton<_i65.GooglePlacesApiServices>(
      () => dioModules.provideGooglePlacesApiServices(
        gh<_i361.Dio>(instanceName: 'GooglePlacesDio'),
      ),
    );
    gh.factory<_i1008.NearbyMosquesRemoteDataSource>(
      () => _i900.NearbyMosquesRemoteDataSourceImpl(
        googlePlacesApiServices: gh<_i65.GooglePlacesApiServices>(),
      ),
    );
    gh.lazySingleton<_i65.QuranApiServices>(
      () => dioModules.provideQuranApiServices(
        gh<_i361.Dio>(instanceName: 'QuranDio'),
      ),
    );
    gh.factory<_i965.LocationRepository>(
      () => _i462.LocationRepositoryImpl(
        remoteDataSource: gh<_i732.LocationRemoteDataSource>(),
      ),
    );
    gh.factory<_i540.GetCurrentLocationUseCase>(
      () => _i540.GetCurrentLocationUseCase(gh<_i965.LocationRepository>()),
    );
    gh.factory<_i678.NearbyMosquesRepository>(
      () => _i313.NearbyMosquesRepositoryImpl(
        remoteDataSource: gh<_i1008.NearbyMosquesRemoteDataSource>(),
      ),
    );
    gh.factory<_i0.QuranInfoRemoteDataSource>(
      () => _i236.QuranInfoRemoteDataSourceImpl(
        apiServices: gh<_i65.QuranApiServices>(),
      ),
    );
    gh.factory<_i301.LocationViewModel>(
      () => _i301.LocationViewModel(
        getCurrentLocationUseCase: gh<_i540.GetCurrentLocationUseCase>(),
      ),
    );
    gh.lazySingleton<_i65.AladhanApiServices>(
      () => dioModules.provideAladhanApiServices(
        gh<_i361.Dio>(instanceName: 'AladhanDio'),
      ),
    );
    gh.factory<_i599.QuranInfoRepository>(
      () => _i155.QuranInfoRepositoryImpl(gh<_i0.QuranInfoRemoteDataSource>()),
    );
    gh.lazySingleton<_i975.AzkarRepository>(
      () => _i682.AzkarRepositoryImpl(gh<_i732.AzkarLocalDataSource>()),
    );
    gh.factory<_i110.PrayerTimesRemoteDataSource>(
      () => _i559.PrayerTimesRemoteDataSourceImpl(
        apiServices: gh<_i65.AladhanApiServices>(),
      ),
    );
    gh.factory<_i539.GetNearbyMosquesUseCase>(
      () => _i539.GetNearbyMosquesUseCase(gh<_i678.NearbyMosquesRepository>()),
    );
    gh.factory<_i1029.QuranVersesRemoteDataSource>(
      () => _i330.QuranVersesRemoteDataSourceImpl(
        apiServices: gh<_i65.QuranApiServices>(),
      ),
    );
    gh.factory<_i462.GetQuranInfoUseCase>(
      () => _i462.GetQuranInfoUseCase(gh<_i599.QuranInfoRepository>()),
    );
    gh.factory<_i551.NearbyMosquesViewModel>(
      () => _i551.NearbyMosquesViewModel(
        getNearbyMosquesUseCase: gh<_i539.GetNearbyMosquesUseCase>(),
        getCurrentLocationUseCase: gh<_i540.GetCurrentLocationUseCase>(),
      ),
    );
    gh.factory<_i223.QuranInfoViewModel>(
      () => _i223.QuranInfoViewModel(
        getQuranInfoUseCase: gh<_i462.GetQuranInfoUseCase>(),
      ),
    );
    gh.factory<_i712.GetAzkarUseCase>(
      () => _i712.GetAzkarUseCase(gh<_i975.AzkarRepository>()),
    );
    gh.factory<_i170.AzkarViewModel>(
      () => _i170.AzkarViewModel(gh<_i712.GetAzkarUseCase>()),
    );
    gh.factory<_i823.PreyerTimesRepositories>(
      () => _i165.PreyerTimesRepositoriesImpl(
        prayerTimesRemoteDataSource: gh<_i110.PrayerTimesRemoteDataSource>(),
      ),
    );
    gh.factory<_i936.QuranVersesRepository>(
      () => _i478.QuranVersesRepositoryImpl(
        gh<_i1029.QuranVersesRemoteDataSource>(),
      ),
    );
    gh.factory<_i363.GetQuranVersesUseCase>(
      () => _i363.GetQuranVersesUseCase(gh<_i936.QuranVersesRepository>()),
    );
    gh.factory<_i690.PrayerTimesUseCase>(
      () => _i690.PrayerTimesUseCase(
        preyerTimesRepositories: gh<_i823.PreyerTimesRepositories>(),
      ),
    );
    gh.factory<_i59.QuranInsideViewModel>(
      () => _i59.QuranInsideViewModel(
        getQuranVersesUseCase: gh<_i363.GetQuranVersesUseCase>(),
      ),
    );
    gh.factory<_i683.PrayerTimesViewModel>(
      () => _i683.PrayerTimesViewModel(
        prayerTimesUseCase: gh<_i690.PrayerTimesUseCase>(),
      ),
    );
    gh.singleton<_i301.AthanScheduler>(
      () => _i301.AthanScheduler(
        prayerTimesUseCase: gh<_i690.PrayerTimesUseCase>(),
      ),
    );
    return this;
  }
}

class _$DioModules extends _i115.DioModules {}
