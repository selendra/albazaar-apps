import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:selendra_marketplace_app/all_export.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLogined = false;
  final formKey = GlobalKey<FormState>();
  final _pwKey = GlobalKey<FormFieldState<String>>();
  final _emailKey = GlobalKey<FormFieldState<String>>();
  String _email, _password, alertText;

  bool _isLoading = false;
  TextEditingController _textFieldController;

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
      content: Text("Please check your email. "),
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

  onGoogleSignIn() async {
    try {
      await signInWithGoogle().then((value) {
        if (value == null) {
          Navigator.pop(context);
        } else {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BottomNavigation()));
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
    //signInWithGoogle().whenComplete(() => ));
  }

  onFacebookSignIn() async {
    try {
      await signInFacebook(context).then((value) {
        if (value == null) {
          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BottomNavigation()));
        }
      });
    } on PlatformException catch (e) {
      print(e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  onApiSignInByEmail() async {
    await ApiPostServices()
        .signInByEmail(_email, _password, context)
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

  onForgetPwEmail(String email) async {
    await ApiPostServices().forgetPasswordByEmail(email).then((value) {
      if (value == 'Your Email doesn\'t exist') {
        alertText = value;
        showAlertDialog(context);
      } else {
        showResetAlertDialog(context);
      }
    });
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      onApiSignInByEmail();
    }
  }

  showResetAlertDialog(BuildContext context) {
    // set up the button
    Widget _okButton = FlatButton(
      child: Text("Reset"),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ResetByEmail(_email)));
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

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: Image.asset(
                        'images/logo.png',
                        height: 100,
                        width: 100,
                      )),
                      SizedBox(
                        height: 50,
                      ),
                      _emailField(),
                      SizedBox(
                        height: 20,
                      ),
                      _reusePwField(),
                      _btntoForgetPass(),
                      SizedBox(
                        height: 20,
                      ),
                      ReuseButton.getItem('SIGN IN', () {
                        setState(() {
                          _isLoading = true;
                        });
                        validateAndSubmit();
                      }, context),
                      SizedBox(
                        height: 10,
                      ),
                      ReuseFlatButton.getItem(
                          'Haven\'t Had an Account?', ' Sign Up', () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _buildBtnSocialRow()
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _emailField() {
    return ReuseTextField(
      labelText: 'Email',
      fieldKey: _emailKey,
      inputType: TextInputType.emailAddress,
      onSaved: (value) => _email = value,
      validator: (value) => value.isEmpty ? "Email is empty " : null,
    );
  }

  Widget _reusePwField() {
    return ReusePwField(
      fieldKey: _pwKey,
      labelText: 'Password',
      validator: (value) => value.isEmpty || value.length < 6
          ? 'Password is empty or less than 6 character'
          : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget _buildBtnSocialRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BtnSocial(() {
            setState(() {
              _isLoading = true;
            });
            onFacebookSignIn();
          }, AssetImage('images/facebook.jpg')),
          SizedBox(width: 20),
          BtnSocial(() {
            setState(() {
              _isLoading = true;
            });
            onGoogleSignIn();
          }, AssetImage('images/google.jpg')),
          SizedBox(width: 20),
          BtnSocial(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInPhoneNumber()));
          }, AssetImage('images/phone.jpg')),
        ],
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

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please input your email'),
            content: TextField(
              autofocus: true,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  _textFieldController.text = '';
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  onForgetPwEmail(_textFieldController.text);
                  _textFieldController.text = '';
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
