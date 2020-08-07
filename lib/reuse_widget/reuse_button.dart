import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';


class ReuseButton {
  static getItem (String text,Function onTap,context){
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: 50,
      child: RaisedButton(
        onPressed: onTap,
        child: Text(text,style: TextStyle(color: Colors.white),),
        color: kDefualtColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    );
  }
}
