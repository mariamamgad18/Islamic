import 'package:injectable/injectable.dart';
import 'package:islamic/Data/data_sources/remote/nearby_mosques/nearby_mosques_remote_data_source.dart';
import 'package:islamic/Domain/entities/response/nearby_mosques/mosque_entity.dart';
import 'package:islamic/Domain/repositories/nearby_mosques/nearby_mosques_repository.dart';

@Injectable(as: NearbyMosquesRepository)
class NearbyMosquesRepositoryImpl implements NearbyMosquesRepository {
  final NearbyMosquesRemoteDataSource remoteDataSource;

  NearbyMosquesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MosqueEntity>> getNearbyMosques({
    required double latitude,
    required double longitude,
  }) {
    return remoteDataSource.getNearbyMosques(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
