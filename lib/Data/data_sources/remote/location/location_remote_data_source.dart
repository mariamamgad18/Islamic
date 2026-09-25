import 'package:islamic/Domain/entities/response/location/location_entity.dart';

abstract class LocationRemoteDataSource {
  Future<LocationEntity> getCurrentLocation();
}
