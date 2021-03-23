import 'package:albazaar_app/core/components/countries.dart';
import 'package:albazaar_app/core/components/search.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:albazaar_app/core/components/component.dart';
import 'package:albazaar_app/core/constants/constants.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/sign_in_m.dart';

class SignInPhoneForm extends StatelessWidget {

  final SignInModel signInModel;
  final Function validateInput;
  final Function validatePassword;
  final Function onChangedCountryCode;
  final Function onChanged;
  final Function onSubmit;

  SignInPhoneForm({
    this.signInModel,
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
      controller: signInModel.phone, 
      focusNode: signInModel.phoneNode,
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
                text: "${signInModel.countryCode}"
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
}
