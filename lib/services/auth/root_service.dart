import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/screens/welcome/welcome_screen.dart';
import 'package:selendra_marketplace_app/services/network_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:selendra_marketplace_app/models/user.dart';
import 'api_get_services.dart';

class RootServices extends StatefulWidget {
  @override
  _RootServicesState createState() => _RootServicesState();
}

class _RootServicesState extends State<RootServices> {
  void clearPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('first');
    pref.remove('pin');
  }

  void checkUser() async {

    SharedPreferences isToken = await SharedPreferences.getInstance();

    String _token = isToken.getString('token');
    if (_token!=null) {
      await ApiGetServices().fetchUserPf(_token).then((value) {
        mUser = value;
      });
      await ApiGetServices().fetchPortforlio(_token);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavigation()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAlert(
        _handleAuthServices(),
      ),
    );
  }

  Widget _handleAuthServices() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        clearPref();
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          FirebaseUser user = snapshot.data;
          if (user != null) {
            mUser.email = user.email;
            mUser.firstName = user.displayName;
            mUser.profileImg = user.photoUrl;
            return BottomNavigation();
          } else {
            checkUser();
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
