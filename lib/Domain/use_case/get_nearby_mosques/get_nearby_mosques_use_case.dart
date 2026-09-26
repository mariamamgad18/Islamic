import 'package:injectable/injectable.dart';
import 'package:islamic/Domain/entities/response/nearby_mosques/mosque_entity.dart';
import 'package:islamic/Domain/repositories/nearby_mosques/nearby_mosques_repository.dart';

@injectable
class GetNearbyMosquesUseCase {
  final NearbyMosquesRepository repository;

  GetNearbyMosquesUseCase(this.repository);

  Future<List<MosqueEntity>> invoke({
    required double latitude,
    required double longitude,
  }) {
    return repository.getNearbyMosques(
      latitude: latitude,
      longitude: longitude,
    );
  }
}
