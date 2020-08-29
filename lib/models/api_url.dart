import 'package:selendra_marketplace_app/constants.dart';
class ApiUrl {
  static const LOG_IN_URL = BASE_URL+'/pub/v1/loginbyemail';
  static const LOG_IN_PHONE = BASE_URL+'/pub/v1/loginbyphone';
  static const SIGN_UP_EMAIL = BASE_URL+'/pub/v1/registerbyemail';
  static const SIGN_UP_PHONE =  BASE_URL+'/pub/v1/registerbyphone';
  static const RESET_BY_EMAIL = BASE_URL+'/pub/v1/forget-password-by-email';
  static const RESET_BY_PHONE = BASE_URL+'/pub/v1/forget-password';
  static const SET_USER_PROFILE = BASE_URL+'/pub/v1/userprofile';
  static const VERIFY_BY_PHONE = BASE_URL+'/pub/v1/account-confirmation';
  static const GET_WALLET = BASE_URL+'/pub/v1/getwallet';
  static const RESEND_CODE = BASE_URL+'/pub/v1/resend-code';  
  static const DISPLAY_PORTFORLIO = BASE_URL+'/pub/v1/portforlio';
  static const GOOGLE_SIGN_IN = BASE_URL+'/oauth/v1/login-from-google';
  static const ADD_PHONE_NUMBER = BASE_URL+'/pub/v1/add-phonenumber';
}


class ApiHeader {

   static const headers = <String, String>{
    "accept": "application/json",
    "Content-Type": "application/json"
  };
  
}
