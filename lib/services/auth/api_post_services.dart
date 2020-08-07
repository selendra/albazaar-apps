import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:selendra_marketplace_app/models/api_url.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/screens/otp/otp.dart';
import 'package:selendra_marketplace_app/services/auth/api_get_services.dart';

class ApiPostServices {
  String alertText;

  Future<String> signInByEmail(String email, String password, context) async {
    String token;
    var response = await http.post(ApiUrl.LOG_IN_URL,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      SharedPreferences isToken = await SharedPreferences.getInstance();
      SharedPreferences isLogin = await SharedPreferences.getInstance();
      var responseJson = json.decode(response.body);
      token = responseJson['token'];
      if (token != null) {
        isLogin.setBool("isLogin", true);
        isToken.setString('token', token);
        ApiGetServices().fetchUserPf(token);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      } else {
        try {
          alertText = responseJson['error']['message'];
        } catch (e) {
          alertText = responseJson['message'];
        }
      }
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
    } else {
      print(response.body);
    }
    return alertText;
  }

  Future<String> signInByPhone(String phone, String password, context) async {
    String token;

    var response = await http.post(ApiUrl.LOG_IN_PHONE,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'phone': phone,
          'password': password,
        }));
    if (response.statusCode == 200) {
      SharedPreferences isLogin = await SharedPreferences.getInstance();
      SharedPreferences isToken = await SharedPreferences.getInstance();

      var responseJson = json.decode(response.body);

      token = responseJson['token'];
      if (token != null) {
        isLogin.setBool("isLogin", true);
        isToken.setString('token', token);
        ApiGetServices().fetchUserPf(token);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      } else {
        try {
          alertText = responseJson['error']['message'];
        } catch (e) {
          alertText = responseJson['message'];
        }
      }
    } else {
      print(response.body);
    }
    return alertText;
  }

  Future<String> forgetPasswordByEmail(String email) async {
    var response = await http.post(ApiUrl.RESET_BY_EMAIL,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{'email': email}));
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      alertText = responseBody['message'];
    }
    return alertText;
  }

  Future<String> forgetPasswordByPhone(String phoneNumber) async {
    var response = await http.post(ApiUrl.RESET_BY_PHONE,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{'phone': '+855' + phoneNumber}));
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      alertText = responseBody['message'];
    }
    return alertText;
  }

  Future<String> signUpByEmail(String email, String password) async {
    var response = await http.post(ApiUrl.SIGN_UP_EMAIL,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      print(response.body);
      alertText = responseBody['message'];
    } else {
      print(response.body);
    }

    return alertText;
  }

  Future<String> signUpByPhone(String phone, String password, context) async {
    var response = await http.post(ApiUrl.SIGN_UP_PHONE,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'phone': phone,
          'password': password,
        }));
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      print(responseBody);
      print(response.body);
      alertText = responseBody['message'];
      if (alertText == 'Successfully registered!') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreen(phone, password)));
      }
    } else {
      print(response.body);
    }
    return alertText;
  }

  Future<String> setUserPf(String firstName, String midName, String lastName,
      String gender, String _token) async {
    var response = await http.post(ApiUrl.SET_USER_PROFILE,
        headers: <String, String>{
          "accept": "application/json",
          "authorization": "Bearer " + _token,
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{
          "first_name": firstName,
          "mid_name": midName,
          "last_name": lastName,
          "gender": gender,
        }));
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      alertText = responseBody['message'];
    } else {
      alertText = responseBody['error']['message'];
    }
    return alertText;
  }

  Future<String> getWallet(String pin, String _token) async {
    var response = await http.post(ApiUrl.GET_WALLET,
        headers: <String, String>{
          "accept": "application/json",
          "authorization": "Bearer " + _token,
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{"pin": pin}));
    var responseBody = json.decode(response.body);
    if (response.statusCode == 200) {
      alertText = responseBody['message'];
    } else {
      alertText = responseBody['error']['message'];
    }
    return alertText;
  }

  Future<String> verifyByPhone(String phone, String verifyCode) async {
    var response = await http.post(ApiUrl.VERIFY_BY_PHONE,
        headers: ApiHeader.headers,
        body: <String, String>{
          'phone': phone,
          'verification_code': verifyCode,
        });
    if (response.statusCode == 200) {}
    return alertText;
  }

  Future<String> resendCode(String phoneNumber) async {
    var response = await http.post(ApiUrl.RESEND_CODE,
        headers: ApiHeader.headers,
        body: <String, String>{
          'phone': phoneNumber,
        });
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      alertText = responseJson['message'];
    }

    return alertText;
  }
}
