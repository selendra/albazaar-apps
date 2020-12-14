import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

//Api Base Url
const baseUrl = 'https://testnet-api.selendra.com';

//App title
const appTitle = 'Selendra Marketplace';

//Design material
//Color(0xFF03A9F4);
const kDefaultRadius = 8.0;
var kDefaultShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(kDefaultRadius),
);

var titleTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: kDefaultColor,
);
//Map
const osmMapTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
const kDefaultMapZoom = 7.0;
const kDefaultMaxZoom = 19.0;
const kDefaultMinZoom = 7.0;

const String resetPassText =
    'Enter the email that associated with your account and we\'ll send an email with instruction to reset your password';
const String resetPassPhoneText =
    'Enter the phone that associated with your account and we\'ll send an sms with instruction to reset your password';
const String newPassText =
    'Enter the Pin that you have recieve and Enter your new password!!';
//Flag url
const String engFlag =
    'https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/1200px-Flag_of_the_United_Kingdom.svg.png';
const String khFlag =
    'https://cdn.webshopapp.com/shops/94414/files/53596372/cambodia-flag-image-free-download.jpg';

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
const String IndividualChatView = '/individualchat';
const String ChatView = '/chat';
const String MyQrView = '/myqr';
const String TransactionView = '/transaction';
const String ResetChoiceView = '/resetchoice';
const String SellerInfoView = '/sellerinfo';

//const String CategoryView = '/category';
//const String ResetView = 'reset';
