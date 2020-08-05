import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'reuse_tabbar.dart';

class ReuseAppBar {
  static getTitle(String title,context,appBarItemOne, appBarItemTwo, appBarItemThree, controller){
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: kDefualtColor,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      bottom: ReuseTabBar.getItem(appBarItemOne, appBarItemTwo, appBarItemThree, controller,context),
      backgroundColor: Colors.white,
      leading: IconButton(icon: Icon(Icons.arrow_back,color: kDefualtColor,),onPressed: (){
        Navigator.pop(context);
      },),
    );
  }
}
