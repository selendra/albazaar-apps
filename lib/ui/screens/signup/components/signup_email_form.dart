import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/sign_up_m.dart';

String _email, _password, _confirmPassword;

class SignUpEmailForm extends StatelessWidget {

  final Function signUpEmailFunc;
  final Function faceBookSignUp;
  final Function googleSignUp;
  final SignUpModel signUpModel;
  final Function onChanged;
  final Function onSubmit;

  SignUpEmailForm({
    this.signUpEmailFunc, 
    this.faceBookSignUp, 
    this.googleSignUp,
    this.signUpModel,
    this.onChanged,
    this.onSubmit
  });

  void validateAndSubmit() {
    if (signUpModel.emailFormKey.currentState.validate()) {
      signUpModel.emailFormKey.currentState.save();
      signUpEmailFunc(_email, _password, _confirmPassword);
      signUpModel.email.text = '';
      signUpModel.password.text = '';
      signUpModel.confirmPassword.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: signUpModel.emailFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ReuseTextField(
              controller: signUpModel.email,
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
              controller: signUpModel.password,
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
              controller: signUpModel.confirmPassword,
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
            Expanded(
              child: _buildBtnSocialRow()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBtnSocialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BtnSocial(() {
          faceBookSignUp();
        }, 'images/facebook.svg'),
        SizedBox(width: 20),
        BtnSocial(() {
          googleSignUp();
        }, 'images/google.svg'),
      ],
    );
  }
}
