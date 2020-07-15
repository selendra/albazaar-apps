import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:selendra_marketplace_app/constants.dart';
import '../../../constants.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/screens/signup/signup.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();
  String _email,_password;
  IconData _iconData = Icons.visibility;

  bool validateAndSave(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }

  }
  void toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
      if(_isHidden==true){
        _iconData = Icons.visibility;
      }else{
        _iconData = Icons.visibility_off;
      }
    });
  }
  void validateAndSubmit(){
    if(validateAndSave()){
      print(_email);
      print(_password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
  Widget _buildBody(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  child: FlutterLogo(
                    size: 150,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                _emailField(),
                SizedBox(
                  height: 20,
                ),
                _passwordField(),
                _btntoForgetPass(),
                SizedBox(
                  height: 20,
                ),
                _btnLogin(),
                _btntoRegister(),
                SizedBox(
                  height: 20,
                ),
                Text('OR',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
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
  Widget _emailField(){
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Enter your Email',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(30.0))
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.blueAccent,
          ),
        ),
        validator: (value) =>  value.isEmpty? "Empty email" :null,
        onSaved: (value) => _email = value,
      ),
    );
  }
  Widget _passwordField(){
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Enter your Password',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(30.0))
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: kDefualtColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(_iconData,),
            color: kDefualtColor  ,
            onPressed: (){
              toggleVisibility();
            },
          ),
        ),
        obscureText: _isHidden,
        validator: (value) => value.isEmpty || value.length < 6 ? "Password is empty or less than 6 character" : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _btnLogin(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: RaisedButton(
        onPressed: (){
          validateAndSubmit();
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

  Widget _btnSocial(Function onTap, AssetImage logo){
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
        )
    );
  }

  Widget _buildBtnSocialRow(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _btnSocial(
              (){
                print('Sign In with Facebook');
              },
              AssetImage('images/facebook.jpg'),
          ),
          SizedBox(width: 40),
          _btnSocial(
                (){
              print('Sign In with Google');
            },
            AssetImage('images/google.jpg'),
          ),
        ],
      ),
    );
  }

  Widget _btntoForgetPass(){
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: (){
          print('forget password');
        },
        child: RichText(
          text: TextSpan(
            text: 'Forget Password?',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ) ,
    );
  }

  Widget _btntoRegister(){
    return Container(
      child: FlatButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
        },
        child: RichText(
          text: TextSpan(
              text: 'Haven`t Had an Account?',
              style: TextStyle(
                color: Colors.black,
              ),
              children: <TextSpan> [
                TextSpan(
                    text: ' Sign Up',
                    style: TextStyle(
                      color: Colors.red,
                    )
                )
              ]
          ),
        ),
      ) ,
    );

  }



}

