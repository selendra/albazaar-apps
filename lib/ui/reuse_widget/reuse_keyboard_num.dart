import 'package:flutter/material.dart';
import 'package:albazaar_app/core/constants/constants.dart';

class ReuseKeyBoardNum extends StatelessWidget {
  final int n;
  final Function() onPressed;

  ReuseKeyBoardNum(this.n, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kDefaultColor,
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        height: 90,
        child: Text(
          '$n',
          style: TextStyle(
              fontSize: 24 * MediaQuery.of(context).textScaleFactor,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}