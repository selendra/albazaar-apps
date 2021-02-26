import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';

class MyFlatButton extends StatelessWidget{

  final String textButton;
  final String buttonColor;
  final FontWeight fontWeight;
  final double fontSize;
  final EdgeInsetsGeometry edgeMargin;
  final EdgeInsetsGeometry edgePadding;
  final bool hasShadow;
  final Function action;
  final double width;
  final double height;
  final Widget child;

  MyFlatButton({
    this.textButton, 
    this.buttonColor = AppColors.primary, 
    this.fontWeight =  FontWeight.w600, 
    this.fontSize = 18, 
    this.edgeMargin = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.edgePadding = const EdgeInsets.fromLTRB(0, 0, 0, 0), 
    this.hasShadow = false, 
    this.width = double.infinity,
    this.height,
    this.child,
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgePadding,
      margin: edgeMargin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), 
        boxShadow: [
          if (hasShadow) BoxShadow(
            color: Colors.black54.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 5.0),
          )
        ]
      ),
      child: FlatButton(
        height: height,
        color: AppServices.hexaCodeToColor(buttonColor),
        disabledColor: Colors.grey[700],
        focusColor: AppServices.hexaCodeToColor(buttonColor),
        child: child,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: action
      ),
    );
  }
}