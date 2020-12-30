import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/all_export.dart';

TextEditingController _phoneNumber = TextEditingController(),
    _password = TextEditingController();

class SignInPhoneForm extends StatelessWidget {
  final Function signInPhoneFunc;
  final Function facebookSignIn;
  final Function googleSignIn;

  SignInPhoneForm(this.signInPhoneFunc, this.facebookSignIn, this.googleSignIn);

  final _phoneFormKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    signInPhoneFunc(_phoneNumber.text, _password.text);
    _phoneNumber.text = '';
    _password.text = '';
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Container(
      //width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.all(20),
      child: Form(
        key: _phoneFormKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: IntlPhoneField(
                controller: _phoneNumber,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
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
                validator: (value) => value.isEmpty ? 'Phone is Empty' : null,
                // onSaved: (phone) => _phoneNumber = phone.completeNumber.toString(),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              //width: 150,
              child: ReusePwField(
                controller: _password,
                labelText: _lang.translate('password'),
                validator: (value) => value.isEmpty || value.length < 6
                    ? _lang.translate('password_is_empty')
                    : null,
                // onSaved: (value) => _password = value,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, RouteAnimation(enterPage: ResetPassPhone()));
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
            SizedBox(height: 24),
            ReuseButton.getItem(_lang.translate('signin_string'), () {
              validateAndSubmit();
            }, context),
            SizedBox(height: 10),
            ReuseFlatButton.getItem(_lang.translate('haven\'t_had_account'),
                AppLocalizeService.of(context).translate('signup_string'), () {
              Navigator.pushReplacementNamed(context, SignUpView);
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => SignUpScreen()));
            }),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                _lang.translate('or_string'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
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
