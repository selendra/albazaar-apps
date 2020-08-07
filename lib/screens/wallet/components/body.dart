import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_button.dart';
import 'package:selendra_marketplace_app/screens/wallet/my_wallet.dart';
import 'package:selendra_marketplace_app/models/acc_balance.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();
    print(mBalance);
  }
  @override
  Widget build(BuildContext context) {
    return mBalance.isEmpty ? _walletChoice() : MyWallet();
  }

  Widget _walletChoice() {
    return Container(
      margin: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset('images/cryto_wallet.jpg'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ReuseButton.getItem('Get Wallet', () {}, context),
        ],
      ),
    );
  }
}
