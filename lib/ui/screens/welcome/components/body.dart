import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: NetworkAlert(
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _lang.translate('welcome_string'),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        //color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Selendra Marketplace',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          color: kDefaultColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: SvgPicture.asset(
                        'images/undraw_Mobile_application.svg',
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  ReuseButton.getItem(_lang.translate('signin_string'), () {
                    // Navigator.pushReplacementNamed(context, BottomNavigationView);
                    Navigator.pushReplacementNamed(context, SignInView);
                  }, context),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: OutlineButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, SignUpView);
                      },
                      child: Text(
                        _lang.translate('signup_string'),
                        style: TextStyle(
                          color: kDefaultColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Colors.white,
                      borderSide: BorderSide(color: kDefaultColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(kDefaultRadius)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
