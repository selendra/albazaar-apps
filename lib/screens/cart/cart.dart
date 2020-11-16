import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/cart/components/body.dart';
import 'package:selendra_marketplace_app/constants.dart';

class CartScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Body(),
    );
  }
  Widget _buildAppBar (context){
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,color: kDefualtColor,),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      title: Text('Cart',style: TextStyle(fontWeight: FontWeight.w600,color: kDefualtColor),),
    );
  }
}
