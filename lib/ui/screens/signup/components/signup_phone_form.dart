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
    var _lang = AppLocalizeService.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _phoneFormKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: IntlPhoneField(
                decoration: InputDecoration(
                  labelText:
                      AppLocalizeService.of(context).translate('phone_hint'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kDefaultColor),
                    borderRadius:
                        BorderRadius.all(Radius.circular(kDefaultRadius)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                      borderRadius:
                          BorderRadius.all(Radius.circular(kDefaultRadius))),
                ),
                initialCountryCode: 'KH',
                validator: (value) =>
                    value.isEmpty ? _lang.translate('phone_is_empty') : null,
                onChanged: (phone) {
                  print(phone.completeNumber);
                  _phone = phone.completeNumber.toString();
                },
              ),
            ),
            SizedBox(
              height: 10,
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
            SizedBox(height: 10),
            ReuseFlatButton.getItem(_lang.translate('had_an_account'),
                _lang.translate('signin_string'), () {
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
