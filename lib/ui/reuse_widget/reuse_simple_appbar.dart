import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ReuseSimpleAppBar {
  static getItem(String title, context, {List<Widget> actions}) {
    return AppBar(
      //backgroundColor: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      // centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: kDefaultColor,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: kDefaultColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: actions,
    );
  }
}
