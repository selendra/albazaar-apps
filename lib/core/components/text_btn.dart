import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class MyTextButton extends StatelessWidget{

  final String text;
  final Function onTap;
  final FontWeight fontWeight;

  MyTextButton({this.text, this.onTap, this.fontWeight = FontWeight.w600});

  Widget build(BuildContext  context) {
    return GestureDetector(
      onTap: onTap,
      child: MyPadding(
        child: MyText(width: double.infinity,text: text, fontWeight: fontWeight),
        pLeft: 0, pRight: 0, pTop: 18, pBottom: 18,
      ),
    );
  }
}