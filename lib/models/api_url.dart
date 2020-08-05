class ApiUrl {
  
  static const LOG_IN_URL = 'https://testnet-api.zeetomic.com/pub/v1/loginbyemail';
  static const LOG_IN_PHONE = 'https://testnet-api.zeetomic.com/pub/v1/loginbyphone';
  static const SIGN_UP_EMAIL = 'https://testnet-api.zeetomic.com/pub/v1/registerbyemail';
  static const SIGN_UP_PHONE =  'https://testnet-api.zeetomic.com/pub/v1/registerbyphone';
  static const RESET_BY_EMAIL = 'https://testnet-api.zeetomic.com/pub/v1/forget-password-by-email';
  static const RESET_BY_PHONE = 'https://testnet-api.zeetomic.com/pub/v1/forget-password';
  static const SET_USER_PROFILE = 'https://testnet-api.zeetomic.com/pub/v1/userprofile';
  static const VERIFY_BY_PHONE = 'https://testnet-api.zeetomic.com/pub/v1/account-confirmation';
  static const GET_WALLET = 'https://testnet-api.zeetomic.com/pub/v1/getwallet';

}


class ApiHeader {

   static const headers = <String, String>{
    "accept": "application/json",
    "Content-Type": "application/json"
  };
  
}
