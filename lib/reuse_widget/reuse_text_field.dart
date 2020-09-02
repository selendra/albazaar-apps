import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';

class ReuseTextField extends StatefulWidget {
  const ReuseTextField(
      {this.fieldKey,
      this.labelText,
      this.inputType,
      this.onSaved,
      this.validator,
      this.onChanged,
      this.prefixIcon,
      this.hintText,
      this.suffixIcon,
      this.textInputAction,
      this.onEditingComplete,
      this.onTap,
      this.initialValue});

  final Key fieldKey;
  final String labelText;
  final String hintText;
  final TextInputType inputType;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final TextInputAction textInputAction;
  final VoidCallback onEditingComplete;
  final Function onTap;
  final String initialValue;

  @override
  _ReuseTextFieldState createState() => _ReuseTextFieldState();
}

class _ReuseTextFieldState extends State<ReuseTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        key: widget.fieldKey,
        initialValue: widget.initialValue,
        textInputAction: widget.textInputAction,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefaultColor),
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
        ),
        onTap: widget.onTap,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }
}
