import 'package:injectable/injectable.dart';

import '../../entities/response/location/location_entity.dart';
import '../../repositories/location/location_repository.dart';

//todo : ال use case مسؤول عن انه يجيب اللوكيشن
@injectable
class GetCurrentLocationUseCase {
  //todo  :هيحتاج اوبجكت من ال Repo
  final LocationRepository locationRepository;

  GetCurrentLocationUseCase(this.locationRepository);

  Future<LocationEntity> invoke() {
    return locationRepository.getCurrentLocation();
  }
}

// بدل ال Ui م يتكلم مع Repo
// هنخليه يتكلم مع ال UseCase
// يعني Ui > Use Case > Repository
