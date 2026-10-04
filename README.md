# 🕌 Islamic App

A comprehensive Islamic mobile application built with **Flutter** to provide Muslims with essential daily Islamic tools and services in one place.

The application combines prayer times, Quran reading, Azkar, Athan notifications, Qibla direction, Tasbeeh, reminders, and more in a clean and user-friendly experience.

---
## 📸 Screenshots

 Islamic icon
 
<img width="404" height="360" alt="WhatsApp Image 2026-09-26 at 5 57 27 AM" src="https://github.com/user-attachments/assets/86c1695f-1219-41af-81ab-3e584dbbbc63" />

_________________________________________________________________________________________________________________________________________________

splash screen + Permission

<img width="1080" height="708" alt="Untitled design" src="https://github.com/user-attachments/assets/d14cdc58-0ec1-478e-ada4-b1dfe73bcd7a" />

_________________________________________________________________________________________________________________________________________________

on_boarding

<img width="1015" height="615" alt="1" src="https://github.com/user-attachments/assets/fafe9036-70f9-4ad9-8f7d-b1e8150f8970" />

_________________________________________________________________________________________________________________________________________________


Language Selection Screen + Location Permission Screen:


<img width="897" height="559" alt="12" src="https://github.com/user-attachments/assets/20730c63-2463-4fd8-a216-c490181c62d4" />


_________________________________________________________________________________________________________________________________________________


If the user denies location access and chooses to continue without setting a location, the app will allow them to proceed, but the prayer times will remain unavailable and will be displayed as 00:00.

<img width="463" height="889" alt="1" src="https://github.com/user-attachments/assets/a19219cf-60f3-4d63-ac66-6dcf0e0c0a9d" />


_________________________________________________________________________________________________________________________________________________


Home Screen


<img width="991" height="980" alt="1" src="https://github.com/user-attachments/assets/7aafd72b-5d24-424d-b085-f965ecbe5eee" />

_________________________________________________________________________________________________________________________________________________

Quran :
The Quran Surahs are correctly ordered and categorized as either Makki or Madani. The Quran reading screen supports zoom in and zoom out to adjust the text size. Users can navigate to the next or previous Surah using the corresponding buttons, and search for any Surah by name.


<img width="1080" height="1080" alt="1" src="https://github.com/user-attachments/assets/41590b00-550b-4f05-b797-8251b6794dbe" />


_________________________________________________________________________________________________________________________________________________


Azkar :


<img width="1080" height="552" alt="1" src="https://github.com/user-attachments/assets/d98dff46-cde6-416f-9ae9-e10d313501d5" />

_________________________________________________________________________________________________________________________________________________



Azan :

<img width="804" height="515" alt="image" src="https://github.com/user-attachments/assets/38e1f806-f4f5-433c-a722-6e0b1cdda030" />

<img width="444" height="433" alt="image" src="https://github.com/user-attachments/assets/95e179ca-7593-4e84-9839-64877a9152e5" />

_________________________________________________________________________________________________________________________________________________


Reminders :

<img width="1080" height="552" alt="1" src="https://github.com/user-attachments/assets/91aa0bcd-03d7-4f5b-a519-49e4e5ef99d5" />

<img width="1080" height="398" alt="image" src="https://github.com/user-attachments/assets/b913f2b1-ca84-4e09-88a4-fa05722084c0" />
<img width="1080" height="656" alt="image" src="https://github.com/user-attachments/assets/cf721b95-f346-41a3-9d9b-b3801d77b34d" />

_________________________________________________________________________________________________________________________________________________


Sebha :

<img width="1080" height="1080" alt="1" src="https://github.com/user-attachments/assets/f23962fa-2c7a-48bc-a122-8117b39f3bcf" />

_________________________________________________________________________________________________________________________________________________


Qebla :

<img width="833" height="859" alt="1" src="https://github.com/user-attachments/assets/38de5dc9-1f7f-4106-b0e0-a28c4fc91b7b" />

_________________________________________________________________________________________________________________________________________________



Settings :


<img width="1080" height="558" alt="1" src="https://github.com/user-attachments/assets/0acb6830-f5e8-4499-a4dc-66106c1ea927" />

_________________________________________________________________________________________________________________________________________________


____
## ✨ Features

### 🕌 Prayer Times

* Automatically determines the user's location.
* Calculates daily prayer times based on the current location.
* Displays the next prayer and the remaining time.
* Supports location permissions and location updates.

### 🔔 Athan & Notifications

* Customizable Athan for each prayer.
* Choose which prayers should trigger the Athan.
* Athan works while the application is in the background.
* Supports Athan playback even when the device is offline.
* Full-screen notifications for prayer alerts.
* Customizable notification settings.
* Personal prayer reminders with scheduled notifications.

### 📖 Quran

* Complete Quran with correctly ordered Surahs.
* Search for Surahs by name.
* Categorization of Surahs into **Makki and Madani**.
* Adjustable Quran text size with zoom in/out controls.
* Dedicated Quran reading experience.

### 🤲 Azkar & Duas

Includes commonly needed daily Islamic content such as:

* Morning Azkar
* Evening Azkar
* Azkar after Salah
* Sleep Azkar
* Quranic Duas
* Comprehensive Duas / Jawami' Al-Dua

### 📿 Electronic Tasbeeh

* Digital Tasbeeh counter for daily Dhikr.
* Simple and easy-to-use interface.

### 🕋 Qibla

* Determines the Qibla direction based on the user's current location.
* Calculates the distance from the user's location to Makkah.
* Provides an interactive Qibla direction experience.

### 🌍 Localization

The application supports four languages:

* 🇪🇬 Arabic
* 🇬🇧 English
* 🇫🇷 French
* Urdu

### ⚙️ Settings

* Notification control.
* Athan preferences.
* Language selection.
* Location management.
* User preferences.

---



---

## 🚀 Upcoming Features

The following features are currently under development:

* 🌙 Dark Mode
* 🕌 Nearby Mosques based on the user's location
* 📖 Quran text translation

---

## 🛠️ Technologies & Architecture

The project is built using modern Flutter development practices.

### Core Technologies

* **Flutter**
* **Dart**
* **BLoC / Cubit**
* **Clean Architecture**
* **RESTful APIs**
* **Dio**
* **Retrofit**
* **JSON Serialization**
* **Firebase**
* **SharedPreferences**
* **Git & GitHub**

### Architecture

The application follows **Clean Architecture** principles with a structured separation between:

```text
lib/
├── Data/
├── Domain/
├── Core/
├── l10n/
├── Features/
│   └── UI/
└── ...
```

The architecture is designed to keep the codebase maintainable, scalable, and easy to extend.

---

## 📱 Permissions

The application may request the following permissions depending on the enabled features:

* 📍 Location access — for prayer times and Qibla.
* 🔔 Notification permission — for Athan and reminders.
* 📱 Full-screen notification permission — for prayer alerts and Athan.
* 🔋 Background execution — to support scheduled notifications and Athan functionality.

Permissions are requested only when required by the corresponding feature.

---

## 🎯 Project Goals

The main goal of this project is to create a single, reliable application that provides Muslims with essential daily Islamic tools while maintaining:

* Clean and maintainable code
* Responsive UI
* Scalable architecture
* Smooth user experience
* Localization support
* Reliable background functionality


---

## 🔮 Future Improvements

Planned improvements include expanding the application's Islamic content, improving accessibility and customization, and adding additional location-based services.

---

