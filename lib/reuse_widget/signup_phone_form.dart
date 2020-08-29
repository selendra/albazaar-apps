import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

String _phone, _password;

class SignUpPhoneForm extends StatelessWidget {
  final Function signInPhoneFunc;
  final Function facebookSignIn;
  final Function googleSignIn;

  SignUpPhoneForm(this.signInPhoneFunc, this.facebookSignIn, this.googleSignIn);

  final _phoneFormKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_phoneFormKey.currentState.validate()) {
      _phoneFormKey.currentState.save();
      print(_phone);
      print(_password);
      signInPhoneFunc(_phone, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _phoneFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _phoneCodePick(),
            SizedBox(
              height: 20,
            ),
            _pwField(),
            SizedBox(
              height: 40,
            ),
            ReuseButton.getItem('SIGN UP', () {
              validateAndSubmit();
            }, context),
            SizedBox(height: 10),
            ReuseFlatButton.getItem('Already Had an Account?', ' Sign In', () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ));
            }),
            SizedBox(
              height: 10,
            ),
            Text(
              'OR',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            _buildBtnSocialRow(),
          ],
        ),
      ),
    );
  }

  Widget _phoneCodePick() {
    return Container(
      child: IntlPhoneField(
        decoration: kDefualtPInputDecoration,
        initialCountryCode: 'KH',
        validator: (value) => value.isEmpty ? "Phone Number is empty" : null,
        onChanged: (phone) {
          print(phone.completeNumber);
          _phone = phone.completeNumber.toString();
        },
      ),
    );
  }

  Widget _pwField() {
    return ReusePwField(
      labelText: 'Password',
      validator: (value) => value.isEmpty || value.length < 6
          ? "Password is empty or less than 6 character"
          : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget _buildBtnSocialRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BtnSocial(() {
            facebookSignIn();
          }, AssetImage('images/facebook.jpg')),
          SizedBox(width: 20),
          BtnSocial(() {
            googleSignIn();
          }, AssetImage('images/google.jpg')),
        ],
      ),
    );
  }
}
