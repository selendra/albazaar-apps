import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_button.dart';
import 'package:selendra_marketplace_app/core/models/acc_balance.dart';
import 'wallet_list.dart';

class MyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(context) {
    final height = MediaQuery.of(context).size.height;
    return OrientationBuilder(
      builder: (context, orientation) {
        return Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: orientation == Orientation.portrait
                      ? height / 4
                      : height / 2,
                  width: MediaQuery.of(context).size.width,
                  color: kDefaultColor,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text(
                        'TOTAL BALANCE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        mBalance[1].balance,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: orientation == Orientation.portrait
                      ? height / 5
                      : height / 3,
                  right: 10.0,
                  left: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    WalletList(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          ReuseButton.getItem('Add', () {
                            print('add');
                          }, context),
                          SizedBox(
                            height: 10,
                          ),
                          ReuseButton.getItem('Withdrawal', () {
                            print('withdrawal');
                          }, context)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
