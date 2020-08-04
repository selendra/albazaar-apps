import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';

class ReuseTextField extends StatefulWidget {

  const ReuseTextField({this.fieldKey,this.labelText,this.inputType,this.onSaved,this.validator,this.onFieldSubmitted});

  final Key fieldKey;
  final String labelText;
  final TextInputType inputType;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _ReuseTextFieldState createState() => _ReuseTextFieldState();
}

class _ReuseTextFieldState extends State<ReuseTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        key: widget.fieldKey,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
        validator: widget.validator,
        onSaved: widget.onSaved,
        ),
    );
  }
}