import 'package:flutter/material.dart';
import 'package:albazaar_app/core/constants/constants.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/sign_in_m.dart';

class SignInEmailForm extends StatelessWidget {

  final SignInModel signInModel;
  final Function validateInput;
  final Function validatePassword;
  final Function onChanged;
  final Function onSubmit;

  SignInEmailForm({
    this.signInModel,
    this.validateInput,
    this.validatePassword,
    this.onChanged,
    this.onSubmit
  });

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
