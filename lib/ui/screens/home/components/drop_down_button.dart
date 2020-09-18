import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_dropdown.dart';

class DropDownButtons extends StatefulWidget {
  @override
  _DropDownButtonsState createState() => _DropDownButtonsState();
}

class _DropDownButtonsState extends State<DropDownButtons> {
  String dropDownValue = 'EN';
  List<String> itemsList = ['EN','KH'];

  @override
  Widget build(BuildContext context) {
    return ReuseDropDown(
      icon: Icon(Icons.language,color: kDefaultColor,),
      style: TextStyle(color: kDefaultColor),
      itemsList: itemsList,
      initialValue: dropDownValue,
      onChanged: (value) {
        setState(() {
          dropDownValue = value;
        });
      } ,
    );
  }
}
