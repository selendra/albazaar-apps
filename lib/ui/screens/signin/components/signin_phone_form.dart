import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
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
    var _lang = AppLocalizeService.of(context);
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        key: _phoneFormKey,
        child: Column(
          children: [
            _phoneCodePick(context),
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
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {},
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
              height: 10,
            ),
            ReuseButton.getItem(_lang.translate('signin_string'), () {
              validateAndSubmit();
            }, context),
            SizedBox(height: 10),
            ReuseFlatButton.getItem(_lang.translate('haven\'t_had_account'),
                AppLocalizeService.of(context).translate('signup_string'), () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
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
            _buildBtnSocialRow()
          ],
        ),
      ),
    );
  }

  Widget _phoneCodePick(context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: AppLocalizeService.of(context).translate('phone_hint'),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kDefaultColor),
          borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
      ),
      initialCountryCode: 'KH',
      validator: (value) => value.isEmpty ? 'Phone is Empty' : null,
      onSaved: (phone) => _phoneNumber = phone.completeNumber.toString(),
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
