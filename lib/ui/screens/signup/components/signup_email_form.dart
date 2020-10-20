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
    var _lang = AppLocalizeService.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _emailFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ReuseTextField(
              labelText: _lang.translate('email'),
              inputType: TextInputType.emailAddress,
              onSaved: (value) => _email = value,
              validator: (value) =>
                  value.isEmpty ? _lang.translate('email_is_empty') : null,
            ),
            SizedBox(
              height: 20,
            ),
            ReusePwField(
              labelText: _lang.translate('password'),
              validator: (value) => value.isEmpty || value.length < 6
                  ? _lang.translate('password_is_empty')
                  : null,
              onSaved: (value) => _password = value,
            ),
            SizedBox(
              height: 40,
            ),
            ReuseButton.getItem(_lang.translate('signup_string'), () {
              validateAndSubmit();
            }, context),
            SizedBox(
              height: 10,
            ),
            ReuseFlatButton.getItem(_lang.translate('had_an_account'),
                _lang.translate('signin_string'), () {
              Navigator.pushReplacementNamed(context, SignInView);
            }),
            SizedBox(
              height: 10,
            ),
            Text(
              _lang.translate('or_string'),
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
