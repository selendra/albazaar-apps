import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/wallet.dart';
import 'package:selendra_marketplace_app/constants.dart';

class WalletList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _walletList();
  }

  Widget _walletList() {
    return Container(
      child: ListView.builder(
          itemCount: wallets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefaultRadius),
                  side: BorderSide(
                    color: kDefaultColor,
                  )),
              margin: EdgeInsets.all(10.0),
              child: ListTile(
                trailing: Text(
                  wallets[index].amount,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                leading: Image.asset('images/logo.png', width: 30, height: 30),
                title: Text(
                  wallets[index].title,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            );
          }),
    );
  }
}
