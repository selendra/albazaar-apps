import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseAppBar {
  static getTitle(String title, context, appBarItemOne, appBarItemTwo,
      appBarItemThree, controller) {
    return AppBar(
      brightness: Brightness.light,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: kDefaultColor,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      bottom: ReuseTabBar.getItem(appBarItemOne, appBarItemTwo, appBarItemThree, controller, context),
      //  backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: kDefaultColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
