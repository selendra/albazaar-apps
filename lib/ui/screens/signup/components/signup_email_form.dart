import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/sign_up_m.dart';

String _email, _password, _confirmPassword;

class SignUpEmailForm extends StatelessWidget {

  
  final Function signUpEmailFunc;
  final SignUpModel signUpModel;
  final Function validateInput;
  final Function validatePassword;
  final Function onChanged;
  final Function onSubmit;

  SignUpEmailForm({
    this.signUpEmailFunc,
    this.signUpModel,
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
      pBottom: 11,
      labelText: "Email",
      controller: signUpModel.email, 
      focusNode: signUpModel.emailNode, 
      textInputFormatter: [
        LengthLimitingTextInputFormatter(TextField.noMaxLength)
      ],
      validateField: (String value) {

      }, 
      onChanged: onChanged, 
      onSubmit: onSubmit,
    );
  }
}
