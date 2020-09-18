import 'package:http/http.dart' as http;
import 'package:selendra_marketplace_app/core/models/api_url.dart';
import 'dart:convert';
import 'package:selendra_marketplace_app/core/models/user.dart';
import 'package:selendra_marketplace_app/core/models/acc_balance.dart';
import 'package:geolocator/geolocator.dart';

class ApiGetServices {
  String alertText;

  Future<User> fetchUserPf(String _token) async {
    var response =
        await http.get(ApiUrl.SET_USER_PROFILE, headers: <String, String>{
      "accept": "application/json",
      "authorization": "Bearer " + _token,
    });
    var responseBody = json.decode(response.body);
    mUser = User.fromJson(responseBody);
    if (mUser.firstName == null &&
        mUser.midName == null &&
        mUser.lastName == null) {
      mUser.firstName = '';
      mUser.midName = '';
      mUser.lastName = '';
    }

    return mUser;
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
