import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/screens/welcome/welcome_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:selendra_marketplace_app/services/network_alert.dart';



class RootServices extends StatefulWidget {

  @override
  _RootServicesState createState() => _RootServicesState();
}

class _RootServicesState extends State<RootServices> {

  String email;
  String displayName;
  String imageUrl;

  Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscript;

  void _popupDialog (BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('No Internet Connection !!!'),
            content: Text('Please check your internet connection ..'),
          );
        });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAlert(
        _handleAuthServices(),
      ),
    );
  }

  Widget _handleAuthServices(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else{
          FirebaseUser user = snapshot.data;
          if(user != null ){
            return BottomNavigation();
          }else{
            return WelcomeScreen();
          }
        }
      },
    );
  }
}
