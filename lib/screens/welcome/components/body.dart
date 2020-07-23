import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import '../../../constants.dart';
import 'package:selendra_marketplace_app/screens/signin/signin.dart';
import 'package:selendra_marketplace_app/screens/signup/signup.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          margin: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome to',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22 ,
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
                      fontSize: 28 ,
                      color: kDefualtColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/15,),
              Align(
                alignment: Alignment.center,
                child: Container(

                    child: Image.asset(
                        'images/welcome_icon.png',
                    )
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/10,),
              _btnLogin(),
              SizedBox(height: 20,),
              _btnSignUp(),
            ],
          )
        ),
      ),
    );
  }
  Widget _btnLogin(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: RaisedButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
        },
        child: Text(
          "SIGN IN",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        color: kDefualtColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
      ),
    );
  }
  Widget _btnSignUp(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: OutlineButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
        },
        child: Text(
          "SIGN UP",
          style: TextStyle(
              color: kDefualtColor,
          ),
        ),
        color: Colors.white,
        borderSide: BorderSide(color: kDefualtColor,width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    );
  }
}

