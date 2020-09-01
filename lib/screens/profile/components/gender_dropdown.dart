import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class GenderDropdown extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String initialValue;
  GenderDropdown({this.onChanged,this.initialValue});

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String initialValue = mUser.gender;
  List<String> itemsList = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gender',
            style: TextStyle(fontSize: 16),
          ),
          ReuseDropDown(
            initialValue: widget.initialValue,
            onChanged: widget.onChanged,
            itemsList: itemsList,
          ),
        ],
      ),
    );
  }
}

