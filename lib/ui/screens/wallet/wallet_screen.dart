import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/ui/screens/wallet/components/body.dart';



class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Body(),
    );
  }
  Widget _buildAppBar(){
    return AppBar(
      elevation: 0, 
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      title: Text('Wallet',style: TextStyle(fontWeight: FontWeight.w600,color: kDefaultColor),),
      leading: Icon(Icons.account_balance_wallet,color: kDefaultColor,),
    );
  }
  


}
