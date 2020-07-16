import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/screens/welcome/welcome_screen.dart';

class RootServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _handleAuthServices();
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
