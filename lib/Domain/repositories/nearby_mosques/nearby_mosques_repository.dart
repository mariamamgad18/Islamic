import 'package:islamic/Domain/entities/response/nearby_mosques/mosque_entity.dart';

abstract class NearbyMosquesRepository {
  Future<List<MosqueEntity>> getNearbyMosques({
    required double latitude,
    required double longitude,
  });
}
