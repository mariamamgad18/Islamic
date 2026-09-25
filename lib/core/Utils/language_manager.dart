import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageManager {
  static const String languageKey = 'selected_language';
  static const String defaultLanguage = 'ar';

  // اللغة الحالية للتطبيق كله
  static final ValueNotifier<Locale> localeNotifier = ValueNotifier(
    const Locale(defaultLanguage),
  );

  // تحميل اللغة المحفوظة
  static Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();

    final languageCode = prefs.getString(languageKey) ?? defaultLanguage;

    localeNotifier.value = Locale(languageCode);
  }

  // حفظ وتغيير اللغة
  static Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(languageKey, languageCode);

    // تغيير اللغة في التطبيق فورًا
    localeNotifier.value = Locale(languageCode);
  }

  // الحصول على كود اللغة الحالية
  static String get currentLanguageCode {
    return localeNotifier.value.languageCode;
  }
}
