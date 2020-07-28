import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';



class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildCreateWallet(context),
    );
  }
  Widget _buildAppBar(){
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      title: Text('Wallet',style: TextStyle(fontWeight: FontWeight.w600,color: kDefualtColor),),
      leading: Icon(Icons.account_balance_wallet,color: kDefualtColor,),
    );
  }
  Widget _buildCreateWallet(context){
    return Container(
      margin: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/cryto_wallet.jpg'),
          SizedBox(height: 50,),
          _btnCreateWallet(context),
        ],
      ),
    );
  }
  Widget _btnCreateWallet(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: RaisedButton(
        onPressed: (){
          print('Create Wallet');
        },
        child: Text(
          "Create Wallet",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        color: kDefualtColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
      ),
    );
  }
  

}
