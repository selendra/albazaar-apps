import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ResetPassPhone extends StatefulWidget {
  @override
  _ResetPassPhoneState createState() => _ResetPassPhoneState();
}

class _ResetPassPhoneState extends State<ResetPassPhone> {
  final _formKey = GlobalKey<FormState>();

  String _phone;
  bool _isLoading = false;

  void validateAndSubmit(context) async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_phone != null) {

        await AuthProvider().forgetPasswordByPhone(_phone).then((value) {
          setState(() {
            _isLoading = false;
          });
          if (value != 'Your phone number does not exist!') {
            Navigator.pop(context);
            Navigator.push(
                context, RouteAnimation(enterPage: ResetPhoneForm(_phone)));
          } else {
            ReuseAlertDialog().successDialog(context, value);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kDefaultColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: kDefaultColor,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reset Password', style: titleTextStyle),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(resetPassText),
                      SizedBox(
                        height: 20.0,
                      ),
                      _phoneCodePick(context),
                      SizedBox(
                        height: 30.0,
                      ),
                      ReuseButton.getItem('Send', () {
                        validateAndSubmit(context);
                      }, context),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _phoneCodePick(context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.grey),
        labelText: AppLocalizeService.of(context).translate('phone_hint'),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kDefaultColor),
          borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent),
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))),
      ),
      initialCountryCode: 'KH',
      validator: (value) => value.isEmpty ? 'Phone is Empty' : null,
      onSaved: (phone) => _phone = phone.completeNumber.toString(),
    );
  }
}
