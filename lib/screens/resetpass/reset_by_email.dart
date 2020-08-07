import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/screens/signin/signin.dart';

class ResetByEmail extends StatelessWidget {
  
  final email;
  ResetByEmail(this.email);
  
  final TextEditingController tempCodeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();
  
  String alertText,title;

 

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.pop(context);},
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(alertText),
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
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));},
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(alertText),
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
String validatePassword(String value) {
  if (!(value.length > 5) && value.isNotEmpty) {
    return "Password should contains more then 5 character";
  }
  return null;
}

  resetbyEmail(String tempCode,String email,String password,context) async{
    String apiUrl = "https://testnet-api.selendra.com/pub/v1/reset-password-by-email";
    
    var response = await http.post(apiUrl,headers: <String, String>{
      "accept": "application/json",
      "Content-Type": "application/json"
    },body: jsonEncode(<String,String>{
      'temp_code': tempCode,
      'email': email,
      'password':password,
    }));
    if(response.statusCode ==200){
      print('success');
      print(response.body);
      var responseJson = json.decode(response.body);
     
      try{
        alertText = responseJson['error']['message'];
        title = 'Error';
        showAlertDialog(context);
      }catch (e){
        alertText = responseJson['message'];
        title = 'Message';
        showResetAlertDialog(context);
      } 
    }
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Container(
            margin: EdgeInsets.all(30.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildResetCode(tempCodeController, "Reset Code"),
              _buildText(emailController.text=email,'Email'),
              _buildText(passController, 'New Password'),
              SizedBox(height: 50,),
              _btnLogin(context),
            ],
          ),
        ),
      ),
    );
  }
   _btnLogin(context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    child: RaisedButton(
      onPressed: (){
        resetbyEmail(tempCodeController.text, emailController.text, passController.text,context);
        tempCodeController.text = '';
        emailController.text = '';
        passController.text = '';
      },
      child: Text(
        "Reset",
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
  Widget _buildText(TextEditingController _controller,String _hintText){
    return TextField(
      autofocus: true,
      controller: _controller,
      decoration: InputDecoration(hintText: _hintText),
    );
  }
  Widget _buildResetCode(TextEditingController _controller,String _hintText){
    return TextField(
      keyboardType: TextInputType.number,
      autofocus: true,
      controller: _controller,
      decoration: InputDecoration(hintText: _hintText),
    );
  }
}