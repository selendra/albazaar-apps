import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

String _email, _password;

class SignInEmailForm extends StatelessWidget {
  final Function signInEmailFunc;
  final Function faceBookSignIn;
  final Function googleSignIn;

  SignInEmailForm(this.signInEmailFunc, this.faceBookSignIn, this.googleSignIn);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_emailFormKey.currentState.validate()) {
      _emailFormKey.currentState.save();
      signInEmailFunc(_email, _password);
      _emailController.text = '';
      _passwordController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: _emailFormKey,
        child: Column(
          children: [
            ReuseTextField(
              controller: _emailController,
              labelText: _lang.translate('email'),
              inputType: TextInputType.emailAddress,
              onSaved: (value) => _email = value,
              validator: (value) =>
                  value.isEmpty ? _lang.translate('email_is_empty') : null,
            ),
            SizedBox(
              height: 24,
            ),
            ReusePwField(
              controller: _passwordController,
              labelText: _lang.translate('password'),
              validator: (value) => value.isEmpty || value.length < 6
                  ? _lang.translate('password_is_empty')
                  : null,
              onSaved: (value) => _password = value,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, RouteAnimation(enterPage: ResetByEmail()));
                },
                child: RichText(
                  text: TextSpan(
                    text: _lang.translate('forget_password'),
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            ReuseButton.getItem(_lang.translate('signin_string'), () {
              validateAndSubmit();
            }, context),
            SizedBox(height: 10),
            ReuseFlatButton.getItem(_lang.translate('haven\'t_had_account'),
                AppLocalizeService.of(context).translate('signup_string'), () {
              Navigator.pushReplacementNamed(context, SignUpView);
            }),
            SizedBox(
              height: 5,
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
