import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  final String _themeKey = 'theme';

 ThemeMode _mode = ThemeMode.light;
  ThemeMode get themeMode => _mode;

  List<ThemeMode> get themeModes => [
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system
  ];

  void changeThemeMode(ThemeMode newThemeMode){
    _mode = newThemeMode;
    _saveThemeMode();
    notifyListeners();
  }
  // ----------------- Local Memory --------------------------
  // eta ThemeMode select korarr por call hobe
  Future<void> _saveThemeMode()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _mode.name);
  }
  // eta app er shuru te call hobe
  Future<void> loadThemeMode()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ? saveLocale =  prefs.getString(_themeKey);
    if(saveLocale != null){
      _mode = ThemeMode.values.firstWhere(
              (mode) => mode.name == saveLocale
      );
      notifyListeners();
    }
  }
}