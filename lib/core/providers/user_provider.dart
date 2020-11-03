import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:selendra_marketplace_app/all_export.dart';

class UserProvider with ChangeNotifier {
  var _mUser = new User();
  User get mUser => _mUser;
  String alertText;
  PrefService _prefService = PrefService();

  //Fetch user information from endpoint
  Future<void> fetchUserPf(String _token) async {
    //Wait for endpoint to response
    var response =
        await http.get(ApiUrl.SET_USER_PROFILE, headers: <String, String>{
      "accept": "application/json",
      "authorization": "Bearer " + _token,
    });

    //Decode repsonsebody and assign it user object
    var responseBody = json.decode(response.body);
    _mUser = User.fromJson(responseBody);

    //This will save all user information to sharepreferenece
    _prefService.saveString('user', jsonEncode(responseBody));

    //It check if the string of username is null and set it to empty string
    if (_mUser.firstName == null &&
        _mUser.midName == null &&
        _mUser.lastName == null) {
      _mUser.firstName = '';
      _mUser.midName = '';
      _mUser.lastName = '';
    }

    //NOTIFY IF ANYTHING CHANGE
    notifyListeners();
  }

  //READ USER INFO FROM SHARE PREFERENCE
  void fetchUserInfo() {
    _prefService.read('user').then((value) {
      var responseBody = json.decode(value);
      _mUser = User.fromJson(responseBody);
    });
  }

  //FETCH USER INFOMATION OF SOCIAL ACCOUNT USER
  void fetchSocialUserInfo(String email, String displayName, String photoUrl) {
    _mUser.email = email;
    _mUser.firstName = displayName;
    _mUser.lastName = '';
    _mUser.midName = '';
    _mUser.profileImg = photoUrl;
  }

  //UPDATE USER GENDER
  void setGender(String value) {
    mUser.gender = value;
    print(mUser.gender);
    notifyListeners();
  }

  //USER UPDATE THEIR PROFILE INFORMATION
  Future<String> setUserPf(String firstName, String midName, String lastName,
      String gender, context) async {
    await _prefService.read('token').then((value) async {
      print(value);
      var response = await http.post(
        ApiUrl.SET_USER_PROFILE,
        headers: <String, String>{
          "accept": "application/json",
          "authorization": "Bearer " + value,
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          <String, String>{
            "first_name": firstName,
            "mid_name": midName,
            "last_name": lastName,
            "gender": gender,
          },
        ),
      );

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        alertText = responseBody['message'];
        fetchUserPf(value);
      } else {
        alertText = responseBody['error']['message'];
      }
    });
    print(alertText);
    return alertText;
  }

  //USER REQUEST TO GET THEIR PEER TO PEER WALLET
  Future<String> getWallet(String pin) async {
    await _prefService.read('token').then((value) async {
      var response = await http.post(ApiUrl.GET_WALLET,
          headers: <String, String>{
            "accept": "application/json",
            "authorization": "Bearer " + value,
            "Content-Type": "application/json"
          },
          body: jsonEncode(<String, String>{"pin": pin}));
      var responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        String _seed;
        try {
          alertText = responseBody['message'];
        } catch (e) {
          var wallet = WalletResponse.fromJson(responseBody);
          print(wallet);
          _seed = responseBody['message']['seed'];
          if (_seed != null) {
            print(_seed);
            _prefService.saveString('seed', _seed);
          }
        }
      } else {
        print(responseBody);
        alertText = responseBody['error']['message'];
      }
    });
    return alertText;
  }

  //FETCH PORTFORLIO OF THE USER
  Future<String> fetchPortforlio() async {
    await _prefService.read('token').then((onValue) async {
      var response =
          await http.get(ApiUrl.DISPLAY_PORTFORLIO, headers: <String, String>{
        "accept": "application/json",
        "authorization": "Bearer " + onValue,
      });

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        if (responseBody['error'] == null) {
          mBalance = Balance.fromMap(responseBody);
          print(mBalance);
        } else {
          alertText = responseBody['error']['message'];
          print(alertText);
        }

        alertText = response.statusCode.toString();
        print(alertText);
      } else {
        throw HttpException("${response.statusCode}");
      }
    });

    notifyListeners();
    return alertText ?? '';
  }
}
