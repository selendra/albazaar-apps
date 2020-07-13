import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/wallet.dart';
import 'package:selendra_marketplace_app/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
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
