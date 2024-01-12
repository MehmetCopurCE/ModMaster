// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeMode themeMode = ThemeMode.system;

//   bool get isDarkMode {
//     if (themeMode == ThemeMode.system) {
//       final brightness = SchedulerBinding.instance.window.platformBrightness;
//       return brightness == Brightness.dark;
//     } else {
//       return themeMode == ThemeMode.dark;
//     }
//   }

//   void toggleTheme(bool isOn) {
//     themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String themeStorageKey = 'selected_theme';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light) {
    _loadThemeFromStorage();
  }

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> _loadThemeFromStorage() async {
    final String? storedTheme = await _secureStorage.read(key: themeStorageKey);
    if (storedTheme != null) {
      state = storedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    } else {
      _getDeviceTheme();
    }
  }

  Future<void> _getDeviceTheme() async {
    final Brightness platformBrightness = WidgetsBinding.instance.window.platformBrightness;
    final ThemeMode detectedTheme = platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    state = detectedTheme;

    await _secureStorage.write(key: themeStorageKey, value: detectedTheme == ThemeMode.dark ? 'dark' : 'light');
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    state = themeMode;
    await _secureStorage.write(key: themeStorageKey, value: themeMode == ThemeMode.dark ? 'dark' : 'light');
    debugPrint(themeMode.toString());
    debugPrint('ThemeMode değiştirildi ve kaydedildi: $themeMode');
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);
