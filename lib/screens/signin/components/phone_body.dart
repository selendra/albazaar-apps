import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String _countryCode='KH';
  String phone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            Text('ENTER YOUR PHONE NUMBER TO SIGN IN' ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            Container(
              height: MediaQuery.of(context).size.height/2,
              child: Image.asset('images/welcome_icon.png')
            ),
            SizedBox(height: 10,),
            _phoneCodePick(),
            SizedBox(height: 10,),
            _btnSignIn(context),
          ],
        ),
      ),
    );
  }
  Widget _phoneCodePick(){
    return Container(
      margin: EdgeInsets.all(30.0),
      child: IntlPhoneField(
        decoration: InputDecoration(
          labelText: 'Phone Number',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
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
        },
      ),
    );
  }
  Widget _btnSignIn(context){
    return Container(
      width: 150,
      height: 50,
      child: RaisedButton(
        onPressed: (){
        },
        child: Text(
          "Sign In",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))
        ),
      ),
    );
  }
}
