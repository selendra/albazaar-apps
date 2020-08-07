import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseSimpleAppBar {
  static getItem(String title, context){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      leading: IconButton(icon: Icon(Icons.arrow_back,color:kDefualtColor,),onPressed: (){
        Navigator.pop(context);
      },),
    );
  }
}