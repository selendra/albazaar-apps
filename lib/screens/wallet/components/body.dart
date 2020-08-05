import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/wallet.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_button.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .25,
              width: MediaQuery.of(context).size.width,
              color: kDefualtColor,
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
                    '43,729.00',
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
            )
          ],
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .2,
              right: 10.0,
              left: 10.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                _buildWallet(),
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
                      ReuseButton.getItem('Add', () {}, context),
                      SizedBox(
                        height: 10,
                      ),
                      ReuseButton.getItem('Withdrawal', () {}, context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
  Widget _walletChoice(){
    return Container(
      margin: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset('images/cryto_wallet.jpg'),
            ),
          ReuseButton.getItem('Get Wallet', (){}, context),
          SizedBox(height: 10,),
          ReuseButton.getItem('My Wallet', (){}, context),
        ],
      ),
    );
  }

  Widget _buildWallet() {
    return Container(
      child: ListView.builder(
          itemCount: wallets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                  side: BorderSide(
                    color: kDefualtColor,
                  )),
              margin: EdgeInsets.all(10.0),
              child: ListTile(
                trailing: Text(
                  wallets[index].amount,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                leading: ImageIcon(AssetImage('images/logo.png')),
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
