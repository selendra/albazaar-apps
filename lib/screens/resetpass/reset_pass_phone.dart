import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:selendra_marketplace_app/screens/signin/signin_phonenumber.dart';
import 'package:selendra_marketplace_app/constants.dart';

class ResetPassPhone extends StatelessWidget {

  final TextEditingController tempCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  String alertText, title;


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
    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPhoneNumber()));},
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

  resetByPhone (String tempCode, String phoneNumber ,String password,context) async{
    String apiUrl = 'https://testnet-api.selendra.com/pub/v1/reset-password';

    var response = await http.post(apiUrl,headers:<String, String>{
        "accept": "application/json",
        "Content-Type": "application/json"
      },body: jsonEncode(<String, String>{
        'temp_code' : tempCode ,
        'phone' : '+855'+phoneNumber,
        'password'  : password,
        }
      )
    );
    if(response.statusCode == 200 ){
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
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildText(tempCodeController, 'Reset Code'),
                _buildText(phoneController, 'Phone Number'),
                 TextField(autofocus: true,controller: passController, decoration: InputDecoration(hintText: 'New password',errorText: validatePassword(passController)),),
                 SizedBox(height: 50,),
                 _btnLogin(context),
              ],
            ),
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
        resetByPhone(tempCodeController.text, phoneController.text, passController.text,context);
        tempCodeController.text = '';
        phoneController.text = '';
        passController.text = '';
      },
      child: Text(
        "Reset",
        style: TextStyle(
            color: Colors.white
        ),
      ),
      color: kDefaultColor,
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: _hintText),
    );
  }

  validatePassword(TextEditingController textController){
    if(textController.text.length<6 && textController.text.isEmpty){
      return 'Password cannot be less than 6 characters or empty';
    }
    return null;
  }
}