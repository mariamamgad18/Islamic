import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // =========================================================
  // ONBOARDING
  // =========================================================

  static const String _onboardingCompletedKey = 'onboarding_completed';

  // =========================================================
  // LOCATION FLOW
  // =========================================================

  static const String _locationFlowCompletedKey = 'location_flow_completed';

  // =========================================================
  // SAVED LOCATION
  // =========================================================

  static const String _latitudeKey = 'saved_latitude';

  static const String _longitudeKey = 'saved_longitude';

  static const String _cityNameKey = 'saved_city_name';

  // =========================================================
  // ONBOARDING
  // =========================================================

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_onboardingCompletedKey, true);
  }

  // =========================================================
  // LOCATION FLOW
  // =========================================================

  static Future<bool> isLocationFlowCompleted() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_locationFlowCompletedKey) ?? false;
  }

  static Future<void> setLocationFlowCompleted() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_locationFlowCompletedKey, true);
  }

  // =========================================================
  // SAVE LOCATION
  // =========================================================

  static Future<void> saveLocation({
    required double latitude,
    required double longitude,
    required String cityName,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setDouble(_latitudeKey, latitude);

    await prefs.setDouble(_longitudeKey, longitude);

    await prefs.setString(_cityNameKey, cityName);
  }

  // =========================================================
  // GET SAVED LATITUDE
  // =========================================================

  static Future<double?> getSavedLatitude() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(_latitudeKey);
  }

  // =========================================================
  // GET SAVED LONGITUDE
  // =========================================================

  static Future<double?> getSavedLongitude() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getDouble(_longitudeKey);
  }

  // =========================================================
  // GET SAVED CITY
  // =========================================================

  static Future<String?> getSavedCityName() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_cityNameKey);
  }

  // =========================================================
  // CHECK SAVED LOCATION
  // =========================================================

  static Future<bool> hasSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(_latitudeKey) &&
        prefs.containsKey(_longitudeKey) &&
        prefs.containsKey(_cityNameKey);
  }

  // =========================================================
  // CLEAR SAVED LOCATION
  // =========================================================

  static Future<void> clearSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_latitudeKey);
    await prefs.remove(_longitudeKey);
    await prefs.remove(_cityNameKey);
  }
}
