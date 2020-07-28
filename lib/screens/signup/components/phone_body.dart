import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/screens/otp/otp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String _countryCode='KH';
  String _phone;
  bool isLogined = false;
  bool _isHidden = true;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String _password;
  IconData _iconData = Icons.visibility;
  String alertText;

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
   showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.pop(context);},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(alertText),
    content: Text("Please check phone number"),
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
  signUpWithPhone(String phone,String password) async{
    String apiUrl = "https://testnet-api.zeetomic.com/pub/v1/registerbyphone";
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
      setState(() {
        _isLoading = false;
      });
      var responseBody = json.decode(response.body);
      print(responseBody);
      print(response.body);
      alertText = responseBody['message'];
      if(alertText=='Successfully registered!'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OTPScreen(phone)));
      }else {
        showAlertDialog(context);
      }    
    }else{
      print(response.body);
    }
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
  void validateAndSubmit(){
    if(validateAndSave()){
      print(_password);
      print(_phone);
      signUpWithPhone(_phone, _password);
    }
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
              SizedBox(height: 80,),
              _btnSignUp(context),
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
  Widget _btnSignUp(context){
    return Container(
      width: 150,
      height: 50,
      child: RaisedButton(
        onPressed: (){
          validateAndSubmit();
        },
        child: Text(
          "Sign Up",
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
}
