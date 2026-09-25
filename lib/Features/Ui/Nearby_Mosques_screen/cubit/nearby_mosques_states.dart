import 'package:islamic/Domain/entities/response/nearby_mosques/mosque_entity.dart';

abstract class NearbyMosquesState {}

class NearbyMosquesInitialState extends NearbyMosquesState {}

class NearbyMosquesLoadingState extends NearbyMosquesState {}

class NearbyMosquesSuccessState extends NearbyMosquesState {
  final List<MosqueEntity> mosques;

  NearbyMosquesSuccessState(this.mosques);
}

class NearbyMosquesErrorState extends NearbyMosquesState {
  final String message;

  NearbyMosquesErrorState(this.message);
}
