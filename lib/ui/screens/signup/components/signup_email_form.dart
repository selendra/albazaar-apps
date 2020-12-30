import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

String _email, _password, _confirmPassword;

class SignUpEmailForm extends StatelessWidget {
  final Function signUpEmailFunc;
  final Function facebookLogin;
  final Function googleLogin;

  SignUpEmailForm(this.signUpEmailFunc, this.facebookLogin, this.googleLogin);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conpassController = TextEditingController();

  final _emailFormKey = GlobalKey<FormState>();

  //validate all required information then post to api to signup
  void validateAndSubmit() {
    if (_emailFormKey.currentState.validate()) {
      _emailFormKey.currentState.save();
      signUpEmailFunc(_email, _password, _confirmPassword);
      _emailController.text = '';
      _passwordController.text = '';
      _conpassController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _emailFormKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ReuseTextField(
                controller: _emailController,
                labelText: _lang.translate('email'),
                inputType: TextInputType.emailAddress,
                onSaved: (value) => _email = value,
                validator: (value) =>
                    value.isEmpty ? _lang.translate('email_is_empty') : null,
              ),
              SizedBox(
                height: 10,
              ),
              ReusePwField(
                controller: _passwordController,
                labelText: _lang.translate('password'),
                validator: (value) => value.isEmpty || value.length < 6
                    ? _lang.translate('password_is_empty')
                    : null,
                onSaved: (value) => _password = value,
              ),
              SizedBox(
                height: 10,
              ),
              ReusePwField(
                controller: _conpassController,
                labelText: _lang.translate('confirm_password'),
                validator: (value) => value.isEmpty || value.length < 6
                    ? _lang.translate('password_is_empty')
                    : null,
                onSaved: (value) => _confirmPassword = value,
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
