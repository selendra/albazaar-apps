import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Backend _backend = Backend();

  GetRequest _getRequest = GetRequest();

  showAlertDialog(BuildContext context, String alertText) {
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

  onGetWallet() async {
    // String _token;
    // SharedPreferences isToken = await SharedPreferences.getInstance();
    // _token = isToken.get('token');
    // if (_token == null) {
    //   String alertText = 'Please Sign up with Email or Phone to get wallet';
    //   showAlertDialog(context, alertText);
    // } else {
    //   Navigator.pushNamed(context, WalletPinView);
    // }

    Navigator.pushNamed(context, WalletPinView);
  }

  void getMyWallet() async {
    PrefService _pref = PrefService();
    await _pref.read('token').then((value) => print("Hello"+value.toString()));
    await StorageServices.fetchData('user_token').then((value) => print("Hello"+value['token'].toString()));
  }

  void resetState() {
    setState(() {});
  }

  void fetchHistory() async {
    await _getRequest.getTrxHistory();
  }

  @override
  void initState() {
    fetchHistory();
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
    getMyWallet();
  }

  @override
  Widget build(BuildContext context) {
    return mBalance.data == null
        ? Center(
            child: WalletChoice(onGetWallet, showAlertDialog),
          )
        : MyWallet(resetState: resetState);
  }
}
