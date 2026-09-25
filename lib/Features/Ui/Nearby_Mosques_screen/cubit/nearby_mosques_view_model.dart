import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islamic/Domain/use_case/get_nearby_mosques/get_nearby_mosques_use_case.dart';
import 'package:islamic/Domain/use_case/location/get_current_location_use_case.dart';

import 'nearby_mosques_states.dart';

@injectable
class NearbyMosquesViewModel extends Cubit<NearbyMosquesState> {
  final GetNearbyMosquesUseCase getNearbyMosquesUseCase;
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  NearbyMosquesViewModel({
    required this.getNearbyMosquesUseCase,
    required this.getCurrentLocationUseCase,
  }) : super(NearbyMosquesInitialState());

  static NearbyMosquesViewModel get(BuildContext context) {
    return BlocProvider.of<NearbyMosquesViewModel>(context);
  }

  Future<void> getNearbyMosques() async {
    emit(NearbyMosquesLoadingState());

    try {
      final position = await getCurrentLocationUseCase.invoke();

      final mosques = await getNearbyMosquesUseCase.invoke(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      emit(NearbyMosquesSuccessState(mosques));
    } catch (e) {
      emit(NearbyMosquesErrorState(e.toString()));
    }
  }
}
