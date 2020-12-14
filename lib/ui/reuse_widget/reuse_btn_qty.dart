import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseBtnQty extends StatelessWidget {
  final Function onTap;
  final IconData iconData;
  final double height;
  final double width;

  ReuseBtnQty(this.onTap, this.iconData, {this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height ?? 40.0,
          width: width ?? 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultRadius),
              color: Colors.white,
              border: Border.all(color: kDefaultColor)),
          child: Icon(
            iconData,
            color: kDefaultColor,
          ),
        ),
      ),
    );
  }
}
