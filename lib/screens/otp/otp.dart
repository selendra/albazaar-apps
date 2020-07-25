import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';


class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP'),),
      body: Builder(
        builder: (context) => Padding(
          padding: EdgeInsets.all(40.0),
          child: Center(
          ),
        ),
      )
    );
  }
  
}
