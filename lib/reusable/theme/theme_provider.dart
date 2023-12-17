import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whowhats/reusable/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _selectedTheme;
  bool _isLightTheme;

  ThemeProvider(this._selectedTheme, this._isLightTheme) {
    loadFromPrefs();
  }

  ThemeData getTheme() => _selectedTheme;

  bool isLightTheme() => _isLightTheme;

  void toggleTheme() {
    _isLightTheme = !_isLightTheme;
    _selectedTheme = _isLightTheme ? lightTheme : darkTheme;
    saveToPrefs();
    notifyListeners();
  }

  void saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLightTheme', _isLightTheme);
  }

  void loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLightTheme = prefs.getBool('isLightTheme') ?? true;
    _selectedTheme = _isLightTheme ? lightTheme : darkTheme;
    notifyListeners();
  }
}
