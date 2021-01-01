import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/services/root_page.dart';

//Generate route for navigation
Route<dynamic> generateRoute(RouteSettings settings) {
  //final args = settings.arguments as String;
  switch (settings.name) {
    case SplashScreenView:
      return RouteAnimation(
        enterPage: SplashScreen(),
        routeName: SplashScreenView,
      );
      break;
    case RootPageView:
      return RouteAnimation(
        enterPage: RootPage(),
      );
      break;
    case WelcomeView:
      return RouteAnimation(
        enterPage: WelcomeScreen(),
        routeName: WelcomeView,
      );
    case DetailView:
      return MaterialPageRoute(
        builder: (context) => DetailScreen(),
        //settings: RouteSettings(name: '$DetailView/$args'),
      );
    case CartView:
      return RouteAnimation(
        enterPage: CartScreen(),
        routeName: CartView,
      );
      break;
    case AddListingView:
      return RouteAnimation(
        enterPage: AddListing(),
        routeName: AddListingView,
      );
      break;
    case ListingView:
      return RouteAnimation(
        enterPage: ListingScreen(),
        routeName: ListingView,
      );
      break;
    case CheckoutView:
      return RouteAnimation(
        enterPage: Checkout(),
        routeName: CheckoutView,
      );
      break;
    case FavoriteView:
      return RouteAnimation(
        enterPage: FavoriteScreen(),
        routeName: FavoriteView,
      );
      break;
    case MapView:
      return RouteAnimation(
        enterPage: MapScreen(),
        routeName: MapView,
      );
      break;
    case SellerInfoView:
      return MaterialPageRoute(
        builder: (context) => SellerConfirm(),
        settings: RouteSettings(name: SellerInfoView),
      );
      break;
    case ProfileView:
      return RouteAnimation(
        enterPage: ProfileScreen(),
        routeName: ProfileView,
      );
      break;
    case PurchaseView:
      return RouteAnimation(
        enterPage: PurchaseScreen(),
        routeName: PurchaseView,
      );
      break;
    case BottomNavigationView:
      return RouteAnimation(
        enterPage: BottomNavigation(),
        routeName: BottomNavigationView,
      );
      break;
    case ResetChoiceView:
      return RouteAnimation(
        enterPage: ResetChoice(),
        routeName: ResetChoiceView,
      );
      break;
    case SettingView:
      return RouteAnimation(
        enterPage: SettingScreen(),
        routeName: SettingView,
      );
      break;
    case ChatView:
      return RouteAnimation(
        enterPage: Chat(),
        routeName: ChatView,
      );
      break;
    case IndividualChatView:
      return RouteAnimation(
        enterPage: IndividualChat(),
        routeName: IndividualChatView,
      );
      break;
    case SignInView:
      return RouteAnimation(
        enterPage: SignIn(),
        routeName: SignInView,
      );
      break;
    case SignUpView:
      return RouteAnimation(
        enterPage: SignUpScreen(),
        routeName: SignUpView,
      );
      break;
    case UserInfoView:
      return RouteAnimation(
        enterPage: UserInfoScreen(),
        routeName: UserInfoView,
      );
      break;
    case WalletScreenView:
      return RouteAnimation(
        enterPage: WalletScreen(),
        routeName: WalletScreenView,
      );
      break;
    case IntroScreenView:
      return RouteAnimation(
        enterPage: IntroScreen(),
        routeName: IntroScreenView,
      );
      break;
    case NotificationView:
      return RouteAnimation(
        enterPage: NotificationScreen(),
        routeName: NotificationView,
      );
      break;
    case WalletPinView:
      return RouteAnimation(
        enterPage: WalletPin(),
        routeName: WalletPinView,
      );
      break;
    case MyQrView:
      return RouteAnimation(
        enterPage: MyQr(),
        routeName: MyQrView,
      );
      break;
    case SaleScreenView:
      return RouteAnimation(
        enterPage: SalesScreen(),
        routeName: SaleScreenView,
      );
      break;
    case TransactionView:
      return RouteAnimation(
        enterPage: TransactionHistory(),
        routeName: TransactionView,
      );
      break;
    case LangView:
      return RouteAnimation(
        enterPage: Lang(),
        routeName: LangView,
      );
      break;
    default:
      return RouteAnimation(
        enterPage: SignIn(),
        routeName: SignInView,
      );
  }
}
