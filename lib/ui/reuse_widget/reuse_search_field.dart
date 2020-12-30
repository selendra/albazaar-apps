import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseSearchField extends StatefulWidget {
  const ReuseSearchField(
      {this.fieldKey,
      this.labelText,
      this.inputType,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.iconData});

  final Key fieldKey;
  final String labelText;
  final TextInputType inputType;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final IconData iconData;

  @override
  _ReuseSearchFieldState createState() => _ReuseSearchFieldState();
}

class _ReuseSearchFieldState extends State<ReuseSearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultRadius),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.only(right: 20),
      child: TextFormField(
        key: widget.fieldKey,
        onChanged: widget.onFieldSubmitted,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle:
              TextStyle(color: kDefaultColor.withOpacity(0.5), fontSize: 14.0),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefaultColor),
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: kDefaultColor,
          ),
        ),
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }
}
