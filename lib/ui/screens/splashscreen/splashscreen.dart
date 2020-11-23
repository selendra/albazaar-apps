import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  PrefService _pref = PrefService();

  List<String> svg = [
    'images/undraw_wallet.svg',
    'images/undraw_loving_it.svg',
    'images/undraw_empty_cart.svg',
    'images/undraw_Mobile_application.svg'
  ];

  void checkUser() {
    //READ TOKEN
    _pref.read('token').then(
      (value) async {
        print("Token $value");
        if (value != null) {
          Provider.of<UserProvider>(context, listen: false).fetchUserInfo();
          Provider.of<ProductsProvider>(context, listen: false)
              .fetchListingProduct();

          Navigator.pushReplacementNamed(context, BottomNavigationView);
          // await UserProvider().fetchPortforlio().then(
          //   (onValue) {
          //     //Check if the token is valid or not
          //     print(onValue);
          //     if (onValue == '200') {
          //       //Provider.of<ProductsProvider>(context, listen: false).fetch();
          //       //Fetch user infomation from share preference(local storage)
          //       Provider.of<UserProvider>(context, listen: false)
          //           .fetchUserInfo();
          //       Provider.of<ProductsProvider>(context, listen: false)
          //           .fetchListingProduct();

          //       Navigator.pushReplacementNamed(context, BottomNavigationView);
          //     } else {
          //       /*If the token is not valid clear it
          //       and return to the welcome screen*/
          //       _pref.clear('token');
          //       Navigator.pushReplacementNamed(context, WelcomeView);
          //     }
          //   },
          // );
        } else {
          //Checking is social user login or not by getting the current user
          AuthProvider().currentUser.then((value) {
            if (value != null) {
              // Provider.of<UserProvider>(context, listen: false)
              //     .fetchSocialUserInfo();
              //);
            }
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    //Timer is used to display logo base on duration 2second
    Timer(
      Duration(milliseconds: 2000),
      () {
        _pref.read('isshow').then(
          (onValue) {
            if (onValue == null) {
              Navigator.pushReplacementNamed(context, IntroScreenView);
            } else {
              checkUser();
            }
          },
        );
      },
    );

    //Precache all svg image to improve of svg loading
    for (int i = 0; i < svg.length; i++) {
      precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoder, svg[i]), null);
    }

    //Set language using provider
    var _lang = Provider.of<LangProvider>(context, listen: false);
    _pref.read('lang').then(
      (value) {
        _lang.setLocal(value, context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAlert(
        Center(
          child: Image.asset(
            'images/logo.png',
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
