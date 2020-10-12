import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

//generate route for navigation
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenView:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
      break;
    case WelcomeView:
      return MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      );
    case DetailView:
      return MaterialPageRoute(
        builder: (context) => DetailScreen(),
      );
      break;
    case CartView:
      return MaterialPageRoute(
        builder: (context) => CartScreen(),
      );
      break;
    case AddListingView:
      return MaterialPageRoute(
        builder: (context) => AddListing(),
      );
      break;
    case ListingView:
      return MaterialPageRoute(
        builder: (context) => ListingScreen(),
      );
      break;
    case CheckoutView:
      return MaterialPageRoute(
        builder: (context) => Checkout(),
      );
      break;
    case FavoriteView:
      return MaterialPageRoute(
        builder: (context) => FavoriteScreen(),
      );
      break;
    case MapView:
      return MaterialPageRoute(
        builder: (context) => MapScreen(),
      );
      break;
    case ProfileView:
      return MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      );
      break;
    case PurchaseView:
      return MaterialPageRoute(
        builder: (context) => PurchaseScreen(),
      );
      break;
    case BottomNavigationView:
      return MaterialPageRoute(
        builder: (context) => BottomNavigation(),
      );
      break;
    case SettingView:
      return MaterialPageRoute(
        builder: (context) => SettingScreen(),
      );
      break;
    case SignInView:
      return MaterialPageRoute(
        builder: (context) => SignIn(),
      );
      break;
    case SignUpView:
      return MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      );
      break;
    case UserInfoView:
      return MaterialPageRoute(
        builder: (context) => UserInfoScreen(),
      );
      break;
    case WalletScreenView:
      return MaterialPageRoute(
        builder: (context) => WalletScreen(),
      );
      break;
    case IntroScreenView:
      return MaterialPageRoute(
        builder: (context) => IntroScreen(),
      );
      break;
    case NotificationView:
      return MaterialPageRoute(
        builder: (context) => NotificationScreen(),
      );
      break;
    case WalletPinView:
      return MaterialPageRoute(
        builder: (context) => WalletPin(),
      );
      break;
    case SaleScreenView:
      return MaterialPageRoute(
        builder: (context) => SalesScreen(),
      );
      break;
    default:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
  }
}
