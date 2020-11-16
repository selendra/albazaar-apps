import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/screens/signup/components/phone_body.dart';

class SignUpPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.close,color: kDefualtColor,),onPressed: (){
          Navigator.pop(context);
        },),
      ),
      body: Body()
    );
  }
}