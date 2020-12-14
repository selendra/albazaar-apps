import 'package:selendra_marketplace_app/all_export.dart';

var kDefaultColor = Color(0xFF303F9F);

class DarkMode with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    _isDarkMode = true;
    print(_isDarkMode);
    notifyListeners();
  }
}
