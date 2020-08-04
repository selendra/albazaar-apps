import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/screens/signin/signin.dart';
import 'package:selendra_marketplace_app/screens/signup/signup_phonenumber.dart';
import 'package:selendra_marketplace_app/services/auth/auth_services.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_button.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_flat_button.dart';
import 'package:selendra_marketplace_app/services/auth/api_post_services.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_pw_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final formKey = GlobalKey<FormState>();
  String _email, _password;
  String phone;
  bool _isLoading = false;
  String alertText;

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

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(alertText),
      content: Text("Please check your email or verify email. "),
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

  onSignUpByEmail() async {
    await ApiPostServices().signUpByEmail(_email, _password).then((value) {
      setState(() {
        _isLoading = false;
      });
      alertText = value;
      showAlertDialog(context);
    });
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      print(_email);
      print(_password);
      onSignUpByEmail();
    }
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
    await signInFacebook(context).then((value) {
      if (value == null) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      SizedBox(
                        height: 10,
                      ),
                      _emailField(),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _reusePwField(),
                      SizedBox(
                        height: 40,
                      ),
                      ReuseButton.getItem('SIGN UP', () {
                        setState(() {
                          _isLoading = true;
                        });
                        validateAndSubmit();
                      }, context),
                      ReuseFlatButton.getItem(
                          'Already Had an Account?',' Sign In', () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ));
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
                        height: 10,
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
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Email',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          prefixIcon: Icon(
            Icons.email,
            color: kDefualtColor,
          ),
        ),
        validator: (value) => value.isEmpty ? "Empty email" : null,
        onSaved: (value) => _email = value,
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

  Widget _btnSocial(Function onTap, AssetImage logo) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
              image: logo,
            ),
          ),
        ));
  }

  Widget _buildBtnSocialRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _btnSocial(
            () {
              setState(() {
                _isLoading = true;
              });
              onFacebookSignIn();
            },
            AssetImage('images/facebook.jpg'),
          ),
          SizedBox(width: 20),
          _btnSocial(
            () {
              setState(() {
                _isLoading = true;
              });
              onGoogleSignIn();
            },
            AssetImage('images/google.jpg'),
          ),
          SizedBox(width: 20),
          _btnSocial(
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPhoneNumber()));
            },
            AssetImage('images/phone.jpg'),
          ),
        ],
      ),
    );
  }
}
