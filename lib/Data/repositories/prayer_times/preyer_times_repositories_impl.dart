import 'package:injectable/injectable.dart';
import 'package:islamic/Data/data_sources/remote/prayers_times/prayer_times_remote_data_source.dart';
import 'package:islamic/Domain/entities/response/prayer_times/prayers_times.dart';
import 'package:islamic/api/Mappers/prayers_times_dto_mapper.dart';

import '../../../Domain/repositories/prayer_times/preyer_times_repositories.dart';

@Injectable(as: PreyerTimesRepositories)
class PreyerTimesRepositoriesImpl implements PreyerTimesRepositories {
  final PrayerTimesRemoteDataSource prayerTimesRemoteDataSource;

  PreyerTimesRepositoriesImpl({required this.prayerTimesRemoteDataSource});

  @override
  Future<PrayersTimes> getPrayerTimes({
    required String date,
    required double latitude,
    required double longitude,
    required int method,
  }) async {
    final dto = await prayerTimesRemoteDataSource.getPrayerTimes(
      date: date,
      latitude: latitude,
      longitude: longitude,
      method: method,
    );

    return dto.toEntity();
  }
}
