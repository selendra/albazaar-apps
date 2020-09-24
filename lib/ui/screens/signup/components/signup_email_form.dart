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
            ReuseTextField(
              labelText: AppLocalizeService.of(context).translate('email'),
              inputType: TextInputType.emailAddress,
              onSaved: (value) => _email = value,
              validator: (value) => value.isEmpty ? "Email is empty" : null,
            ),
            SizedBox(
              height: 20,
            ),
            ReusePwField(
              labelText: AppLocalizeService.of(context).translate('password'),
              validator: (value) => value.isEmpty || value.length < 6
                  ? 'Password is empty or less then 6 character'
                  : null,
              onSaved: (value) => _password = value,
            ),
            SizedBox(
              height: 40,
            ),
            ReuseButton.getItem(
                AppLocalizeService.of(context).translate('signup_string'), () {
              validateAndSubmit();
            }, context),
            SizedBox(
              height: 10,
            ),
            ReuseFlatButton.getItem(
                AppLocalizeService.of(context).translate('had_an_account'),
                AppLocalizeService.of(context).translate('signin_string'), () {
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
              AppLocalizeService.of(context).translate('or_string'),
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
