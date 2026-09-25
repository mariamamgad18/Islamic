import 'dart:math' as math;

import 'package:geolocator/geolocator.dart';

class QiblaService {
  // Kaaba coordinates
  static const double kaabaLatitude = 21.422487;
  static const double kaabaLongitude = 39.826206;

  /// Check if location service is enabled
  static Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Get user's current location
  static Future<Position> getCurrentLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location service is disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied');
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  /// Calculate Qibla bearing from user's location
  static double calculateQiblaDirection(double latitude, double longitude) {
    final double userLat = _degreesToRadians(latitude);
    final double userLon = _degreesToRadians(longitude);

    final double kaabaLat = _degreesToRadians(kaabaLatitude);
    final double kaabaLon = _degreesToRadians(kaabaLongitude);

    final double deltaLon = kaabaLon - userLon;

    final double y = math.sin(deltaLon);

    final double x =
        math.cos(userLat) * math.tan(kaabaLat) -
        math.sin(userLat) * math.cos(deltaLon);

    double bearing = math.atan2(y, x);

    bearing = _radiansToDegrees(bearing);

    // Convert negative angle to 0-360
    bearing = (bearing + 360) % 360;

    return bearing;
  }

  /// Calculate distance between user and Kaaba in KM
  static double calculateDistanceKm(double latitude, double longitude) {
    const double earthRadius = 6371;

    final double lat1 = _degreesToRadians(latitude);
    final double lon1 = _degreesToRadians(longitude);

    final double lat2 = _degreesToRadians(kaabaLatitude);
    final double lon2 = _degreesToRadians(kaabaLongitude);

    final double deltaLat = lat2 - lat1;
    final double deltaLon = lon2 - lon1;

    final double a =
        math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(deltaLon / 2) *
            math.sin(deltaLon / 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  static double _radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }
}
