import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NetworkAlert(
        Center(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome to',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Selendra Marketplace',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          color: kDefaultColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        child: Image.asset(
                      'images/welcome_icon.png',
                    )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  ReuseButton.getItem('SIGN IN', () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  }, context),
                  SizedBox(
                    height: 20,
                  ),
                  _btnSignUp(context),
                ],
              )),
        ),
      ),
    );
  }

  Widget _btnSignUp(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: OutlineButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        },
        child: Text(
          "SIGN UP",
          style: TextStyle(
            color: kDefaultColor,
          ),
        ),
        color: Colors.white,
        borderSide: BorderSide(color: kDefaultColor, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
        ),
      ),
    );
  }
}
