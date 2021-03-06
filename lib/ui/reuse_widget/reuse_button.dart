import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ReuseButton {
  static getItem(
    String text, 
    Function onTap, 
    BuildContext context,
    {double height = 59}
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
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
