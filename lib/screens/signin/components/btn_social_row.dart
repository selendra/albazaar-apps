import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/signin/components/btn_social.dart';
import 'package:selendra_marketplace_app/services/auth/auth_services.dart';
import 'package:selendra_marketplace_app/bottom_navigation/bottom_navigation.dart';
import 'package:selendra_marketplace_app/screens/signin/signin_phonenumber.dart';

class BtnSocialRow extends StatefulWidget {
  @override
  _BtnSocialRowState createState() => _BtnSocialRowState();
}

class _BtnSocialRowState extends State<BtnSocialRow> {
  onFacebookSignIn() async {
    await signInFacebook(context).then((value) {
      if (value == null) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation()));
      }
    });
  }

  onGoogleSignIn() async {
    try {
      await signInWithGoogle().then((value) {
        if (value == null) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BottomNavigation()));
        }
      });
    } catch (e) {
      print(e);
    }
    //signInWithGoogle().whenComplete(() => ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BtnSocial(
            () {
              onFacebookSignIn();
            },
            AssetImage('images/facebook.jpg'),
          ),
          SizedBox(width: 20),
          BtnSocial(
            () {
              onGoogleSignIn();
            },
            AssetImage('images/google.jpg'),
          ),
          SizedBox(width: 20),
          BtnSocial(
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPhoneNumber()));
            },
            AssetImage('images/phone.jpg'),
          ),
        ],
      ),
    );
  }
}
