import 'package:flutter/material.dart';

//Api Base Url
const baseUrl = 'https://testnet-api.selendra.com';

//Design material
const kDefaultColor = Color(0xFF303F9F); //Color(0xFF03A9F4);
const kDefaultRadius = 8.0;
var kDefaultShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(kDefaultRadius),
);

//Map
const osmMapTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
const kDefaultMapZoom = 7.0;
const kDefaultMaxZoom = 19.0;
const kDefaultMinZoom = 7.0;

//Decoration Phone Field
const kDefualtPInputDecoration = InputDecoration(
  labelText: 'Phone Number',
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kDefaultColor),
    borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent),
      borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
);

//Route Name
const String SplashScreenView = '/';
const String CartView = '/cart';
const String AddListingView = '/addlisting';
const String ListingView = '/listing';
const String CheckoutView = '/checkout';
const String DetailView = '/detail';
const String FavoriteView = '/favorite';
const String MapView = '/map';
const String ProfileView = '/profile';
const String PurchaseView = '/purchase';
const String SettingView = '/setting';
const String SignInView = '/signin';
const String SignUpView = '/signup';
const String UserInfoView = '/userinfo';
const String WalletScreenView = '/wallet';
const String IntroScreenView = '/intro';
const String WelcomeView = '/welcome';
const String NotificationView = '/notification';
const String BottomNavigationView = '/bottomnavigation';
const String WalletPinView = '/walletpin';
const String SaleScreenView = '/salescreen';
const String LangView = '/lang';
//const String CategoryView = '/category';
//const String ResetView = 'reset';
