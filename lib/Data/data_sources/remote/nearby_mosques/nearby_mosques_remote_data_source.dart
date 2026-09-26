import 'package:islamic/Domain/entities/response/nearby_mosques/mosque_entity.dart';

abstract class NearbyMosquesRemoteDataSource {
  Future<List<MosqueEntity>> getNearbyMosques({
    required double latitude,
    required double longitude,
  });
}
