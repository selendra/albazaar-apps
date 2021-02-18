import 'package:flutter/material.dart';

const pd35 = 35.0;

class PaddingScaffold extends StatelessWidget{
  
  final double pTop; 
  final double pBottom; 
  final double pLeft;
  final double pRight;
  final Widget child;

  PaddingScaffold({this.pTop: 0, this.pBottom: 0, this.pLeft: pd35, this.pRight: pd35, this.child});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: pTop, bottom: pBottom, right: pLeft, left: pRight),
      child: child
    );
  }
}
