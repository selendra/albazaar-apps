import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

//generate route for navigation
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenView:
      return RouteAnimation(enterPage: SplashScreen());
      break;
    case WelcomeView:
      return RouteAnimation(enterPage: WelcomeScreen());
    case DetailView:
      return MaterialPageRoute(
        builder: (context) => DetailScreen(),
      );
    case CartView:
      return RouteAnimation(enterPage: CartScreen());
      break;
    case AddListingView:
      return RouteAnimation(enterPage: AddListing());
      break;
    case ListingView:
      return RouteAnimation(enterPage: ListingScreen());
      break;
    case CheckoutView:
      return RouteAnimation(enterPage: Checkout());
      break;
    case FavoriteView:
      return RouteAnimation(enterPage: FavoriteScreen());
      break;
    case MapView:
      return RouteAnimation(enterPage: MapScreen());
      break;
    case ProfileView:
      return RouteAnimation(enterPage: ProfileScreen());
      break;
    case PurchaseView:
      return RouteAnimation(enterPage: PurchaseScreen());
      break;
    case BottomNavigationView:
      return RouteAnimation(
        enterPage: BottomNavigation(),
      );
      break;
    case SettingView:
      return RouteAnimation(enterPage: SettingScreen());
      break;
    case SignInView:
      return RouteAnimation(enterPage: SignIn());
      break;
    case SignUpView:
      return RouteAnimation(enterPage: SignUpScreen());
      break;
    case UserInfoView:
      return RouteAnimation(enterPage: UserInfoScreen());
      break;
    case WalletScreenView:
      return RouteAnimation(enterPage: WalletScreen());
      break;
    case IntroScreenView:
      return RouteAnimation(enterPage: IntroScreen());
      break;
    case NotificationView:
      return RouteAnimation(enterPage: NotificationScreen());
      break;
    case WalletPinView:
      return RouteAnimation(enterPage: WalletPin());
      break;
    case SaleScreenView:
      return RouteAnimation(enterPage: SalesScreen());
      break;
    default:
      return RouteAnimation(enterPage: SplashScreen());
  }
}
