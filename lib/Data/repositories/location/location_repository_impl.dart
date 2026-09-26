import 'package:injectable/injectable.dart';
import 'package:islamic/Data/data_sources/remote/location/location_remote_data_source.dart';
import 'package:islamic/Domain/entities/response/location/location_entity.dart';

import '../../../Domain/repositories/location/location_repository.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LocationEntity> getCurrentLocation() {
    return remoteDataSource.getCurrentLocation();
  }
}
