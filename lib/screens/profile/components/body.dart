import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/user.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_button.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_text_field.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_choice_dialog.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

enum Options { Camera, Gallery }

class _BodyState extends State<Body> {
  TextEditingController _textFieldController = TextEditingController();
  String _address, _shorten;

  void onSave() {
    print('save');
  }

  _getCurrentAddress() async {
    SharedPreferences isAddress = await SharedPreferences.getInstance();
    setState(() {
      _address = isAddress.getString('current');
    });
    print(_address);
    _shorten = _address.substring(0, 25)+'...';
    print(_shorten);
  }

  @override
  void initState() {
    super.initState();
    _getCurrentAddress();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                //choiceDialog();
                ReuseChoiceDialog().choiceDialog(context);
              },
              title: Text('Profile photo'),
              trailing: CircleAvatar(
                backgroundImage: mUser.profileImg != null
                    ? NetworkImage(mUser.profileImg)
                    : AssetImage('images/avatar.png'),
              ),
            ),
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.grey[300],
            ),
            inkWell(() {
              _displayDialog(context, 'Username');
            }, 'Name', mUser.firstName ?? 'username'),
            inkWell(() {}, 'Account Info', mUser.email ?? 'email'),
            inkWell(() {
              _displayDialog(context, 'Gender');
            }, 'Gender', mUser.gender ?? 'unknown'),
            inkWell(() {}, 'Phone Number', mUser.phonenumber ?? 'phonenumber'),
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.grey[300],
            ),
            inkWell(() {
              print(_address);
            }, 'Shipping Address', _shorten ?? ''),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              margin: EdgeInsets.all(30.0),
              child: ReuseButton.getItem('Save', () {
                onSave();
              }, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget inkWell(Function onTap, String title, String trailing) {
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

  _displayDialog(BuildContext context, String titleText) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefualtRadius),
            ),
            title: Text(titleText),
            content: Container(
                height: 180,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: ReuseTextField(
                        labelText: 'First Name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: ReuseTextField(
                        labelText: 'Mid Name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: ReuseTextField(
                        labelText: 'Last Name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    /*TextField(
                      autofocus: true,
                      controller: _textFieldController,
                      decoration: InputDecoration(hintText: hintText),
                    ),
                    TextField(
                      autofocus: true,
                      controller: _textFieldController,
                      decoration: InputDecoration(hintText: hintText),
                    ),*/
                  ],
                )),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  _textFieldController.text = '';
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  _textFieldController.text = '';
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
