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
        String _token = value;
        if (_token != null) {
          await ApiGetServices().fetchPortforlio().then((onValue) {
            print(onValue);
            if (onValue == '200') {
              Provider.of<ApiGetServices>(context, listen: false)
                  .fetchUserInfo();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()));
            } else {
              _pref.clear('token');
            }
          });
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              }
            },
          );
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => WelcomeScreen()));
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
