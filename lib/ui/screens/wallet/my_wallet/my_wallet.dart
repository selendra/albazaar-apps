import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'wallet_list.dart';

class MyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(context) {
    var _lang = AppLocalizeService.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                color: kDefaultColor,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      'TOTAL BALANCE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 40),
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
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4,
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
                        ReuseButton.getItem(_lang.translate('add'), () {
                          print('add');
                        }, context),
                        SizedBox(
                          height: 10,
                        ),
                        ReuseButton.getItem(_lang.translate('withdrawal'), () {
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
      ),
    );
  }
}
