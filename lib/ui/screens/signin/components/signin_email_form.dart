import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/sign_in_m.dart';

class SignInEmailForm extends StatelessWidget {

  final Function signInEmailFunc;
  final Function faceBookSignIn;
  final Function googleSignIn;
  final SignInModel signInModel;
  final Function onChanged;
  final Function onSubmit;

  SignInEmailForm({
    this.signInEmailFunc, 
    this.faceBookSignIn, 
    this.googleSignIn,
    this.signInModel,
    this.onChanged,
    this.onSubmit
  });

  void validateAndSubmit() {
    if (signInModel.emailFormKey.currentState.validate()) {
      signInModel.emailFormKey.currentState.save();
      signInEmailFunc(signInModel.email.text, signInModel.password.text);
      signInModel.email.text = '';
      signInModel.password.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Form(
      key: signInModel.phoneFormKey,
      child: Column(
        children: [
          MyInputField(
            pBottom: 16,
            labelText: "Email",
            controller: signInModel.email, 
            focusNode: signInModel.emailNode, 
            validateField: (String value) {

            }, 
            onChanged: onChanged, 
            onSubmit: onSubmit,
          ),
          
          MyInputField(
            labelText: "Password",
            controller: signInModel.password, 
            focusNode: signInModel.passwordNode, 
            validateField: (String value) {

            }, 
            onChanged: onChanged, 
            onSubmit: onSubmit,
          )

          // ReusePwField(
          //   controller: signInModel.password,
          //   labelText: _lang.translate('password'),
          //   validator: (value) => value.isEmpty || value.length < 6
          //       ? _lang.translate('password_is_empty')
          //       : null,
          //   // onSaved: (value) => signInModel.password = value,
          // ),
          // Container(
          //   alignment: Alignment.centerRight,
          //   child: FlatButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context, RouteAnimation(enterPage: ResetPassPhone()));
          //     },
          //     child: RichText(
          //       text: TextSpan(
          //         text: _lang.translate('forgetsignInModel.password'),
          //         style: TextStyle(
          //           color: Colors.red,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // ReuseButton.getItem(_lang.translate('signin_string'), () {
          //   validateAndSubmit();
          // }, context),
          // SizedBox(height: 10),
          // ReuseFlatButton.getItem(_lang.translate('haven\'t_had_account'),
          //     AppLocalizeService.of(context).translate('signup_string'), () {
          //   Navigator.pushReplacementNamed(context, SignUpView);
          //   // Navigator.pushReplacement(context,
          //   //     MaterialPageRoute(builder: (context) => SignUpScreen()));
          // }),
          // SizedBox(
          //   height: 5,
          // ),
          // Text(
          //   _lang.translate('or_string'),
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Expanded(
          //   child: _buildBtnSocialRow()
          // )

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

// class SignInEmailForm extends StatelessWidget {
//   final Function signInEmailFunc;
//   final Function faceBookSignIn;
//   final Function googleSignIn;
//   final SignInModel signInModel;
//   final Function onChanged;
//   final Function onSubmit;

//   SignInEmailForm({
//     this.signInEmailFunc, 
//     this.faceBookSignIn, 
//     this.googleSignIn,
//     this.signInModel,
//     this.onChanged,
//     this.onSubmit
//   });

//   void validateAndSubmit() {
//     if (signInModel.emailFormKey.currentState.validate()) {
//       signInModel.emailFormKey.currentState.save();
//       signInEmailFunc(_email, _password);
//       signInModel.email.text = '';
//       signInModel.password.text = '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _lang = AppLocalizeService.of(context);
//     return Container(
//       margin: EdgeInsets.all(20.0),
//       child: Form(
//         key: signInModel.emailFormKey,
//         child: Column(
//           children: [
//             // ReuseTextField(
//             //   controller: signInModel.email,
//             //   labelText: _lang.translate('email'),
//             //   inputType: TextInputType.emailAddress,
//             //   onSaved: (value) => _email = value,
//             //   validator: (value) =>
//             //       value.isEmpty ? _lang.translate('email_is_empty') : null,
//             // ),
//             // SizedBox(
//             //   height: 20,
//             // ),
//             ReusePwField(
//               controller: signInModel.password,
//               labelText: _lang.translate('password'),
//               validator: (value) => value.isEmpty || value.length < 6
//                   ? _lang.translate('password_is_empty')
//                   : null,
//               onSaved: (value) => _password = value,
//             ),
//             Container(
//               alignment: Alignment.centerRight,
//               child: FlatButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context, RouteAnimation(enterPage: ResetByEmail()));
//                 },
//                 child: RichText(
//                   text: TextSpan(
//                     text: _lang.translate('forget_password'),
//                     style: TextStyle(
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ReuseButton.getItem(_lang.translate('signin_string'), () {
//               validateAndSubmit();
//             }, context),
//             SizedBox(height: 10),
//             ReuseFlatButton.getItem(_lang.translate('haven\'t_had_account'),
//                 AppLocalizeService.of(context).translate('signup_string'), () {
//               Navigator.pushReplacementNamed(context, SignUpView);
//             }),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               _lang.translate('or_string'),
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Expanded(
//               child: _buildBtnSocialRow()
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBtnSocialRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         BtnSocial(() {
//           faceBookSignIn();
//         }, 'images/facebook.svg'),
//         SizedBox(width: 20),
//         BtnSocial(() {
//           googleSignIn();
//         }, 'images/google.svg'),
//       ],
//     );
//   }
// }
