import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_text_field.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_button.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/services/auth/api_post_services.dart';
import 'package:selendra_marketplace_app/screens/signin/signin.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameKey = GlobalKey<FormFieldState<String>>();
  final _midNameKey = GlobalKey<FormFieldState<String>>();
  final _lastNameKey = GlobalKey<FormFieldState<String>>();
  String firstName, midName, lastName, gender, _token, alertText;
  int _selectedIndex;
  final snackBar = SnackBar(content: Text('Please Select a Gender'));

  bool validateAndSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    } else {
      return false;
    }
  }

  /*void getToken() async {
    SharedPreferences isToken = await SharedPreferences.getInstance();
    _token = isToken.getString('token');
    print(_token);
  }*/

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(alertText),
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

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  void setSelectedIndex(int val) {
    setState(() {
      _selectedIndex = val;
    });
  }

  void validateAndSubmit() {
    if (_selectedIndex == 0) {
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      if (validateAndSave()) {
        print(_selectedIndex);
        switch (_selectedIndex) {
          case 1:
            gender = 'M';
            break;
          case 2:
            gender = 'F';
            break;
        }
        onSetUserPf();
        print(_token);
        print(firstName);
      }
    }
  }

  onSetUserPf() async {
    await ApiPostServices()
        .setUserPf(firstName, midName, lastName, gender)
        .then((value) {
      alertText = value;
      showAlertDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                  child: Image.asset(
                'images/logo.png',
                height: 100,
                width: 100,
              )),
              SizedBox(
                height: 40,
              ),
              _firstName(),
              SizedBox(
                height: 20,
              ),
              _midName(),
              SizedBox(
                height: 20,
              ),
              _lastName(),
              SizedBox(
                height: 20,
              ),
              _radioBtn(),
              SizedBox(
                height: 40,
              ),
              ReuseButton.getItem('Submit', () {
                //validateAndSubmit();
                validateAndSubmit();
              }, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radioBtn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            child: Text(
              'Gender',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: _selectedIndex,
                activeColor: kDefaultColor,
                onChanged: (val) {
                  print('$val');
                  setSelectedIndex(val);
                },
              ),
              Text('Male'),
              Radio(
                value: 2,
                groupValue: _selectedIndex,
                activeColor: kDefaultColor,
                onChanged: (val) {
                  print('$val');
                  setSelectedIndex(val);
                },
              ),
              Text('Female'),
            ],
          ),
        )
      ],
    );
  }

  Widget _firstName() {
    return ReuseTextField(
      fieldKey: _firstNameKey,
      labelText: 'Firstname',
      onSaved: (value) => firstName = value,
    );
  }

  Widget _midName() {
    return ReuseTextField(
      fieldKey: _midNameKey,
      labelText: 'Midname',
      onSaved: (value) => midName = value,
    );
  }

  Widget _lastName() {
    return ReuseTextField(
      fieldKey: _lastNameKey,
      labelText: 'Lastname',
      onSaved: (value) => lastName = value,
    );
  }
}
