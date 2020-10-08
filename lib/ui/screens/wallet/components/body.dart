import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:selendra_marketplace_app/ui/screens/wallet/get_wallet/wallet_pin.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String alertText;

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        context = navigationKey.currentState.overlay.context;
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text('Oops!'),
      content: Text(alertText),
      actions: [
        okButton,
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: navigationKey.currentState.overlay.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future checkFirstSeen() async {
    SharedPreferences isSeen = await SharedPreferences.getInstance();
    bool _seen = (isSeen.getBool('seen') ?? false);

    if (_seen != true) {
      isSeen.setBool('seen', true);
      showAlertDialog(context);
    }
  }

  onfetchPortforlio() async {
    await ApiGetServices().fetchPortforlio().then((value) {
      alertText = value;
      if (alertText == '200') {
        alertText = 'Look like you don\'t have a wallet yet!';
      }
      print(value);
      if (alertText != '') {
        checkFirstSeen();
      }
    });
  }

  checkIsSocialLogIn() async {
    String _token;
    SharedPreferences isToken = await SharedPreferences.getInstance();
    _token = isToken.getString('token');
    if (_token != null) {
      onfetchPortforlio();
    } else {
      alertText = 'Look like you don\'t have a wallet yet!';
      checkFirstSeen();
    }
  }

  onGetWallet() async {
    String _token;
    SharedPreferences isToken = await SharedPreferences.getInstance();
    _token = isToken.get('token');
    if (_token == null) {
      alertText = 'Please Sign up with Email or Phone to get wallet';
      showAlertDialog(context);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WalletPin()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsSocialLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return mBalance.isEmpty ? Center(child: _walletChoice()) : MyWallet();
  }

  Widget _walletChoice() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'images/undraw_wallet.svg',
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
                placeholderBuilder: (context) => Center(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            ReuseButton.getItem(
                AppLocalizeService.of(context).translate('wallet'), () {
              onGetWallet();
            }, context),
          ],
        ),
      ),
    );
  }
}
