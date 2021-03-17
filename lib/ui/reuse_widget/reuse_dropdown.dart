import 'package:flutter/material.dart';

class ReuseDropDown extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Widget icon;
  final String initialValue;
  final TextStyle style;
  final List<String> itemsList;

  ReuseDropDown({
    this.onChanged,
    this.initialValue,
    this.icon,
    this.style,
    this.itemsList
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: initialValue,
        underline: Container(
          color: Colors.white,
        ),
        style: style,
        icon: icon,
        onChanged: onChanged,
        items: itemsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
