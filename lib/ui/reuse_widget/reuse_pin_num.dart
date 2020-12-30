import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReusePinNum extends StatelessWidget {
  final OutlineInputBorder outlineInputBorder;
  final TextEditingController textEditingController;

  ReusePinNum(this.outlineInputBorder, this.textEditingController);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(kDefaultRadius),
          border: outlineInputBorder,
          filled: true,
          fillColor: Colors.grey[300],
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: kDefaultColor,
        ),
      ),
    );
  }
}
