import 'package:selendra_marketplace_app/core/constants/constants.dart';

class ApiUrl {
  static const LOG_IN_URL = baseUrl + '/pub/v1/loginbyemail';
  static const LOG_IN_PHONE = baseUrl + '/pub/v1/loginbyphone';
  static const SIGN_UP_EMAIL = baseUrl + '/pub/v1/registerbyemail';
  static const SIGN_UP_PHONE = baseUrl + '/pub/v1/registerbyphone';
  static const FORGET_BY_EMAIL = baseUrl + '/pub/v1/forget-password-by-email';
  static const FORGET_BY_PHONE = baseUrl + '/pub/v1/forget-password';
  static const RESET_BY_EMAIL = baseUrl + '/pub/v1/reset-password-by-email';
  static const RESET_BY_PHONE = baseUrl + '/pub/v1/reset-password';
  static const SET_USER_PROFILE = baseUrl + '/pub/v1/userprofile';
  static const VERIFY_BY_PHONE = baseUrl + '/pub/v1/account-confirmation';
  static const GET_WALLET = baseUrl + '/pub/v1/getwallet';
  static const RESEND_CODE = baseUrl + '/pub/v1/resend-code';
  static const DISPLAY_PORTFORLIO = baseUrl + '/pub/v1/portforlio';
  static const GOOGLE_SIGN_IN = baseUrl + '/oauth/v1/login-from-google';
  static const ADD_PHONE_NUMBER = baseUrl + '/pub/v1/add-phonenumber';

  //map search
  static const MAP_SEARCH = 'http://photon.komoot.de/api/?q=';
}

class ApiHeader {
  static const headers = <String, String>{
    "accept": "application/json",
    "Content-Type": "application/json"
  };
}
