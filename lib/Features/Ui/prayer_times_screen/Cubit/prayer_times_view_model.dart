import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islamic/Features/Ui/prayer_times_screen/Cubit/prayer_times_stets.dart';

import '../../../../Domain/use_case/prayer_times/prayer_times_use_case.dart';

@Injectable()
class PrayerTimesViewModel extends Cubit<PrayerTimesStates> {
  final PrayerTimesUseCase prayerTimesUseCase;

  PrayerTimesViewModel({required this.prayerTimesUseCase})
    : super(PrayerTimesInitialState());

  Future<void> getPrayerTimes({
    required String date,
    required double latitude,
    required double longitude,
    required int method,
  }) async {
    emit(PrayerTimesLoadingState());

    try {
      final result = await prayerTimesUseCase.invoke(
        date: date,
        latitude: latitude,
        longitude: longitude,
        method: method,
      );

      emit(PrayerTimesSuccessState(prayersTimes: result));
    } catch (e) {
      emit(PrayerTimesErrorState(errorMessage: e.toString()));
    }
  }
}
