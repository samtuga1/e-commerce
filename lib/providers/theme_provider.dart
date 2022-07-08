import 'package:e_commerse/models/dark_theme_sharedpreference.dart';
import 'package:flutter/cupertino.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemeSharePreference darkThemePrefs = DarkThemeSharePreference();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setTheme(_darkTheme);
    notifyListeners();
  }
}
