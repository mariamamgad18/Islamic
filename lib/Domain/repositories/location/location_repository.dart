import '../../entities/response/location/location_entity.dart';

//هخليه abstrct عشان لسه مش هعمل impl هنا
abstract class LocationRepository {
  Future<LocationEntity> getCurrentLocation();
  // يعني انا عندي فانكشن اسمها getCurrentLocation  هتاخد شوية وقت و هترجعلي LocationEntity
}
