import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/services/pref_service.dart';

class LangProvider with ChangeNotifier {
  Locale _manualLocale;
  PrefService _prefService = PrefService();
  String _lang;

  String get lang => _lang;

  Locale get manualLocale => _manualLocale;

  //SET LOCALIZE LANGUAGE
  void setLocal(String languageCode, context) {
    _lang = languageCode;
    print(_lang);

    if (_lang == null) {
      _prefService.saveString('lang', languageCode);
      saveLang(languageCode, context);
    } else {
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

    notifyListeners();
  }

  //GET SAVE LANGUAGE CODE
  void saveLang(String languageCode, context) async {
    Locale myLocale = Localizations.localeOf(context);
    if (languageCode != null) {
      _lang = languageCode;
    } else {
      _lang = myLocale.countryCode;
      print(_lang);
    }
    //print(myLocale.countryCode);

    notifyListeners();
  }
}
