import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

String _email, _password;

class SignInEmailForm extends StatelessWidget {
  final Function signInEmailFunc;
  final Function faceBookSignIn;
  final Function googleSignIn;

  SignInEmailForm(this.signInEmailFunc, this.faceBookSignIn, this.googleSignIn);

  final _emailFormKey = GlobalKey<FormState>();

  void validateAndSubmit() {
    if (_emailFormKey.currentState.validate()) {
      _emailFormKey.currentState.save();
      print(_email);
      print(_password);
      signInEmailFunc(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: _emailFormKey,
        child: Column(
          children: [
            _emailField(),
            SizedBox(
              height: 20,
            ),
            _pwField(),
            _btntoForgetPass(),
            SizedBox(
              height: 10,
            ),
            ReuseButton.getItem('SIGN IN', () {
              validateAndSubmit();
            }, context),
            SizedBox(height: 10),
            ReuseFlatButton.getItem('Haven\'t Had an Account?', ' Sign Up', () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            }),
            SizedBox(
              height: 5,
            ),
            Text(
              'OR',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            _buildBtnSocialRow(),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return ReuseTextField(
      labelText: 'Email',
      inputType: TextInputType.emailAddress,
      onSaved: (value) => _email = value,
      validator: (value) => value.isEmpty ? "Email is empty " : null,
    );
  }

  Widget _pwField() {
    return ReusePwField(
      labelText: 'Password',
      validator: (value) => value.isEmpty || value.length < 6
          ? 'Password is empty or less than 6 character'
          : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget _btntoForgetPass() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {},
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

  Widget _buildBtnSocialRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BtnSocial(() {
            faceBookSignIn();
          }, AssetImage('images/facebook.jpg')),
          SizedBox(width: 20),
          BtnSocial(() {
            googleSignIn();
          }, AssetImage('images/google.jpg')),
        ],
      ),
    );
  }
}
