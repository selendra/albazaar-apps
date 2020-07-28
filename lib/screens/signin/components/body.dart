import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:selendra_marketplace_app/constants.dart';
import '../../../constants.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/screens/signup/signup.dart';
import 'package:selendra_marketplace_app/auth/auth_services.dart';
import 'package:selendra_marketplace_app/screens/signin/signin_phonenumber.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:selendra_marketplace_app/screens/resetpass/reset_by_email.dart';



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
  bool _isLoading = false;
  String alertText;
  String object;
  TextEditingController _textFieldController;
  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }
  showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.pop(context);},
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


  signIn(String email,String password) async{
    String apiUrl = "https://testnet-api.zeetomic.com/pub/v1/loginbyemail";
    String token;
    setState(() {
      _isLoading =true;
    });
    var response = await http.post(apiUrl,headers: <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json"
    },body: jsonEncode(<String,String>{
      'email': email,
      'password': password,
    }));
    if(response.statusCode ==200){
      print('success');
      print(response.body);
      SharedPreferences isLogin = await SharedPreferences.getInstance();
      var responseJson = json.decode(response.body);
      setState(() {
         _isLoading = false;
      });
      token = responseJson['token'];
      if (token!=null){
        isLogin.setBool("isLogin", true);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
      }else {
        try{
          alertText = responseJson['error']['message'];
          showAlertDialog(context);
        }catch (e){
          alertText = responseJson['message'];
          showAlertDialog(context);
        } 
      }
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
    }else {
      print(response.body);
    
    }
  }

   onGoogleSignIn () async{
    try{
      await signInWithGoogle().then((value) {
        if (value==null){
          Navigator.pop(context);
        }else{
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
        }
      });
    }catch (e){
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
    //signInWithGoogle().whenComplete(() => ));
  }

  
   onFacebookSignIn () async{
    await signInFacebook(context).then((value){
      if (value==null){
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
      else{
        setState(() {
          _isLoading = false;
        });
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
      signIn(_email, _password);
    }
  }

  showResetAlertDialog(BuildContext context) {
  // set up the button
  Widget _okButton = FlatButton(
    child: Text("Reset"),
    onPressed: () {
      
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetByEmail(_email)));
      },
  );
  Widget _cancelButton = FlatButton(
    child: Text('Cancel'),
    onPressed: (){
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

  void forgetPassword(String email)async {
    String apiUrl  = 'https://testnet-api.zeetomic.com/pub/v1/forget-password-by-email';
    var response = await http.post(apiUrl,headers: <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json"
      },body: jsonEncode(<String,String>{
        'email' : email
      })
    );
    if(response.statusCode == 200){
      var responseBody = json.decode(response.body);
      alertText = responseBody['message'];
      if(alertText == 'Your email does not exist!'){
         showAlertDialog(context);
      }else{
        showResetAlertDialog(context);
      }
     
    }else{
      alertText = 'Error';
      showAlertDialog(context);
    }
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
  Widget _buildBody(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: _isLoading ? Center(child: CircularProgressIndicator(),):SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset('images/logo.png',height: 100,width: 100,)
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
            color: kDefualtColor,
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
                setState(() {
                  _isLoading = true;
                });
                onFacebookSignIn();
              },
              AssetImage('images/facebook.jpg'),
          ),
          SizedBox(width: 20),
          _btnSocial(
                (){
                setState(() {
                  _isLoading = true;
                });
                onGoogleSignIn();
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
                  _textFieldController.text ='';
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  forgetPassword(_textFieldController.text);
                  _textFieldController.text ='';
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

 
  
}

