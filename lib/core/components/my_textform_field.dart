import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';

class MyInputField extends StatelessWidget{

  final Key key;
  final String labelText;
  final String prefixText;
  final String textColor;
  final int maxLine;
  final double pLeft, pTop, pRight, pBottom;
  final bool obcureText;
  final bool enableInput;
  final List<TextInputFormatter> textInputFormatter;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final FocusNode focusNode;
  final IconButton icon;
  final Function validateField;
  final Function onChanged;
  final Function onSubmit;  

  MyInputField({/* User Input Field */
    this.key,
    this.labelText,
    this.prefixText,
    this.pLeft: 16.0, this.pTop: 5.0, this.pRight: 16.0, this.pBottom: 0,
    this.obcureText = false,
    this.enableInput = true,
    this.textInputFormatter,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLine = 1,
    @required this.controller,
    @required this.focusNode,
    this.icon,
    this.textColor = "#FFFFFF",
    this.validateField,
    @required this.onChanged,
    @required this.onSubmit
  });

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(pLeft, pTop, pRight, pBottom),
      child: TextFormField(
        key: this.key,
        enabled: enableInput,
        focusNode: focusNode,
        keyboardType: inputType,
        obscureText: obcureText,
        controller: controller,
        textInputAction: inputAction,
        style: TextStyle(color: AppServices.hexaCodeToColor(textColor), fontSize: 18.0),
        validator: validateField,
        maxLines: maxLine,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 18.0,
            color: AppServices.hexaCodeToColor("#FFFFF").withOpacity(0.3)
            // focusNode.hasFocus || controller.text != ""
            // ? AppServices.hexaCodeToColor("#FFFFF").withOpacity(0.3)
            // : AppServices.hexaCodeToColor()
          ),
          prefixText: prefixText,
          prefixStyle: TextStyle(color: AppServices.hexaCodeToColor("#FFFFFF"), fontSize: 18.0),
          /* Prefix Text */
          filled: true, 
          fillColor: AppServices.hexaCodeToColor("#FFFFFF"),
          enabledBorder: myTextInputBorder(controller.text != ""
            ? AppServices.hexaCodeToColor("#FFFFFF").withOpacity(0.3)
            : Colors.transparent
          ),
          /* Enable Border But Not Show Error */
          border: errorOutline(),
          /* Show Error And Red Border */
          focusedBorder: myTextInputBorder(AppServices.hexaCodeToColor("#FFFFFF").withOpacity(0.3)),
          /* Default Focuse Border Color*/
          focusColor: AppServices.hexaCodeToColor("#ffffff"),
          /* Border Color When Focusing */
          contentPadding: EdgeInsets.fromLTRB(21, 23, 21, 23), // Default padding = -10.0 px
          suffixIcon: icon,
        ),
        inputFormatters: textInputFormatter,
        /* Limit Length Of Text Input */
        onChanged: onChanged,
        onFieldSubmitted: (value) {
          onSubmit();
        },
      )
    );
  }
}

/* User input Outline Border */
OutlineInputBorder myTextInputBorder(Color borderColor) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: 1),
    borderRadius: BorderRadius.circular(8)
  );
}