import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  PrefService _pref = PrefService();

  AnimationController _controller;
  Animation<double> _animation;

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
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BottomNavigation(),
                      //transitionDuration: Duration(milliseconds: 2000),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        animation = CurvedAnimation(
                            curve: Curves.bounceIn, parent: animation);
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ));
                //Navigator.pushReplacementNamed(context, BottomNavigationView);
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
    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();

    //fade transition
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    Timer(Duration(milliseconds: 2000), () {
      checkUser();
    });
    //set Language
    var _lang = Provider.of<LangProvider>(context, listen: false);

    _pref.read('lang').then((value) {
      _lang.setLocal(value, context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RotationTransition(
          // opacity: _animation,
          turns: _animation,
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
