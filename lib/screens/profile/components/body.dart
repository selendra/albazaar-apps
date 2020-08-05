import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/user.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _textFieldController = TextEditingController();

  void onSave() {
    print('save');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                print('Accounts');
              },
              splashColor: Colors.grey,
              child: ListTile(
                title: Text('Profile photo'),
                trailing: CircleAvatar(
                  backgroundImage: mUser.profileImg != null
                      ? NetworkImage(mUser.profileImg)
                      : AssetImage('images/avatar.png'),
                ),
              ),
            ),
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.grey[300],
            ),
            inkWell(() {
              _displayDialog(context, 'Username', 'Input new username');
            }, 'Name', mUser.firstName ?? 'username'),
            inkWell(() {}, 'Account Info', mUser.email ?? 'email'),
            inkWell(() {
              _displayDialog(context, 'Gender', 'Input Gender');
            }, 'Gender', mUser.gender ?? 'unknown'),
            inkWell(() {}, 'Phone Number', mUser.phonenumber ?? 'phonenumber'),
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.grey[300],
            ),
            inkWell(() {}, 'Shipping Address', 'Cambodia'),
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
        trailing: Text(trailing),
      ),
    );
  }

  _displayDialog(
      BuildContext context, String titleText, String hintText) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(titleText),
            content: TextField(
              autofocus: true,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: hintText),
            ),
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
