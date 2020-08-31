import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/all_export.dart';

String _phoneNumber, _password;

class SignInPhoneForm extends StatelessWidget {
  final Function signInPhoneFunc;
  final Function facebookSignIn;
  final Function googleSignIn;

  SignInPhoneForm(this.signInPhoneFunc, this.facebookSignIn, this.googleSignIn);

  final _phoneFormKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_phoneFormKey.currentState.validate()) {
      _phoneFormKey.currentState.save();
      print(_phoneNumber);
      print(_password);
      signInPhoneFunc(_phoneNumber, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _phoneFormKey,
        child: Column(
          children: [
            _phoneCodePick(),
            SizedBox(
              height: 10,
            ),
            _pwField(),
            _btntoForgetPass(),
            SizedBox(
              height: 10,
            ),
            ReuseButton.getItem('SIGN IN', () {
              validateAndSubmit();
            }, context),
            SizedBox(height: 10),
            ReuseFlatButton.getItem('Haven\'t Had an Account?', ' Sign Up', () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            }),
            SizedBox(
              height: 5,
            ),
            Text(
              'OR',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            _buildBtnSocialRow()
          ],
        ),
      ),
    );
  }

  Widget _phoneCodePick() {
    return IntlPhoneField(
      decoration: kDefualtPInputDecoration,
      initialCountryCode: 'KH',
      validator: (value) => value.isEmpty ? 'Phone is Empty' : null,
      onSaved: (phone) => _phoneNumber = phone.completeNumber.toString(),
    );
  }

  Widget _pwField() {
    return ReusePwField(
      labelText: 'Password',
      validator: (value) => value.isEmpty || value.length < 6
          ? 'Password is empty or less than 6 character'
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

  Widget _btntoForgetPass() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {},
        child: RichText(
          text: TextSpan(
            text: 'Forget Password?',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
