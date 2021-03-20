import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:albazaar_app/core/constants/constants.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/sign_in_m.dart';

class SignInEmailForm extends StatelessWidget {

  final Function signInEmailFunc;
  final SignInModel signInModel;
  final Function validateInput;
  final Function validatePassword;
  final Function onChanged;
  final Function onSubmit;

  SignInEmailForm({
    this.signInEmailFunc, 
    this.signInModel,
    this.validateInput,
    this.validatePassword,
    this.onChanged,
    this.onSubmit
  });

  void validateAndSubmit() {
    if (signInModel.formKey.currentState.validate()) {
      signInModel.formKey.currentState.save();
      signInEmailFunc(signInModel.email.text, signInModel.password.text);
      signInModel.email.text = '';
      signInModel.password.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return MyInputField(
      pRight: 5, pLeft: 5, pTop: 5,
      labelText: "Email",
      controller: signInModel.email, 
      focusNode: signInModel.emailNode, 
      textInputFormatter: [
        LengthLimitingTextInputFormatter(TextField.noMaxLength)
      ],
      validateField: validateInput, 
      onChanged: onChanged, 
      onSubmit: onSubmit,
    );
  }

  // Widget _buildBtnSocialRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       BtnSocial(() {
  //         facebookSignIn();
  //       }, 'assets/facebook.svg'),
  //       SizedBox(width: 20),
  //       BtnSocial(() {
  //         googleSignIn();
  //       }, 'assets/google.svg'),
  //     ],
  //   );
  // }
}
