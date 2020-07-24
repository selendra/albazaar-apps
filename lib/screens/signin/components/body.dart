import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:selendra_marketplace_app/constants.dart';
import '../../../constants.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/screens/signup/signup.dart';
import 'package:selendra_marketplace_app/auth/auth_services.dart';
import 'package:selendra_marketplace_app/screens/signin/signin_phonenumber.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool isLogined = false;
  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();
  String _email,_password;
  IconData _iconData = Icons.visibility;
  TabController _controller;

  bool validateAndSave(){
    final form = formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }

  }

   onGoogleSignIn () async{
    try{
      await signInWithGoogle().then((value) {
        if (value==null){
          Navigator.pop(context);
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
        }
      });
    }catch (e){
      print(e);
      Navigator.pop(context);
    }
    //signInWithGoogle().whenComplete(() => ));
  }

   showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

   onFacebookSignIn () async{
    await signInFacebook(context).then((value){
      if (value==null){
        Navigator.pop(context);
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
      }
    });
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
                  height: 50,
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
                SizedBox(
                  height: 10,
                ),
                _btntoRegister(),
                SizedBox(
                  height: 10,
                ),
                Text('OR',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
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
  Widget _emailField(){
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Email',
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
            color: kDefualtColor,
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
                showAlertDialog(context);
                onFacebookSignIn();
              },
              AssetImage('images/facebook.jpg'),
          ),
          SizedBox(width: 20),
          _btnSocial(
                (){
                  showAlertDialog(context);
                  if (onGoogleSignIn() == false){
                    Navigator.pop(context);
                  }
            },
            AssetImage('images/google.jpg'),
          ),
          SizedBox(width: 20),
          _btnSocial(
                (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPhoneNumber()));
            },
            AssetImage('images/phone.jpg'),
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
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

  Widget _buildTabs(){
   return DefaultTabController(
     length: 2,
    child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_car)),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Icon(Icons.directions_car),
          Icon(Icons.directions_transit),
        ],
      ),
     ),
   );
  }
}

