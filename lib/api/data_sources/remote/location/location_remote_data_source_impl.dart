import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:islamic/Data/data_sources/remote/location/location_remote_data_source.dart';
import 'package:islamic/Domain/entities/response/location/location_entity.dart';

@Injectable(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  @override
  Future<LocationEntity> getCurrentLocation() async {
    // 1. نشوف الـ GPS مفتوح ولا مقفول
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    // 2. نشوف الأبلكيشن واخد Permission ولا لا
    LocationPermission permission = await Geolocator.checkPermission();

    // 3. لو لسه مفيش Permission نطلبه
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    // 4. لو المستخدم رفض الـ Permission بشكل دائم
    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied');
    }

    // 5. نجيب الـ Location الحقيقي
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // 6. نحول الـ latitude والـ longitude لاسم المكان
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place = placemarks.first;

    // اسم المدينة
    final cityName =
        place.locality ??
        place.subAdministrativeArea ??
        place.administrativeArea ??
        'موقعك';

    // اسم الدولة
    final countryName = place.country ?? '';

    print('City: $cityName');
    print('Country: $countryName');

    // 7. نرجع كل البيانات اللي محتاجينها
    return LocationEntity(
      latitude: position.latitude,
      longitude: position.longitude,
      cityName: cityName,
    );
  }
}
