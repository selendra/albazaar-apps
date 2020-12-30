import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';

class ReusePhoneField extends StatefulWidget {
  ReusePhoneField({this.labelText, this.onSaved, this.onChanged});

  final String labelText;
  final FormFieldSetter<String> onSaved;
  final FormFieldSetter<String> onChanged;

  @override
  _ReusePhoneFieldState createState() => _ReusePhoneFieldState();
}

class _ReusePhoneFieldState extends State<ReusePhoneField> {
  String _countryCode = 'KH';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntlPhoneField(
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefaultColor),
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
        ),
        initialCountryCode: _countryCode,
        onSaved: (value) => widget.onSaved,
        onChanged: (value) => widget.onChanged,
      ),
    );
  }
}
