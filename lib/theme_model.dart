import 'package:flutter/material.dart';
import 'package:pralinen/storage_manager.dart';

//adapted from multiple answers in https://stackoverflow.com/questions/60232070/how-to-implement-dark-mode-in-flutter
class ThemeModel with ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;

  ThemeMode get mode => _mode;

  ThemeModel() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _mode = ThemeMode.light;
      } else {
        print('setting dark theme');
        _mode = ThemeMode.dark;
      }
      notifyListeners();
    });
  }

  bool get isDark => _mode == ThemeMode.dark;

  set isDark(bool newVal) => newVal ? setDarkMode() : setLightMode();

  void setDarkMode() async {
    _mode = ThemeMode.dark;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _mode = ThemeMode.light;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
