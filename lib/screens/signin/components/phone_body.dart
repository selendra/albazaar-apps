import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _countryCode = 'KH';
  String _phone;
  bool isLogined = false;
  final formKey = GlobalKey<FormState>();
  String _password;
  bool _isLoading = false;
  String alertText;
  TextEditingController _textEditingController;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(alertText),
      content: Text("Please check again"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showResetAlertDialog(BuildContext context) {
    // set up the button
    Widget _okButton = FlatButton(
      child: Text("Reset"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassPhone()));
      },
    );
    Widget _cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(alertText),
      content: Text("Please check your email. "),
      actions: [
        _cancelButton,
        _okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onSignInByPhone() async {
    await ApiPostServices()
        .signInByPhone(_phone, _password, context)
        .then((value) {
      if (value == null) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        alertText = value;
        showAlertDialog(context);
      }
    });
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      onSignInByPhone();
    }
  }

  onForgetPwPhone() async {
    await ApiPostServices().forgetPasswordByPhone(_phone).then((value) {
      alertText = value;
      showResetAlertDialog(context);
    });
  }

  void forgetPassword(String phoneNumber) async {
    String apiUrl = 'https://testnet-api.selendra.com/pub/v1/forget-password';
    var response = await http.post(apiUrl,
        headers: <String, String>{
          "accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{'phone': '+855' + phoneNumber}));
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      alertText = responseBody['message'];
      showResetAlertDialog(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: Image.asset(
                        'images/logo.png',
                        height: 100,
                        width: 100,
                      )),
                      SizedBox(
                        height: 50,
                      ),
                      _phoneCodePick(),
                      SizedBox(
                        height: 10,
                      ),
                      _reusePwField(),
                      _btntoForgetPass(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      ReuseButton.getItem('SIGN IN', () {
                        setState(() {
                          _isLoading = true;
                        });
                        validateAndSubmit();
                      }, context)
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _phoneCodePick() {
    return Container(
      child: IntlPhoneField(
        decoration: InputDecoration(
          labelText: 'Phone Number',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
        ),
        initialCountryCode: _countryCode,
        onChanged: (phone) {
          print(phone.completeNumber);
          _phone = phone.completeNumber.toString();
        },
      ),
    );
  }

  Widget _btntoForgetPass() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          _displayDialog(context);
        },
        child: RichText(
          text: TextSpan(
            text: 'Forget Password?',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget _reusePwField() {
    return ReusePwField(
      labelText: 'Password',
      validator: (value) => value.isEmpty || value.length < 6
          ? 'Password is empty or less than 6 character'
          : null,
      onSaved: (value) => _password = value,
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please input your Phone Number'),
            content: TextField(
              autofocus: true,
              keyboardType: TextInputType.phone,
              controller: _textEditingController,
              decoration: InputDecoration(hintText: "Phonenumber"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  _textEditingController.text = '';
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  forgetPassword(_textEditingController.text);
                  _textEditingController.text = '';
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
