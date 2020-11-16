import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ResetPhoneForm extends StatelessWidget {
  final String _phone;
  ResetPhoneForm(this._phone);

  final _formKey = GlobalKey<FormState>();
  String _pin, _newPassword;
  void validateAndSubmit(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_pin != null && _newPassword != null) {
        print(_pin);
        print(_newPassword);
        await AuthProvider()
            .resetByPhone(_pin, _phone, _newPassword)
            .then((value) {
          print(value);
          ReuseAlertDialog().successDialog(context, value);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('', context),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Create New Password', style: titleTextStyle),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(newPassText),
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ReuseTextField(
                    labelText: 'Pin',
                    onSaved: (newValue) => _pin = newValue,
                    validator: (value) => value.isEmpty || value.length < 6
                        ? "Pin is empty or less than 6 characters"
                        : null,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ReuseTextField(
                    labelText: 'PhoneNumber',
                    initialValue: _phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ReusePwField(
                    labelText: 'New Password',
                    validator: (value) => value.isEmpty || value.length < 6
                        ? "Password is empty or less than 6 characters"
                        : null,
                    onSaved: (newValue) => _newPassword = newValue,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ReuseButton.getItem('Reset Password', () {
                    validateAndSubmit(context);
                  }, context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
