import 'package:http/http.dart' as http;
import 'package:selendra_marketplace_app/models/api_url.dart';
import 'dart:convert';
import 'package:selendra_marketplace_app/models/user.dart';

class ApiGetServices {
  String alertText;

  Future<void> getUserPf(String _token) async {
    var response =
        await http.get(ApiUrl.SET_USER_PROFILE, headers: <String, String>{
      "accept": "application/json",
      "authorization": "Bearer " + _token,
    });
    var responseBody = json.decode(response.body);
     mUser = User.fromJson(responseBody);
  }
}
