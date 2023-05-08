import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
  var _themeMode = ThemeMode.light;
  static const _themeModeKey = 'theme_mode';
  ThemeProvider() {
    _loadThemeMode();
  }
  ThemeMode get themeMode => _themeMode;
  void setTheme(themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    _themeMode = themeMode;
    prefs.setInt(_themeModeKey, themeMode.index);

    notifyListeners();
  }


  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeModeKey);
    if (index != null) {
      _themeMode = ThemeMode.values[index];
      notifyListeners();
    }
  }

}