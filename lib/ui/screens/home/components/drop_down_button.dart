import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class DropDownButtons extends StatefulWidget {
  @override
  _DropDownButtonsState createState() => _DropDownButtonsState();
}

class _DropDownButtonsState extends State<DropDownButtons> {
  List<String> itemsList = ['EN', 'KH'];

  @override
  Widget build(BuildContext context) {
    return Consumer<LangProvider>(
      builder: (context, value, child) => ReuseDropDown(
        icon: Icon(
          Icons.language,
          color: kDefaultColor,
        ),
        style: TextStyle(color: kDefaultColor),
        itemsList: itemsList,
        initialValue: value.lang,
        onChanged: (myValue) {
          setState(
            () {
              //value.setLocal(myValue);
            },
          );
        },
      ),
    );
  }
}
