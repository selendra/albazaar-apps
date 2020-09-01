import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

enum Options { Camera, Gallery }

class _BodyState extends State<Body> {

  String mValue = mUser.gender;

  void onSave() {
    print('save');
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
            item(() {
              ProfileDialog().usernameDialog(context, 'UserName');
            }, 'Name', mUser.firstName ?? 'username'),
            item(() {}, 'Account Info', mUser.email ?? 'email'),
            GenderDropdown(
              initialValue: mValue,
              onChanged: (value) {
                setState(() {
                  mValue = value;
                  print(mValue);
                });
              },
            ),
            item(() {}, 'Phone Number', mUser.phonenumber ?? 'phonenumber'),
            Container(
              height: 2,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.grey[300],
            ),
            item(() {}, 'Shipping Address', ''),
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
