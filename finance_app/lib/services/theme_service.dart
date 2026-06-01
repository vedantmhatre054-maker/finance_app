import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {

  static const String themeKey =
      "isDarkMode";

  static Future<void> saveTheme(
      bool isDarkMode) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setBool(
      themeKey,
      isDarkMode,
    );
  }

  static Future<bool>
      loadTheme() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getBool(
          themeKey,
        ) ??
        true;
  }
}