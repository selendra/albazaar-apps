import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/services/app_services.dart';

class MyFlatButton extends StatelessWidget{

  final String buttonColor;
  final FontWeight fontWeight;
  final double fontSize;
  final Border border;
  final double borderRadius;
  final EdgeInsetsGeometry edgeMargin;
  final EdgeInsetsGeometry edgePadding;
  final bool hasShadow;
  final bool isTransparent;
  final Function action;
  final double width;
  final double height;
  final Widget child;

  MyFlatButton({
    this.buttonColor = AppColors.primary, 
    this.fontWeight =  FontWeight.w600, 
    this.fontSize = 18, 
    this.borderRadius = 12,
    this.border,
    this.edgeMargin = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.edgePadding = const EdgeInsets.fromLTRB(0, 0, 0, 0), 
    this.hasShadow = false, 
    this.isTransparent = false,
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
        borderRadius: BorderRadius.circular(borderRadius), 
        border: border,
        boxShadow: [
          if (hasShadow) BoxShadow(
            color: Colors.black54.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 5.0),
          )
        ]
      ),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(!isTransparent ? AppServices.hexaCodeToColor(buttonColor) : Colors.transparent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)))
        ),
        child: child,
        onPressed: action
      )
    );
  }
}