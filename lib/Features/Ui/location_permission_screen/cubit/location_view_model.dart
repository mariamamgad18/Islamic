import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islamic/Features/Ui/location_permission_screen/cubit/location_states.dart';

import '../../../../Domain/entities/response/location/location_entity.dart';
import '../../../../Domain/use_case/location/get_current_location_use_case.dart';
import '../../../../core/Utils/app_preferences.dart';

@injectable
class LocationViewModel extends Cubit<LocationStates> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;

  LocationEntity? locationEntity;

  bool get locationEntityPresent => locationEntity != null;

  LocationViewModel({required this.getCurrentLocationUseCase})
    : super(LocationInitialState());

  // =========================================================
  // GET CURRENT GPS LOCATION
  // =========================================================

  Future<void> getCurrentLocation() async {
    emit(LocationLoadingState());

    try {
      final location = await getCurrentLocationUseCase.invoke();

      // =====================================================
      // SAVE IN MEMORY
      // =====================================================

      locationEntity = location;

      // =====================================================
      // SAVE IN SHARED PREFERENCES
      // =====================================================

      await AppPreferences.saveLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        cityName: location.cityName,
      );

      // =====================================================
      // LOCATION FLOW COMPLETED
      // =====================================================

      await AppPreferences.setLocationFlowCompleted();

      emit(LocationSuccessState());
    } catch (e) {
      emit(LocationErrorState(errorMsg: e.toString()));
    }
  }

  // =========================================================
  // LOAD SAVED LOCATION
  // =========================================================
  //
  // مهم:
  // دي مش بتطلب GPS.
  //
  // بتجيب الـ location القديمة من SharedPreferences فقط.
  //
  // =========================================================

  Future<void> loadSavedLocation() async {
    try {
      final latitude = await AppPreferences.getSavedLatitude();

      final longitude = await AppPreferences.getSavedLongitude();

      final cityName = await AppPreferences.getSavedCityName();

      // =====================================================
      // NO SAVED LOCATION
      // =====================================================

      if (latitude == null || longitude == null || cityName == null) {
        locationEntity = null;

        // نخلي الـ Home يعرف إن مفيش Location محفوظة.
        emit(LocationInitialState());

        return;
      }

      // =====================================================
      // RECREATE LOCATION ENTITY
      // =====================================================

      locationEntity = LocationEntity(
        latitude: latitude,
        longitude: longitude,
        cityName: cityName,
      );

      // =====================================================
      // SUCCESS
      // =====================================================

      emit(LocationSuccessState());
    } catch (e) {
      emit(LocationErrorState(errorMsg: e.toString()));
    }
  }
}
