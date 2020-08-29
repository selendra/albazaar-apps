import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

String _email, _password;

class SignUpEmailForm extends StatelessWidget {
  final Function signUpEmailFunc;
  final Function facebookLogin;
  final Function googleLogin;

  SignUpEmailForm(this.signUpEmailFunc, this.facebookLogin, this.googleLogin);

  final _emailFormKey = GlobalKey<FormState>();
  void validateAndSubmit() {
    if (_emailFormKey.currentState.validate()) {
      _emailFormKey.currentState.save();
      print(_email);
      print(_password);
      signUpEmailFunc(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _emailFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _emailField(),
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
            SizedBox(
              height: 10,
            ),
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

  Widget _emailField() {
    return ReuseTextField(
      labelText: 'Email',
      inputType: TextInputType.emailAddress,
      onSaved: (value) => _email = value,
      validator: (value) => value.isEmpty ? "Email is empty" : null,
    );
  }

  Widget _pwField() {
    return ReusePwField(
      labelText: 'Password',
      validator: (value) => value.isEmpty || value.length < 6
          ? 'Password is empty or less then 6 character'
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
            facebookLogin();
          }, AssetImage('images/facebook.jpg')),
          SizedBox(width: 20),
          BtnSocial(() {
            googleLogin();
          }, AssetImage('images/google.jpg')),
        ],
      ),
    );
  }
}
