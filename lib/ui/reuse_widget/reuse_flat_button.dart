import 'package:flutter/material.dart';

class ReuseFlatButton {
  static getItem(String text1, String text2, Function onPressed) {
    return Container(
      child: FlatButton(
        onPressed: onPressed,
        child: RichText(
          text: TextSpan(
            text: text1,
            style: TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: text2,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
