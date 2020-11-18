import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class OrderConfirmation extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String location, phone, email;

  void validateAndSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(location);
      print(phone);
      print(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    var data = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('', context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ReuseTextField(
                  labelText: _lang.translate('phone'),
                  initialValue: data.mUser.phonenumber,
                  onSaved: (newValue) => phone = newValue,
                ),
                SizedBox(height: 10),
                ReuseTextField(
                  labelText: _lang.translate('email'),
                  initialValue: data.mUser.email,
                  inputType: TextInputType.emailAddress,
                  onSaved: (newValue) => email = newValue,
                ),
                SizedBox(
                  height: 10,
                ),
                ReuseTextField(
                  labelText: _lang.translate('shipping_address'),
                  initialValue: data.mUser.address,
                  validator: (value) =>
                      value.isEmpty ? "Address is empty" : null,
                  onSaved: (newValue) => location = newValue,
                ),
                SizedBox(
                  height: 40,
                ),
                ReuseButton.getItem('Save', () {
                  validateAndSubmit();
                  if (location != null) {
                    Navigator.pop(context);
                    data.setLocation(location);
                  }
                }, context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
