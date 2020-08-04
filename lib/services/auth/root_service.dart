import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/screens/welcome/welcome_screen.dart';
import 'package:selendra_marketplace_app/services/network_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RootServices extends StatefulWidget {

  @override
  _RootServicesState createState() => _RootServicesState();
}

class _RootServicesState extends State<RootServices> {


  void checkUser()async{
    SharedPreferences isLogin = await SharedPreferences.getInstance();
    var status = isLogin.getBool("isLogin") ?? false;
    if(status){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkUser();
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
