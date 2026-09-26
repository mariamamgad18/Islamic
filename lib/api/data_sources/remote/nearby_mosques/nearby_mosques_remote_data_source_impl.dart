import 'package:injectable/injectable.dart';
import 'package:islamic/Data/data_sources/remote/nearby_mosques/nearby_mosques_remote_data_source.dart';
import 'package:islamic/Domain/entities/response/nearby_mosques/mosque_entity.dart';
import 'package:islamic/api/Mappers/mosque_mapper.dart';
import 'package:islamic/api/api_services.dart';

@Injectable(as: NearbyMosquesRemoteDataSource)
class NearbyMosquesRemoteDataSourceImpl
    implements NearbyMosquesRemoteDataSource {
  final GooglePlacesApiServices googlePlacesApiServices;

  NearbyMosquesRemoteDataSourceImpl({required this.googlePlacesApiServices});

  @override
  Future<List<MosqueEntity>> getNearbyMosques({
    required double latitude,
    required double longitude,
  }) async {
    final body = {
      "includedTypes": ["mosque"],
      "maxResultCount": 10,
      "rankPreference": "DISTANCE",
      "locationRestriction": {
        "circle": {
          "center": {"latitude": latitude, "longitude": longitude},
          "radius": 5000,
        },
      },
    };

    const apiKey = 'YOUR_GOOGLE_API_KEY';

    const fieldMask =
        'places.id,'
        'places.displayName,'
        'places.formattedAddress,'
        'places.location';

    final response = await googlePlacesApiServices.getNearbyMosques(
      body,
      apiKey,
      fieldMask,
    );

    final places = response.data.places ?? [];

    return places.map((mosque) => mosque.toEntity()).toList();
  }
}
