import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:selendra_marketplace_app/screens/resetpass/reset_pass_phone.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String _countryCode='KH';
  String _phone;
  bool isLogined = false;
  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();
  String _password;
  IconData _iconData = Icons.visibility;
  bool _isLoading = false;
  String alertText;
  TextEditingController _textEditingController;

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
      
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassPhone()));
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

  signInWithPhone(String phone,String password) async{
    String apiUrl = "https://testnet-api.zeetomic.com/pub/v1/loginbyphone";
    String token;
    setState(() {
      _isLoading = true;
    });
    var response = await http.post(apiUrl,headers: <String,String>{
      "accept": "application/json",
      "Content-Type": "application/json"
    },body: jsonEncode(<String,String>{
      'phone': phone,
      'password': password,
    }));
    if (response.statusCode==200){
      SharedPreferences isLogin = await SharedPreferences.getInstance();
      setState(() {
        _isLoading = false;
      });
      var responseJson = json.decode(response.body);
      print(responseJson);
      print(response.body);
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
    }else{
      print(response.body);
      setState(() {
        _isLoading = false;
      });
    }
  }
  void validateAndSubmit(){
    if(validateAndSave()){
      print(_password);
      print(_phone);
      signInWithPhone(_phone, _password);
    }
  }
  void forgetPassword(String phoneNumber)async {
    String apiUrl  = 'https://testnet-api.zeetomic.com/pub/v1/forget-password';
    var response = await http.post(apiUrl,headers: <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json"
      },body: jsonEncode(<String,String>{
        'phone' : '+855'+phoneNumber
      })
    );
    if(response.statusCode == 200){
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
      child: _isLoading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.all(30.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Container(
                  child:Image.asset('images/logo.png',height: 100,width: 100,)
                ),
              SizedBox(height: 50,),
              _phoneCodePick(),
              SizedBox(height: 10,),
              _passwordField(),
              _btntoForgetPass(),
              SizedBox(height: 80,),
              _btnSignIn(context),
            ],
        ),
          ),
      ),
      ),
    );
}
  Widget _phoneCodePick(){
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
              borderRadius: BorderRadius.all(Radius.circular(30.0))
          ),
        ),
        initialCountryCode: _countryCode,
        onChanged: (phone) {
          print(phone.completeNumber);
          _phone = phone.completeNumber.toString();
        },
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
  Widget _btnSignIn(context){
    return Container(
      width: 150,
      height: 50,
      child: RaisedButton(
        onPressed: (){
          print('Sign in');
          validateAndSubmit();
        },
        child: Text(
          "Sign In",
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
                    _textEditingController.text ='';
                    Navigator.of(context).pop();
                  },
                ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  forgetPassword(_textEditingController.text);
                  _textEditingController.text ='';
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

