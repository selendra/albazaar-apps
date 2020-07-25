import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/constants.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  final String password;
  VerifyEmailScreen(this.email,this.password);
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {


  String isVerify ='Not Verify';
  bool isVerifyOrNot = false;
  

  trySignIn(String email,String password) async{
    String apiUrl = "https://testnet-api.zeetomic.com/pub/v1/loginbyemail";
    
    var response = await http.post(apiUrl,headers: <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json"
    },body: jsonEncode(<String,String>{
      'email': email,
      'password': password,
    }));
    if(response.statusCode ==200){
      print('success');
      print(response.body);
      setState(() {
        isVerify = 'Verified';
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
    }else {
      print(response.statusCode);
      print('You havent verifty');
    }
  }


  @override
  void initState() {
    super.initState();
    trySignIn(widget.email, widget.password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Please check your email to verify'),
              Text(isVerify),
              _btnSignUp(),
            ],
          ),
        ),
      ),
      );
  }
   Widget _btnSignUp(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: RaisedButton(
        onPressed: (){
          trySignIn(widget.email, widget.password);
        },
        child: Text(
          "Verify",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        color: kDefualtColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
      ),
    );
  }

}