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
    return Form(
      // key: signUpModel.phoneFormKey,
      child: Column(
        children: [

          MyInputField(
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
          ),
          
          MyInputField(
            pRight: 5, pLeft: 5, pTop: 5,
            pBottom: 11,
            labelText: "Password",
            controller: signUpModel.password, 
            focusNode: signUpModel.passwordNode, 
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
}
