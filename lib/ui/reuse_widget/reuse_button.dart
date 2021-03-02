import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseButton {
  static getItem(
    String text, 
    Function onTap, 
    BuildContext context,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 59,
      child: RaisedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        color: kDefaultColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
        ),
      ),
    );
  }
}
