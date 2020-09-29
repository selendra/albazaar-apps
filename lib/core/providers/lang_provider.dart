import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/services/pref_service.dart';

class LangProvider with ChangeNotifier {
  Locale _manualLocale;
  PrefService _prefService = PrefService();
  String _lang;

  String get lang => _lang;

  Locale get manualLocale => _manualLocale;

  void setLocal(String languageCode) {
    _lang = languageCode;
    notifyListeners();
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
    _prefService.saveString('lang', languageCode);
  }

  void saveLang(context) async {
    Locale myLocale = Localizations.localeOf(context);

    print(myLocale.countryCode);
    await _prefService.read('lang').then((value) {
      _lang = value;
      if (value == null) {
        _lang = myLocale.countryCode;
      }

      notifyListeners();
    });
  }
}
