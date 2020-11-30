import 'package:flutter/material.dart';

import 'package:selendra_marketplace_app/all_export.dart';

class ResetByEmail extends StatefulWidget {
  @override
  _ResetByEmailState createState() => _ResetByEmailState();
}

class _ResetByEmailState extends State<ResetByEmail> {
  String alertText, title, _email;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  void validateAndSubmit(context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _forgetByEmail(_email, context);
    }
  }

  void _forgetByEmail(String _email, context) async {
    setState(() {
      _isLoading = true;
    });
    await AuthProvider().forgetPasswordByEmail(_email).then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
      Navigator.push(
          context, RouteAnimation(enterPage: ReuseResetForm(_email)));
    });
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
                      ReuseTextField(
                        labelText: 'Email Address',
                        inputType: TextInputType.emailAddress,
                        validator: (value) =>
                            value.isEmpty ? 'Email cannot be empty' : null,
                        onSaved: (newValue) {
                          //print(newValue);
                          _email = newValue;
                        },
                      ),
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
}
