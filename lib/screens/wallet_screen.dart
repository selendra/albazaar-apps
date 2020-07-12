import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/models/wallet.dart';


class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text('Wallet',style: TextStyle(fontWeight: FontWeight.w600,color: kDefualtColor),),
      ),
      body: _buildBody(),
    );
  }
  Widget _buildBody(){
    return Container(
      margin: EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: wallets.length,
        itemBuilder: (context,index){
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(
                color: kDefualtColor,
              )
            ),
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              trailing: Text(wallets[index].amount,style: TextStyle(fontWeight: FontWeight.w900),),
              leading: Icon(Icons.attach_money,color: kDefualtColor,),
              title: Text(wallets[index].title,style: TextStyle(fontWeight: FontWeight.w900),),
            ),
          );
      }),
    );
  }
}
