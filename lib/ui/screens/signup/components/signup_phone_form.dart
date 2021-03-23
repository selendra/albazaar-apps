import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/sign_up_m.dart';

// String _phone, _password, _confirmPassword;

class SignUpPhoneForm extends StatelessWidget {

  final SignUpModel signUpModel;
  final Function validateInput;
  final Function validatePassword;
  final Function onChangedCountryCode;
  final Function onChanged;
  final Function onSubmit;

  SignUpPhoneForm({
    this.signUpModel,
    this.validateInput,
    this.validatePassword,
    this.onChangedCountryCode,
    this.onChanged,
    this.onSubmit
  });

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return MyInputField(
      pRight: 5, pLeft: 5, pTop: 5,
      labelText: "Phone",
      controller: signUpModel.phone, 
      focusNode: signUpModel.phoneNode,
      inputType: TextInputType.phone,
      textInputFormatter: [
        LengthLimitingTextInputFormatter(TextField.noMaxLength),
        FilteringTextInputFormatter.digitsOnly
      ],
      validateField: validateInput,
      icon: GestureDetector(
        onTapDown: (TapDownDetails details) async {
          final query = await showSearch(context: context, delegate: DataSearch());
          onChangedCountryCode(query);
        },
        child: Padding(
          padding: EdgeInsets.only(right: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(
                text: "${signUpModel.countryCode}"
              ),

              Icon(Icons.arrow_drop_down, color: Colors.black,)                   
            ],
          )
        )
      ),
      onChanged: onChanged, 
      onSubmit: onSubmit,
    );
  }

  // Widget _buildBtnSocialRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       BtnSocial(() {
  //         facebookSignUp();
  //       }, 'assets/facebook.svg'),
  //       SizedBox(width: 20),
  //       BtnSocial(() {
  //         googleSignUp();
  //       }, 'assets/google.svg'),
  //     ],
  //   );
  // }
}
