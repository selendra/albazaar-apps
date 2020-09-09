import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}



class _BodyState extends State<Body> {
  String mValue = mUser.gender;
  bool _isLoading = false;

  void setmValue(String value) {
    mValue = value;
    setState(() {
      mValue = value;
      print(mValue);
    });
  }

  Future<void> validateAndSubmit() async {}

  void onSave(
      String firstName, String midName, String lastName, String gender) async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences isToken = await SharedPreferences.getInstance();

    String token = isToken.getString('token');
    if (token != null) {
      await ApiPostServices()
          .setUserPf(firstName, midName, lastName, gender)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        ProfileDialog().successDialog(context, value);
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: Card(
                      shape: kDefaultShape,
                      elevation: 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
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
                      ),
                    ),
                  ),
                  ProfileForm(setmValue, mValue, onSave),
                ],
              ),
            ),
    );
  }
}
