import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ReuseSimpleAppBar {
  static getItem(String title, context, {List<Widget> actions}) {
    return AppBar(
      //backgroundColor: Colors.white,
      toolbarHeight: 68,
      elevation: 0,
      brightness: Brightness.light,
      // centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: kDefaultColor,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
      ),
      leading: IconButton(
        alignment: Alignment.centerRight,
        icon: SvgPicture.asset('assets/icons/back.svg'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: actions,
    );
  }
}
