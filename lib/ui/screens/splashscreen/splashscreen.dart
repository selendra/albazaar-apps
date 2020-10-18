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
    _pref.read('token').then(
      (value) async {
        print(value);
        String _token = value;
        if (_token != null) {
          print('not null');
          await ApiGetServices().fetchPortforlio().then(
            (onValue) {
              print(onValue);
              if (onValue == '200') {
                Provider.of<ApiGetServices>(context, listen: false)
                    .fetchUserInfo();
                Provider.of<ProductsProvider>(context, listen: false).getVegi();

                Navigator.pushReplacementNamed(context, BottomNavigationView);
              } else {
                _pref.clear('token');
              }
            },
          );
        } else {
          Auth().currentUser.then(
            (value) {
              if (value != null) {
                Provider.of<ApiGetServices>(context, listen: false)
                    .fetchSocialUserInfo(
                        value.email, value.displayName, value.photoUrl);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigation(),
                    ));
              } else {
                // Navigator.pushReplacement(
                //   context,
                //   new PageRouteBuilder(
                //     pageBuilder: (context, animation, secondaryAnimation) =>
                //         WelcomeScreen(),
                //     transitionDuration: Duration(milliseconds: 500),
                //     transitionsBuilder:
                //         (context, animation, secondaryAnimation, child) {
                //       animation = CurvedAnimation(
                //           curve: Curves.easeIn, parent: animation);
                //       return SlideTransition(
                //         position: Tween<Offset>(
                //           begin: Offset(1.0, 0.0),
                //           end: Offset.zero,
                //         ).animate(animation),
                //         child: child,
                //       );
                //     },
                //   ),
                // );
                Navigator.pushReplacementNamed(context, WelcomeView);
              }
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    //CHECK AUTH
    Timer(Duration(milliseconds: 2000), () {
      checkUser();
    });

    for (int i = 0; i < svg.length; i++) {
      precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoder, svg[i]), null);
    }

    //SET LANGUAGE
    var _lang = Provider.of<LangProvider>(context, listen: false);

    _pref.read('lang').then((value) {
      _lang.setLocal(value, context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'images/logo.png',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
