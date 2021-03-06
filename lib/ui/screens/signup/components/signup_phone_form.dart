import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:albazaar_app/core/models/sign_up_m.dart';

String _phone, _password, _confirmPassword;

class SignUpPhoneForm extends StatelessWidget {

  final Function signUpPhoneFunc;
  final Function facebookSignUp;
  final Function googleSignUp;
  final SignUpModel signUpModel;
  final Function onChanged;
  final Function onSubmit;

  SignUpPhoneForm({
    this.signUpPhoneFunc, 
    this.facebookSignUp, 
    this.googleSignUp,
    this.signUpModel,
    this.onChanged,
    this.onSubmit
  });

  void validateAndSubmit() async {
    // if (_phoneFormKey.currentState.validate()) {
    //   _phoneFormKey.currentState.save();
    //   await signUpPhoneFunc(_phone, _password, _confirmPassword);

    //   _phoneController.text = '';
    //   _passwordController.text = '';
    //   _conpassController.text = '';
    // }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Form(
      key: signUpModel.phoneFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [

          // Padding(
          //   padding: EdgeInsets.only(bottom: 16),
          //   child: Container(
          //     padding: EdgeInsets.only(left: 11),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(12),
          //       // boxShadow: [
          //       //   BoxShadow(
          //       //     color: Colors.black.withOpacity(0.2),
          //       //     blurRadius: 3,
          //       //     spreadRadius: 0.5,
          //       //     offset: Offset(0, 1)
          //       //   )
          //       // ]
          //     ),
          //     child: IntlPhoneField(
          //       controller: signUpModel.phone,
          //       decoration: InputDecoration(
          //         contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          //         labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
          //         labelText: AppLocalizeService.of(context).translate('phone_hint'),
          //         enabledBorder: InputBorder.none,
          //         focusedBorder: OutlineInputBorder(  
          //           borderSide: BorderSide(color: Colors.greenAccent),
          //           borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))
          //         ),
          //       ),
          //       initialCountryCode: 'KH',
          //       countryCodeTextColor: Colors.grey,
          //       validator: (value) => value.isEmpty ? 'Phone is Empty' : null,
          //       // onSaved: (phone) => signInModel.phone = phone.completeNumber.toString(),
          //     )
          //   )
          // ),
          MyInputField(
            pRight: 5, pLeft: 5, pTop: 5,
            pBottom: 11,
            labelText: "Phone",
            controller: signUpModel.phone, 
            focusNode: signUpModel.phoneNode,
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
            pBottom: 11,
            labelText: "Password",
            controller: signUpModel.password, 
            focusNode: signUpModel.passwordNode, 
            validateField: (String value) {

            }, 
            onChanged: onChanged, 
            onSubmit: onSubmit,
          ),

          MyInputField(
            pRight: 5, pLeft: 5, pTop: 5,
            labelText: "Confirm Password",
            controller: signUpModel.confirmPassword, 
            focusNode: signUpModel.confirmPasswordNode, 
            validateField: (String value) {

            }, 
            onChanged: onChanged, 
            onSubmit: onSubmit,
          )

        ],
      ),
    );
  }

  // Widget _buildBtnSocialRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       BtnSocial(() {
  //         facebookSignIn();
  //       }, 'images/facebook.svg'),
  //       SizedBox(width: 20),
  //       BtnSocial(() {
  //         googleSignIn();
  //       }, 'images/google.svg'),
  //     ],
  //   );
  // }
}
