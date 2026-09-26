import '../../../../Domain/entities/response/prayer_times/prayers_times.dart';

abstract class PrayerTimesStates {}

class PrayerTimesInitialState extends PrayerTimesStates {}

class PrayerTimesLoadingState extends PrayerTimesStates {}

class PrayerTimesSuccessState extends PrayerTimesStates {
  final PrayersTimes prayersTimes;

  PrayerTimesSuccessState({required this.prayersTimes});
}

class PrayerTimesErrorState extends PrayerTimesStates {
  final String errorMessage;

  PrayerTimesErrorState({required this.errorMessage});
}
