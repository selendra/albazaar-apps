import 'package:flutter/material.dart';
import 'package:albazaar_app/core/constants/constants.dart';

class ReusePwField extends StatefulWidget {
  const ReusePwField(
      {this.fieldKey,
      this.maxLength,
      this.labelText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.onTap,
      this.controller
    });

  final TextEditingController controller;
  final Key fieldKey;
  final int maxLength;
  final String labelText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final Function onTap;

  @override
  _ReusePwFieldState createState() => _ReusePwFieldState();
}

class _ReusePwFieldState extends State<ReusePwField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        key: widget.fieldKey,
        onTap: widget.onTap,
        obscureText: _obscureText,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefaultColor),
            borderRadius: BorderRadius.all(
              Radius.circular(kDefaultRadius),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
            borderRadius: BorderRadius.all(
              Radius.circular(kDefaultRadius),
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: kDefaultColor,
            ),
          ),
        ),
      ),
    );
  }
}
