import 'package:flutter/cupertino.dart';
import 'package:rss_reader/util.dart';

class DarkThemeProvider with ChangeNotifier {
  UtilService utilService = UtilService();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    utilService.setDarkTheme(value);
    notifyListeners();
  }
}
