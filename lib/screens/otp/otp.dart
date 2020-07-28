import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  OTPScreen(this.phoneNumber);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(scaffoldBackgroundColor: Colors.white,),
      child: Scaffold(
        body: PinScreen(widget.phoneNumber),
      ),
    );
  }

}

class PinScreen extends StatefulWidget {
  final String phoneNumber;
  PinScreen(this.phoneNumber);
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {

  bool _isLoading = false;
  String alertText;
  List<String> currentPin = ["","","","","",""];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();
  
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: Colors.transparent)
  );
  showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.pop(context);},
  );

  AlertDialog alert = AlertDialog(
    title: Text(alertText),
    content: Text("Please check again. "),
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
  void checkVerify(String verifyOTP)async{
    String apiUrl = 'https://testnet-api.zeetomic.com/pub/v1/account-confirmation';
     setState(() {
      _isLoading = true;
    });
    var response = await http.post(apiUrl,headers: <String,String>{
      "accept": "application/json",
      "Content-Type": "application/json"
    },body: jsonEncode(<String,String>{
      'phone': widget.phoneNumber,
      'verification_code': verifyOTP,
    }));
    if (response.statusCode==200){
      SharedPreferences isLogin = await SharedPreferences.getInstance();
      setState(() {
        _isLoading = false;
      });
      var responseBody = json.decode(response.body);
      print(responseBody);
      print(response.body);
      try{
        alertText = responseBody['error']['message'];
        showAlertDialog(context);
        for (int i=0; i<6; i++){
          clearPin();
        }
      }catch (e){
        isLogin.setBool('isLogin', true);
        alertText = responseBody['message'];
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
      }
    }else{
      print(response.body);
      setState(() {
        _isLoading = false;
      });
    }
  }
  void resendCode(String phoneNumber)async{
    String apiUrl = 'https://testnet-api.zeetomic.com/pub/v1/resend-code';
    var response = await http.post(apiUrl,headers: <String,String>{
      "accept": "application/json",
      "Content-Type": "application/json"
      },body: jsonEncode(<String,String>{
      'phone': phoneNumber,
    }));
    if(response.statusCode == 200){
      var responseJson = json.decode(response.body);
      alertText = responseJson['message'];
      showAlertDialog(context);
    }
  }

  int pinIndex = 0;

  pinIndexSetup(String text){
    if(pinIndex==0)
      pinIndex=1;
    else if(pinIndex<6){
      pinIndex++;
    }
    setPin(pinIndex,text);
    currentPin[pinIndex-1] = text;
    String strPin = "";
    currentPin.forEach((element) {
      strPin += element;
    });
    if(pinIndex==6){
      print(strPin);
      checkVerify(strPin);
    }
      
  }
  setPin(int n, String text){
    switch(n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
      case 5:
        pinFiveController.text = text;
        break;
      case 6:
        pinSixController.text = text;
        break;
    }
  }
  clearPin(){
    if(pinIndex==0)
      pinIndex=0;
    else if(pinIndex==6){
      setPin(pinIndex, "");
      currentPin[pinIndex-1]=="";
      pinIndex--;
    }else{
      setPin(pinIndex, "");
      currentPin[pinIndex-1]="";
      pinIndex--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: _isLoading ? Center(child: CircularProgressIndicator(),) : Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 100,),
                  Text(
                    'Enter the OTP Pin',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: kDefualtColor,
                    ),
                  ),
                  Text(
                    'OTP was send to: '+widget.phoneNumber,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: kDefualtColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      child: Text('Resend Code',style: TextStyle(color: Colors.red),),
                      onPressed: (){resendCode(widget.phoneNumber);},
                      )
                    ),
                  SizedBox(height: 50,),
                  _buildPinRow(),
                  SizedBox(height: 50,),
                  _buildNumberPad()
                ],
              ),
          ),
        ),
      );
  }

  Widget _buildPinRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        PINNumber(outlineInputBorder,pinOneController ),
        PINNumber(outlineInputBorder,pinTwoController ),
        PINNumber(outlineInputBorder,pinThreeController ),
        PINNumber(outlineInputBorder,pinFourController ),
        PINNumber(outlineInputBorder,pinFiveController ),
        PINNumber(outlineInputBorder,pinSixController ),
      ],
    );
  }
  Widget _buildNumberPad(){
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyBoardNumber(1,(){
                    pinIndexSetup('1');
                  }),
                  KeyBoardNumber(2,(){
                    pinIndexSetup('2');
                  }),
                  KeyBoardNumber(3,(){
                    pinIndexSetup('3');
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyBoardNumber(4,(){
                    pinIndexSetup('4');
                  }),
                  KeyBoardNumber(5,(){
                    pinIndexSetup('5');
                  }),
                  KeyBoardNumber(6,(){
                    pinIndexSetup('6');
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyBoardNumber(7,(){
                    pinIndexSetup('7');
                  }),
                  KeyBoardNumber(8,(){
                    pinIndexSetup('8');
                  }),
                  KeyBoardNumber(9,(){
                    pinIndexSetup('9');
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    child: MaterialButton(
                      onPressed: null,
                      child: SizedBox(),
                    ),
                  ),
                  KeyBoardNumber(0,(){
                    pinIndexSetup('0');
                  }),
                  Container(
                    width: 60,
                    child: MaterialButton(
                      height: 60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      onPressed: (){
                        clearPin();
                      },
                      child: Icon(
                        Icons.backspace,
                        color: kDefualtColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class PINNumber extends StatelessWidget {
  final OutlineInputBorder outlineInputBorder;
  final TextEditingController textEditingController;

  PINNumber(this.outlineInputBorder,this.textEditingController);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: false,
        textAlign:  TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          border: outlineInputBorder,
          filled: true,
          fillColor: Colors.grey[300],
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: kDefualtColor,
        ),
      ),
    );
  }
}
class KeyBoardNumber extends StatelessWidget {
  final int n;
  final Function() onPressed;

  KeyBoardNumber(this.n,this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kDefualtColor,
      ),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: EdgeInsets.all(8.0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        height: 90,
        child: Text(
          '$n',
          style: TextStyle(
            fontSize: 24*MediaQuery.of(context).textScaleFactor,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}


