import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ApiGetServices with ChangeNotifier {
  var _mUser = new User();
  User get mUser => _mUser;
  String alertText;
  PrefService _prefService = PrefService();

  Future<void> fetchUserPf(String _token) async {
    var response =
        await http.get(ApiUrl.SET_USER_PROFILE, headers: <String, String>{
      "accept": "application/json",
      "authorization": "Bearer " + _token,
    });    var responseBody = json.decode(response.body);

    _mUser = User.fromJson(responseBody);
    _prefService.saveString('user', jsonEncode(responseBody));

    if (_mUser.firstName == null &&
        _mUser.midName == null &&
        _mUser.lastName == null) {
      _mUser.firstName = '';
      _mUser.midName = '';
      _mUser.lastName = '';
    }

    print(_mUser.email);
    notifyListeners();
  }

  void fetchUserInfo() {
    _prefService.read('user').then((value) {
      var responseBody = json.decode(value);
      _mUser = User.fromJson(responseBody);
    });
  }

  void fetchSocialUserInfo(String email, String displayName, String photoUrl) {
    _mUser.email = email;
    _mUser.firstName = displayName;
    _mUser.lastName = '';
    _mUser.midName = '';
    _mUser.profileImg = photoUrl;
  }

  void setGender(String value) {
    mUser.gender = value;
    print(mUser.gender);
    notifyListeners();
  }

  Future<String> fetchPortforlio(String _token) async {
    var response =
        await http.get(ApiUrl.DISPLAY_PORTFORLIO, headers: <String, String>{
      "accept": "application/json",
      "authorization": "Bearer " + _token,
    });
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      if (responseBody is List) {
        for (var i in responseBody) {
          mBalance.add(Balance.fromJson(i));
        }
      } else {
        alertText = responseBody['error']['message'];
      }
    }
    return alertText ?? '';
  }

  Future<Placemark> fetchPlaceList(String query) async {
    var response = await http.get(ApiUrl.MAP_SEARCH + query);
    print(response.body);
    if (response.statusCode == 200) {
      return null;
    } else {
      print(response.statusCode);
    }
    return null;
  }
}
