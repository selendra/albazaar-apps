import 'package:flutter/material.dart';

class LangProvider with ChangeNotifier {
  Locale _manualLocale = Locale('en', 'US');

  Locale get manualLocale => _manualLocale;

  void setLocal(String languageCode) {
    switch (languageCode) {
      case 'KH':
        _manualLocale = Locale('km', 'KH');
        notifyListeners();
        break;
      case 'EN':
        _manualLocale = Locale('en', 'US');
        notifyListeners();
        break;
    }
  }
}
