import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

String _email, _password;

class SignInEmailForm extends StatelessWidget {
  final Function signInEmailFunc;
  final Function faceBookSignIn;
  final Function googleSignIn;

  SignInEmailForm(this.signInEmailFunc, this.faceBookSignIn, this.googleSignIn);

  final _emailFormKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_emailFormKey.currentState.validate()) {
      _emailFormKey.currentState.save();
      print(_email);
      print(_password);
      signInEmailFunc(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: _emailFormKey,
        child: Column(
          children: [
            ReuseTextField(
              labelText: AppLocalizeService.of(context).translate('email'),
              inputType: TextInputType.emailAddress,
              onSaved: (value) => _email = value,
              validator: (value) => value.isEmpty ? "Email is empty " : null,
            ),
            SizedBox(
              height: 20,
            ),
            ReusePwField(
              labelText: AppLocalizeService.of(context).translate('password'),
              validator: (value) => value.isEmpty || value.length < 6
                  ? 'Password is empty or less than 6 character'
                  : null,
              onSaved: (value) => _password = value,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizeService.of(context)
                        .translate('forget_password'),
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ReuseButton.getItem(
                AppLocalizeService.of(context).translate('signin_string'), () {
              validateAndSubmit();
            }, context),
            SizedBox(height: 10),
            ReuseFlatButton.getItem(
                AppLocalizeService.of(context)
                    .translate('haven\'t_had_account'),
                AppLocalizeService.of(context).translate('signup_string'), () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            }),
            SizedBox(
              height: 5,
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
            faceBookSignIn();
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
