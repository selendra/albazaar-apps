import 'package:flutter/material.dart';


class WalletPin extends StatefulWidget {
  @override
  _WalletPinState createState() => _WalletPinState();
}

class _WalletPinState extends State<WalletPin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Pin(),
      ),
    );
  }
}
class Pin extends StatefulWidget {
  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {

  
  List<String> currentPin = ["","","",""];
  int pinIndex = 0;
  
  TextEditingController pinOne = TextEditingController();
  TextEditingController pinTwo = TextEditingController();
  TextEditingController pinThree = TextEditingController();
  TextEditingController pinFour = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: Colors.transparent),
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}