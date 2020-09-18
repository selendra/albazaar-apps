import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/models/wallet.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';

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
          scrollDirection: Axis.horizontal,
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
                leading: Image.asset(wallets[index].logo, width: 30, height: 30),
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
