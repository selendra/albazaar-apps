import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:selendra_marketplace_app/core/components/component.dart';
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

        
        // Padding(
        //   padding: paddingScaffold(pTop: 5, pBottom: 5),
        //   child: Stack(
        //     children: [

        //       // Padding(
        //       //   child: 
        //       //   Container(
        //       //     decoration: BoxDecoration(
        //       //       color: Colors.white,
        //       //       borderRadius: BorderRadius.circular(12),
        //       //     ),
        //       //     height: 65,
        //       //   ),
        //       // // ),

        //       // // Padding(
        //       // //   padding: EdgeInsets.only(top: 5, left: 16, right: 5, bottom: 11),
        //       //   // child: 
        //       //   Container(
        //       //     child: IntlPhoneField(
        //       //     decoration: InputDecoration(),
        //       //     // controller: signInModel.phone,
        //       //     // focusNode: signInModel.phoneNode,
        //       //     enabled: false,
        //       //     // decoration: InputDecoration(
        //       //     //   // contentPadding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        //       //     //   // labelStyle: TextStyle(color: Colors.transparent, fontSize: 18),
        //       //     //   labelText: AppLocalizeService.of(context).translate('phone_hint'),
        //       //     //   enabledBorder: InputBorder.none,
        //       //     //   focusedBorder: OutlineInputBorder(  
        //       //     //     borderSide: BorderSide(color: Colors.greenAccent),
        //       //     //     borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))
        //       //     //   ),
        //       //     // ),
        //       //     initialCountryCode: 'KH',
        //       //     countryCodeTextColor: Colors.black,
        //       //     // validator: (value) => value.isEmpty ? 'Phone is Empty' : null,
        //       //     // onSaved: (phone) => signInModel.phone = phone.completeNumber.toString(),
        //       //   )
        //       //   )
        //       // )
        //     ],
        //   )
        // ),

        MyInputField(
          pRight: 5, pLeft: 5, pTop: 5,
          pBottom: 11,
          labelText: "Phone",
          controller: signInModel.phone, 
          focusNode: signInModel.phoneNode,
          inputType: TextInputType.phone,
          textInputFormatter: [
            LengthLimitingTextInputFormatter(TextField.noMaxLength)
          ],
          validateField: (String value) {

          }, 
          onChanged: onChanged, 
          onSubmit: onSubmit,
        ),
        
        MyInputField(
          pRight: 5, pLeft: 5, pTop: 5,
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
