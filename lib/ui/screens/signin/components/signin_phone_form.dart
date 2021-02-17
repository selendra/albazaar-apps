import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/sign_in_m.dart';

class SignInPhoneForm extends StatelessWidget {

  final Function signInPhoneFunc;
  final Function facebookSignIn;
  final Function googleSignIn;
  final SignInModel signInModel;
  final Function onChanged;
  final Function onSubmit;

  SignInPhoneForm({
    this.signInPhoneFunc, 
    this.facebookSignIn, 
    this.googleSignIn,
    this.signInModel,
    this.onChanged,
    this.onSubmit
  });

  void validateAndSubmit() {
    signInPhoneFunc(signInModel.phone.text, signInModel.password.text);
    signInModel.phone.text = '';
    signInModel.password.text = '';
    // if (_phoneFormKey.currentState.validate()) {
    //   // _phoneFormKey.currentState.save();
    // }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Container(
            padding: EdgeInsets.only(left: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IntlPhoneField(
              // controller: signInModel.phone,
              // focusNode: signInModel.phoneNode,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 14),
                labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                labelText: AppLocalizeService.of(context).translate('phone_hint'),
                enabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(  
                  borderSide: BorderSide(color: Colors.greenAccent),
                  borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))
                ),
              ),
              initialCountryCode: 'KH',
              countryCodeTextColor: Colors.black,
              validator: (value) => value.isEmpty ? 'Phone is Empty' : null,
              // onSaved: (phone) => signInModel.phone = phone.completeNumber.toString(),
            )
          )
        ),
        
        MyInputField(
          labelText: "Password",
          controller: signInModel.password, 
          focusNode: signInModel.passwordNode, 
          textInputFormatter: [
            LengthLimitingTextInputFormatter(TextField.noMaxLength)
          ],
          validateField: (String value) {

          }, 
          onChanged: onChanged, 
          onSubmit: onSubmit,
        )

      ],
    );
  }

  Widget _buildBtnSocialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BtnSocial(() {
          facebookSignIn();
        }, 'images/facebook.svg'),
        SizedBox(width: 20),
        BtnSocial(() {
          googleSignIn();
        }, 'images/google.svg'),
      ],
    );
  }
}
