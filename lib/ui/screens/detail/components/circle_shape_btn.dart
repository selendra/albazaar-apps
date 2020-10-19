import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class CircleShapeBtn extends StatelessWidget {
  final Function _func;
  final IconData _icon;

  CircleShapeBtn(this._func, this._icon);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _func();
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.8),
        ),
        child: Icon(
          _icon,
          color: kDefaultColor,
        ),
      ),
    );
  }
}
