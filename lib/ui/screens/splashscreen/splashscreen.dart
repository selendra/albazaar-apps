import 'dart:async';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PrefService _pref = PrefService();

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
    var _lang = Provider.of<LangProvider>(context, listen: false);
    Timer(Duration(seconds: 2), () {
      checkUser();
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => Intro(),
      //     ));
      _pref.read('lang').then((value) {
        _lang.setLocal(value, context);
        //_lang.saveLang(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/logo.png',
                height: 200,
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
