import 'package:injectable/injectable.dart';

import '../../entities/response/prayer_times/prayers_times.dart';
import '../../repositories/prayer_times/preyer_times_repositories.dart';

@Injectable()
class PrayerTimesUseCase {
  final PreyerTimesRepositories preyerTimesRepositories;

  PrayerTimesUseCase({required this.preyerTimesRepositories});

  Future<PrayersTimes> invoke({
    required String date,
    required double latitude,
    required double longitude,
    required int method,
  }) {
    return preyerTimesRepositories.getPrayerTimes(
      date: date,
      latitude: latitude,
      longitude: longitude,
      method: method,
    );
  }
}
