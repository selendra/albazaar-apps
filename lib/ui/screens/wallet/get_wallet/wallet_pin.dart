import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pin_screen.dart';

class WalletPin extends StatefulWidget {
  @override
  _WalletPinState createState() => _WalletPinState();
}

class _WalletPinState extends State<WalletPin> {
  void clearPref() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('first');
    pref.remove('pin');
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            elevation: 0,
            //backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                clearPref();
              },
              icon: Icon(
                Icons.arrow_back,
                color: kDefaultColor,
              ),
            ),
          ),
          body: PinScreen(),
        ),
      ),
    );
  }
}
