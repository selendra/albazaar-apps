import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseResetForm extends StatelessWidget {
  final String _email;
  ReuseResetForm(this._email);

  String _pin, _newPassword;

  final _formKey = GlobalKey<FormState>();

  void validateAndSubmit(context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await AuthProvider()
          .resetByEmail(_pin, _email, _newPassword)
          .then((value) {
        ReuseAlertDialog().successDialog(context, value);
      });
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
            margin: const EdgeInsets.all(20.0),
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
                    height: 10.0,
                  ),
                  ReuseTextField(
                    labelText: 'Email Address',
                    initialValue: _email,
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
