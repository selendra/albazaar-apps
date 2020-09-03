import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

String _firstName, _midName, _lastName;

class ProfileForm extends StatelessWidget {
  final Function setmValue;
  final Function onSaved;
  final String mValue;
  ProfileForm(this.setmValue, this.mValue, this.onSaved);

  final _formKey = GlobalKey<FormState>();

  void validataAndSubmit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_firstName);
      print(_midName);
      print(_lastName);
      onSaved(_firstName, _midName, _lastName, mValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: Card(
              elevation: 0,
              shape: kDefaultShape,
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: ReuseTextField(
                          labelText: 'First Name',
                          initialValue: mUser.firstName,
                          onSaved: (newValue) => _firstName = newValue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ReuseTextField(
                          labelText: 'Mid Name',
                          initialValue: mUser.midName == 'string'
                              ? 'Email'
                              : mUser.midName,
                          onSaved: (newValue) => _midName = newValue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ReuseTextField(
                          labelText: 'Last Name',
                          initialValue: mUser.lastName,
                          onSaved: (newValue) => _lastName = newValue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GenderDropdown(
                        initialValue: mValue,
                        onChanged: (value) {
                          setmValue(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              elevation: 0,
              child: Column(
                children: [
                  item(() {}, 'Account Info', mUser.email ?? 'email'),
                  item(() {}, 'Phone Number',
                      mUser.phonenumber ?? 'phonenumber'),
                  item(() {}, 'Shipping Address', ''),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(30.0),
            child: ReuseButton.getItem('Save', () {
              //onSave();
              validataAndSubmit();
            }, context),
          ),
        ],
      ),
    );
  }

  Widget item(Function onTap, String title, String trailing) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey,
      child: ListTile(
        title: Text(title),
        trailing: Wrap(
          children: [
            Text(
              trailing,
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
