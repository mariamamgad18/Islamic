import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
    Locale('ur'),
  ];

  /// No description provided for @mushaf.
  ///
  /// In en, this message translates to:
  /// **'The Holy Quran'**
  String get mushaf;

  /// No description provided for @quranVerse.
  ///
  /// In en, this message translates to:
  /// **'And recite the Quran with measured recitation.'**
  String get quranVerse;

  /// No description provided for @surahAlMuzzammilAyah4.
  ///
  /// In en, this message translates to:
  /// **'Surah Al-Muzzammil - Verse 4'**
  String get surahAlMuzzammilAyah4;

  /// No description provided for @quranKareem.
  ///
  /// In en, this message translates to:
  /// **'The Holy Quran'**
  String get quranKareem;

  /// No description provided for @quranDescription.
  ///
  /// In en, this message translates to:
  /// **'Read the Holy Quran with a clear font and beautiful design, with the ability to listen to recitations.'**
  String get quranDescription;

  /// No description provided for @prayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimes;

  /// No description provided for @prayerTimesDescription.
  ///
  /// In en, this message translates to:
  /// **'Accurate prayer time notifications based on your location with the sound of the Adhan.'**
  String get prayerTimesDescription;

  /// No description provided for @spiritualCompanion.
  ///
  /// In en, this message translates to:
  /// **'Your Spiritual Companion'**
  String get spiritualCompanion;

  /// No description provided for @spiritualCompanionDescription.
  ///
  /// In en, this message translates to:
  /// **'Daily reminders, Azkar, Tasbeeh, and everything you need on your spiritual journey.'**
  String get spiritualCompanionDescription;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @continuee.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuee;

  /// No description provided for @locationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location Access'**
  String get locationPermission;

  /// No description provided for @locationDescription.
  ///
  /// In en, this message translates to:
  /// **'Allow access to your location'**
  String get locationDescription;

  /// No description provided for @accuratePrayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Accurate Prayer Times'**
  String get accuratePrayerTimes;

  /// No description provided for @accurateBasedOnLocation.
  ///
  /// In en, this message translates to:
  /// **'Accurate calculation based on your location'**
  String get accurateBasedOnLocation;

  /// No description provided for @nearbyMosques.
  ///
  /// In en, this message translates to:
  /// **'Nearby Mosques'**
  String get nearbyMosques;

  /// No description provided for @discoverMosques.
  ///
  /// In en, this message translates to:
  /// **'Discover mosques around you'**
  String get discoverMosques;

  /// No description provided for @privacyProtected.
  ///
  /// In en, this message translates to:
  /// **'Privacy Protected'**
  String get privacyProtected;

  /// No description provided for @dataSafe.
  ///
  /// In en, this message translates to:
  /// **'Your data is safe and protected'**
  String get dataSafe;

  /// No description provided for @allowLocationAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow Location Access'**
  String get allowLocationAccess;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for Now'**
  String get skipForNow;

  /// No description provided for @changeSettingLater.
  ///
  /// In en, this message translates to:
  /// **'You can change this setting later from Settings'**
  String get changeSettingLater;

  /// No description provided for @assalamuAlaikum.
  ///
  /// In en, this message translates to:
  /// **'Peace be upon you and the mercy of Allah'**
  String get assalamuAlaikum;

  /// No description provided for @nextPrayer.
  ///
  /// In en, this message translates to:
  /// **'Next Prayer'**
  String get nextPrayer;

  /// No description provided for @dhuhrPrayer.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr Prayer'**
  String get dhuhrPrayer;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @ayahOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Ayah of the Day'**
  String get ayahOfTheDay;

  /// No description provided for @mushafShort.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get mushafShort;

  /// No description provided for @readQuran.
  ///
  /// In en, this message translates to:
  /// **'Read the Holy Quran'**
  String get readQuran;

  /// No description provided for @adhan.
  ///
  /// In en, this message translates to:
  /// **'Adhan'**
  String get adhan;

  /// No description provided for @prayerTimesShort.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimesShort;

  /// No description provided for @duasAndAzkar.
  ///
  /// In en, this message translates to:
  /// **'Duas & Azkar'**
  String get duasAndAzkar;

  /// No description provided for @hisnAlMuslim.
  ///
  /// In en, this message translates to:
  /// **'Hisn Al-Muslim'**
  String get hisnAlMuslim;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @dailyNotifications.
  ///
  /// In en, this message translates to:
  /// **'Daily Notifications'**
  String get dailyNotifications;

  /// No description provided for @quranLearning.
  ///
  /// In en, this message translates to:
  /// **'Quran Learning'**
  String get quranLearning;

  /// No description provided for @lessonsAndRecitations.
  ///
  /// In en, this message translates to:
  /// **'Lessons & Recitations'**
  String get lessonsAndRecitations;

  /// No description provided for @mosques.
  ///
  /// In en, this message translates to:
  /// **'Mosques'**
  String get mosques;

  /// No description provided for @nearestMosques.
  ///
  /// In en, this message translates to:
  /// **'Nearest Mosques'**
  String get nearestMosques;

  /// No description provided for @tasbeeh.
  ///
  /// In en, this message translates to:
  /// **'Tasbeeh'**
  String get tasbeeh;

  /// No description provided for @tasbeehCounter.
  ///
  /// In en, this message translates to:
  /// **'Tasbeeh Counter'**
  String get tasbeehCounter;

  /// No description provided for @qiblaDirection.
  ///
  /// In en, this message translates to:
  /// **'Qibla Direction'**
  String get qiblaDirection;

  /// No description provided for @findQiblaDirection.
  ///
  /// In en, this message translates to:
  /// **'Find Qibla Direction'**
  String get findQiblaDirection;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @meccan.
  ///
  /// In en, this message translates to:
  /// **'Meccan'**
  String get meccan;

  /// No description provided for @medinan.
  ///
  /// In en, this message translates to:
  /// **'Medinan'**
  String get medinan;

  /// No description provided for @searchForSurah.
  ///
  /// In en, this message translates to:
  /// **'Search for a Surah...'**
  String get searchForSurah;

  /// No description provided for @surah.
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get surah;

  /// No description provided for @ayah.
  ///
  /// In en, this message translates to:
  /// **'Ayah'**
  String get ayah;

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @nextSurah.
  ///
  /// In en, this message translates to:
  /// **'Next Surah'**
  String get nextSurah;

  /// No description provided for @previousSurah.
  ///
  /// In en, this message translates to:
  /// **'Previous Surah'**
  String get previousSurah;

  /// No description provided for @prayerTimesTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimesTitle;

  /// No description provided for @accurateTimesBasedOnLocation.
  ///
  /// In en, this message translates to:
  /// **'Accurate times based on your location'**
  String get accurateTimesBasedOnLocation;

  /// No description provided for @morningAzkar.
  ///
  /// In en, this message translates to:
  /// **'Morning Azkar'**
  String get morningAzkar;

  /// No description provided for @eveningAzkar.
  ///
  /// In en, this message translates to:
  /// **'Evening Azkar'**
  String get eveningAzkar;

  /// No description provided for @sleepAzkar.
  ///
  /// In en, this message translates to:
  /// **'Sleep Azkar'**
  String get sleepAzkar;

  /// No description provided for @afterPrayerAzkar.
  ///
  /// In en, this message translates to:
  /// **'Azkar After Prayer'**
  String get afterPrayerAzkar;

  /// No description provided for @comprehensiveDuas.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive Duas'**
  String get comprehensiveDuas;

  /// No description provided for @quranicDuas.
  ///
  /// In en, this message translates to:
  /// **'Quranic Duas'**
  String get quranicDuas;

  /// No description provided for @addNewReminder.
  ///
  /// In en, this message translates to:
  /// **'Add New Reminder'**
  String get addNewReminder;

  /// No description provided for @tip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get tip;

  /// No description provided for @azkarTip.
  ///
  /// In en, this message translates to:
  /// **'Maintaining daily Azkar brings peace and tranquility to the heart. Make sure to enable reminders to stay connected to Allah.'**
  String get azkarTip;

  /// No description provided for @reminderExample.
  ///
  /// In en, this message translates to:
  /// **'Example: Duha Prayer, Daily Quran Reading...'**
  String get reminderExample;

  /// No description provided for @reminderTime.
  ///
  /// In en, this message translates to:
  /// **'Reminder Time'**
  String get reminderTime;

  /// No description provided for @chooseIcon.
  ///
  /// In en, this message translates to:
  /// **'Choose Icon'**
  String get chooseIcon;

  /// No description provided for @chooseColor.
  ///
  /// In en, this message translates to:
  /// **'Choose Color'**
  String get chooseColor;

  /// No description provided for @dailyRepeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat Daily'**
  String get dailyRepeat;

  /// No description provided for @saveReminder.
  ///
  /// In en, this message translates to:
  /// **'Save Reminder'**
  String get saveReminder;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @viewOnMap.
  ///
  /// In en, this message translates to:
  /// **'View on Map'**
  String get viewOnMap;

  /// No description provided for @hadith.
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get hadith;

  /// No description provided for @hadithMosque.
  ///
  /// In en, this message translates to:
  /// **'Whoever goes to the mosque in the morning or evening, Allah prepares for him a place of hospitality in Paradise.'**
  String get hadithMosque;

  /// No description provided for @electronicTasbeeh.
  ///
  /// In en, this message translates to:
  /// **'Electronic Tasbeeh'**
  String get electronicTasbeeh;

  /// No description provided for @rememberAllahAnytime.
  ///
  /// In en, this message translates to:
  /// **'Glorify and remember Allah at any time'**
  String get rememberAllahAnytime;

  /// No description provided for @subhanAllah.
  ///
  /// In en, this message translates to:
  /// **'Subhan Allah'**
  String get subhanAllah;

  /// No description provided for @alhamdulillah.
  ///
  /// In en, this message translates to:
  /// **'Alhamdulillah'**
  String get alhamdulillah;

  /// No description provided for @allahuAkbar.
  ///
  /// In en, this message translates to:
  /// **'Allahu Akbar'**
  String get allahuAkbar;

  /// No description provided for @laIlahaIllallah.
  ///
  /// In en, this message translates to:
  /// **'There is no god but Allah'**
  String get laIlahaIllallah;

  /// No description provided for @from33.
  ///
  /// In en, this message translates to:
  /// **'From 33'**
  String get from33;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @totalToday.
  ///
  /// In en, this message translates to:
  /// **'Total Today'**
  String get totalToday;

  /// No description provided for @rounds.
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get rounds;

  /// No description provided for @virtueOfTasbeeh.
  ///
  /// In en, this message translates to:
  /// **'Virtue of Tasbeeh'**
  String get virtueOfTasbeeh;

  /// No description provided for @hadithTasbeeh.
  ///
  /// In en, this message translates to:
  /// **'Whoever says, \'Glory be to Allah and praise be to Him\' one hundred times in a day, his sins will be erased even if they were like the foam of the sea.'**
  String get hadithTasbeeh;

  /// No description provided for @narratedByBukhariMuslim.
  ///
  /// In en, this message translates to:
  /// **'Narrated by Al-Bukhari and Muslim'**
  String get narratedByBukhariMuslim;

  /// No description provided for @qibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get qibla;

  /// No description provided for @north.
  ///
  /// In en, this message translates to:
  /// **'North'**
  String get north;

  /// No description provided for @east.
  ///
  /// In en, this message translates to:
  /// **'East'**
  String get east;

  /// No description provided for @west.
  ///
  /// In en, this message translates to:
  /// **'West'**
  String get west;

  /// No description provided for @south.
  ///
  /// In en, this message translates to:
  /// **'South'**
  String get south;

  /// No description provided for @distanceToMakkah.
  ///
  /// In en, this message translates to:
  /// **'Distance to Makkah'**
  String get distanceToMakkah;

  /// No description provided for @qiblaSuccess.
  ///
  /// In en, this message translates to:
  /// **'Qibla direction successfully determined ✓'**
  String get qiblaSuccess;

  /// No description provided for @phoneFlatTip.
  ///
  /// In en, this message translates to:
  /// **'💡 Keep your phone flat for the best accuracy'**
  String get phoneFlatTip;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @customizeExperience.
  ///
  /// In en, this message translates to:
  /// **'Customize your experience'**
  String get customizeExperience;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @darkModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark mode'**
  String get darkModeDescription;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Change the app language'**
  String get languageDescription;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage notifications and alerts'**
  String get notificationsDescription;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get aboutApp;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @madeWithLove.
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ to serve the Holy Quran'**
  String get madeWithLove;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @featureUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'This feature is currently under development.\nWe will add it soon, God willing.'**
  String get featureUnderDevelopment;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @after.
  ///
  /// In en, this message translates to:
  /// **'After'**
  String get after;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get hour;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get minute;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @prayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get prayer;

  /// No description provided for @azkarPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Duas & Azkar'**
  String get azkarPageTitle;

  /// No description provided for @azkarPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily Fortress of the Muslim'**
  String get azkarPageSubtitle;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @completedToday.
  ///
  /// In en, this message translates to:
  /// **'Completed Today'**
  String get completedToday;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @backToCategories.
  ///
  /// In en, this message translates to:
  /// **'Back to Categories'**
  String get backToCategories;

  /// No description provided for @noAzkarInCategory.
  ///
  /// In en, this message translates to:
  /// **'No Azkar in this category'**
  String get noAzkarInCategory;

  /// No description provided for @quranPageTitle.
  ///
  /// In en, this message translates to:
  /// **'The Holy Quran'**
  String get quranPageTitle;

  /// No description provided for @surahsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Surahs'**
  String surahsCount(int count);

  /// No description provided for @loadingSurahsError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading the Surahs'**
  String get loadingSurahsError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noSurahFound.
  ///
  /// In en, this message translates to:
  /// **'No Surah found'**
  String get noSurahFound;

  /// No description provided for @ayahCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Ayahs'**
  String ayahCount(int count);

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @muharram.
  ///
  /// In en, this message translates to:
  /// **'Muharram'**
  String get muharram;

  /// No description provided for @safar.
  ///
  /// In en, this message translates to:
  /// **'Safar'**
  String get safar;

  /// No description provided for @rabiAlAwwal.
  ///
  /// In en, this message translates to:
  /// **'Rabi\' al-Awwal'**
  String get rabiAlAwwal;

  /// No description provided for @rabiAlThani.
  ///
  /// In en, this message translates to:
  /// **'Rabi\' al-Thani'**
  String get rabiAlThani;

  /// No description provided for @jumadaAlAwwal.
  ///
  /// In en, this message translates to:
  /// **'Jumada al-Awwal'**
  String get jumadaAlAwwal;

  /// No description provided for @jumadaAlThani.
  ///
  /// In en, this message translates to:
  /// **'Jumada al-Thani'**
  String get jumadaAlThani;

  /// No description provided for @rajab.
  ///
  /// In en, this message translates to:
  /// **'Rajab'**
  String get rajab;

  /// No description provided for @shaban.
  ///
  /// In en, this message translates to:
  /// **'Sha\'ban'**
  String get shaban;

  /// No description provided for @ramadan.
  ///
  /// In en, this message translates to:
  /// **'Ramadan'**
  String get ramadan;

  /// No description provided for @shawwal.
  ///
  /// In en, this message translates to:
  /// **'Shawwal'**
  String get shawwal;

  /// No description provided for @dhulQidah.
  ///
  /// In en, this message translates to:
  /// **'Dhul-Qi\'dah'**
  String get dhulQidah;

  /// No description provided for @dhulHijjah.
  ///
  /// In en, this message translates to:
  /// **'Dhul-Hijjah'**
  String get dhulHijjah;

  /// No description provided for @hijriYearSuffix.
  ///
  /// In en, this message translates to:
  /// **'AH'**
  String get hijriYearSuffix;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @reminderPreview.
  ///
  /// In en, this message translates to:
  /// **'Reminder Preview'**
  String get reminderPreview;

  /// No description provided for @reminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder Title'**
  String get reminderTitle;

  /// No description provided for @defaultTime.
  ///
  /// In en, this message translates to:
  /// **'00:00'**
  String get defaultTime;

  /// No description provided for @tapToCount.
  ///
  /// In en, this message translates to:
  /// **'Tap to count'**
  String get tapToCount;

  /// No description provided for @distanceToMosque.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceToMosque(double distance);

  /// No description provided for @qiblaMakkahDescription.
  ///
  /// In en, this message translates to:
  /// **'Direction of Makkah from your current location'**
  String get qiblaMakkahDescription;

  /// No description provided for @qiblaDirectionError.
  ///
  /// In en, this message translates to:
  /// **'Unable to determine the Qibla direction'**
  String get qiblaDirectionError;

  /// No description provided for @qiblaLocationCompassTip.
  ///
  /// In en, this message translates to:
  /// **'Make sure location services and the compass are enabled'**
  String get qiblaLocationCompassTip;

  /// No description provided for @detectingDeviceDirection.
  ///
  /// In en, this message translates to:
  /// **'Determining device direction...'**
  String get detectingDeviceDirection;

  /// No description provided for @northEast.
  ///
  /// In en, this message translates to:
  /// **'Northeast'**
  String get northEast;

  /// No description provided for @southEast.
  ///
  /// In en, this message translates to:
  /// **'Southeast'**
  String get southEast;

  /// No description provided for @southWest.
  ///
  /// In en, this message translates to:
  /// **'Southwest'**
  String get southWest;

  /// No description provided for @northWest.
  ///
  /// In en, this message translates to:
  /// **'Northwest'**
  String get northWest;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Information about the Holy Quran'**
  String get aboutDescription;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @currentAppVersion.
  ///
  /// In en, this message translates to:
  /// **'Current app version'**
  String get currentAppVersion;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get locationUnavailable;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @locationPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission required'**
  String get locationPermissionRequired;

  /// No description provided for @locationPermissionSettingsMessage.
  ///
  /// In en, this message translates to:
  /// **'Location permission was permanently denied. You can enable it from the app settings.'**
  String get locationPermissionSettingsMessage;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @dailyAyah.
  ///
  /// In en, this message translates to:
  /// **'Ayah of the Day'**
  String get dailyAyah;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location access was not allowed'**
  String get locationPermissionDenied;

  /// No description provided for @aboutAppTitle.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get aboutAppTitle;

  /// No description provided for @aboutAppDescription1.
  ///
  /// In en, this message translates to:
  /// **'Mushaf is an Islamic app designed to be your daily companion in worship. It helps you access the Holy Quran and easily keep track of prayer times, Azkar, and reminders in one place.'**
  String get aboutAppDescription1;

  /// No description provided for @aboutAppDescription2.
  ///
  /// In en, this message translates to:
  /// **'You can read the chapters of the Quran, view prayer times based on your location, enable Athan notifications, create your own reminders, and benefit from a variety of Islamic features.'**
  String get aboutAppDescription2;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get appVersion;

  /// No description provided for @notificationsDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsDialogTitle;

  /// No description provided for @notificationsDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'Control app notifications and prayer time and Athan alerts.'**
  String get notificationsDialogDescription;

  /// No description provided for @appNotifications.
  ///
  /// In en, this message translates to:
  /// **'App Notifications'**
  String get appNotifications;

  /// No description provided for @notificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications are enabled'**
  String get notificationsEnabled;

  /// No description provided for @notificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications are disabled'**
  String get notificationsDisabled;

  /// No description provided for @athanEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enable Athan'**
  String get athanEnabled;

  /// No description provided for @athanDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disable Athan'**
  String get athanDisabled;

  /// No description provided for @athanNotificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Athan notifications are enabled'**
  String get athanNotificationsEnabled;

  /// No description provided for @allAthanNotificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'All Athan notifications have been disabled'**
  String get allAthanNotificationsDisabled;

  /// No description provided for @openNotificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Notification Settings'**
  String get openNotificationSettings;

  /// No description provided for @prayerTimesDependOnLocation.
  ///
  /// In en, this message translates to:
  /// **'Prayer times depend on your location'**
  String get prayerTimesDependOnLocation;

  /// No description provided for @locationRequiredForPrayerTimes.
  ///
  /// In en, this message translates to:
  /// **'The app needs your current location to calculate accurate prayer times based on your location. You can allow location access or continue without enabling it now.'**
  String get locationRequiredForPrayerTimes;

  /// No description provided for @allowLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow Location'**
  String get allowLocation;

  /// No description provided for @skipAnyway.
  ///
  /// In en, this message translates to:
  /// **'Skip Anyway'**
  String get skipAnyway;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
