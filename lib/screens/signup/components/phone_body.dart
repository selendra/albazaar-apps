import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_button.dart';
import 'package:selendra_marketplace_app/services/auth/api_post_services.dart';
import 'package:selendra_marketplace_app/screens/signin/signin_phonenumber.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_pw_field.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String _countryCode='KH';
  String _phone;
  bool isLogined = false;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String _password;
  String alertText;

   
  showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPhoneNumber()));},
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

  onSignUpWithPhone()async{
    await ApiPostServices().signUpByPhone(_phone, _password,context).then((value){
      setState(() {
        _isLoading = false;
      });
      alertText = value ??"";
      showAlertDialog(context);
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
  void validateAndSubmit(){
    if(validateAndSave()){
      print(_password);
      print(_phone);
      onSignUpWithPhone();
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OTPScreen(_phone, _password)));
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
              _reusePwField(),
              SizedBox(height: 80,),
              ReuseButton.getItem('SIGN UP', (){validateAndSubmit();}, context),
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
            borderSide: BorderSide(color: kDefaultColor),
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius))
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

  Widget _reusePwField() {
    return ReusePwField(
      labelText: 'Password',
      validator: (value) => value.isEmpty || value.length < 6
          ? 'Password is empty or less than 6 character'
          : null,
      onSaved: (value) => _password = value,
    );
  }

  
}
