import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  bool isPageCanChanged = true;
  String alertText;
  final PageController _pageController = PageController(initialPage: 0);
  TabController _tabController;

  void onSignUpByEmail(
      String _email, String _password, String _confirmPassword) async {
    // setState(() {
    //   _isLoading = true;
    // });
    if (_password != _confirmPassword) {
      await Components.dialog(
          context, Text("Password does not match"), Text("Message"));
      // setState(() {
      //   _isLoading = false;
      // });
      setInitialTab();
    } else {
      try {
        await AuthProvider()
            .signUpByEmail(_email, _password)
            .then((value) async {
          if (value != "Your email account already exists!" ||
              value != 'Your email doesn\'t seem right!') {
            if (value != null) {
              await ReuseAlertDialog().successDialog(context, value);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                  ModalRoute.withName('/'));
            }
          } else {
            await ReuseAlertDialog().customDialog(context, value, () {
              Navigator.pop(context);
            });
          }
        });
      } on SocketException catch (e) {
        await Components.dialog(
            context,
            Text(e.message.toString(), textAlign: TextAlign.center),
            Text("Message"));
      } on FormatException catch (e) {
        await Components.dialog(
            context,
            Text(e.message.toString(), textAlign: TextAlign.center),
            Text("Message"));
      } finally {
        setInitialTab();
        stopLoading();
      }
    }
  }

  Future<void> onSignUpWithPhone(
      String _phone, String _password, String _confirmPassword) async {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoScreen()));
    _phone = "+855" + AppServices.removeZero(_phone);
    // setState(() {
    //   _isLoading = true;
    // });

    if (_password != _confirmPassword) {
      await Components.dialog(
          context, Text("Password does not match"), Text("Message"));
      // setState(() {
      //   _isLoading = false;
      // });
    } else {
      try {
        await AuthProvider()
            .signUpByPhone(_phone, _password, context)
            .then((value) async {
          if (value == 'Successfully registered!') {
            // setState(() {
            //   _isLoading = false;
            // });
            await ReuseAlertDialog().successDialog(context, value);
            await Navigator.push(context,
                RouteAnimation(enterPage: OTPScreen(_phone, _password)));
          } else {
            // setState(() {
            //   _isLoading = false;
            // });
            // Already Register
            await ReuseAlertDialog().successDialog(context, value);
          }
        });
      } on SocketException catch (e) {
        await Components.dialog(
            context,
            Text(e.message.toString(), textAlign: TextAlign.center),
            Text("Message"));

        // setState(() {
        //   _isLoading = false;
        // });
      } on FormatException catch (e) {
        await Components.dialog(
            context,
            Text(e.message.toString(), textAlign: TextAlign.center),
            Text("Message"));

        // setState(() {
        //   _isLoading = false;
        // });
      }
    }
  }

  void onGoogleSignIn() async {
    // setState(() {
    //   _isLoading = true;
    // });
    await AuthProvider().signInWithGoogle(context).then((value) {
      if (value == null) {
        // setState(() {
        //   _isLoading = false;
        // });
      } else {
        Provider.of<AuthProvider>(context, listen: false)
            .getTokenForGoogle(value, context);
      }
    }).catchError((onError) {
      // setState(() {
      //   _isLoading = false;
      // });
      ReuseAlertDialog().successDialog(context, onError);
    });
  }

  onFacebookSignIn() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      await AuthProvider().signInFacebook(context).then((value) {
        if (value == null) {
          // setState(() {
          //   _isLoading = false;
          // });
        } else {
          Provider.of<AuthProvider>(context, listen: false)
              .getTokenForFb(value, context);
        }
      });
    } on PlatformException catch (e) {
      // setState(() {
      //   _isLoading = false;
      // });
    } finally {
      stopLoading();
    }
  }

  void onTabChange() {
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          onPageChange(_tabController.index, p: _pageController);
        });
      }
    });
  }

  void onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      isPageCanChanged = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 400), curve: Curves.easeOut);
      isPageCanChanged = true;
    } else {
      _tabController.animateTo(index);
    }
  }

  //This function is use to set initial tab when setstate
  void setInitialTab() {
    setState(() {
      _tabController.index = 0;
    });
  }

  //This function is use to stop loading circle indicator
  void stopLoading() {
    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    setInitialTab();
    onTabChange();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Card(
        child: Container(
          color: Colors.grey.withOpacity(0.1),
          height: MediaQuery.of(context).size.height * 0.95,
          width: MediaQuery.of(context).size.width,
          child: Responsive(
            mobile: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Image.asset(
                          'images/logo.png',
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: 400,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'A Decentralized Marketplace that connect community of users together.',
                            style: TextStyle(
                              fontSize: 24,
                              letterSpacing: 0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: 400,
                        margin: const EdgeInsets.all(20),
                        // padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            ReuseAuthTab(
                              _tabController,
                              _lang.translate('phone'),
                              _lang.translate('email'),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Expanded(
                              flex: 2,
                              child: PageView(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  onPageChange(index);
                                },
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints.expand(),
                                    child: Card(
                                      shape: kDefaultShape,
                                      child: SingleChildScrollView(
                                        child: Container(
                                          margin: const EdgeInsets.all(20.0),
                                          child: SignUpPhoneForm(
                                            onSignUpWithPhone,
                                            onFacebookSignIn,
                                            onGoogleSignIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints.expand(),
                                    child: Card(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          margin: const EdgeInsets.all(20.0),
                                          child: SignUpEmailForm(
                                            onSignUpByEmail,
                                            onFacebookSignIn,
                                            onGoogleSignIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Image.asset(
                        'images/logo.png',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20.0),
                          // color: Colors.red,
                          width: 400,
                          child: Text(
                            'A Decentralized Marketplace that connect community of users together.',
                            style: TextStyle(
                              fontSize: 24,
                              letterSpacing: 0.7,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    // color: kDefaultColor,
                    height: 700,
                    width: 400,
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
                        ReuseAuthTab(
                          _tabController,
                          _lang.translate('phone'),
                          _lang.translate('email'),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          flex: 2,
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              onPageChange(index);
                            },
                            children: [
                              ConstrainedBox(
                                constraints: const BoxConstraints.expand(),
                                child: Card(
                                  shape: kDefaultShape,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      margin: const EdgeInsets.all(20.0),
                                      child: SignUpPhoneFormDesktop(
                                        onSignUpWithPhone,
                                        onFacebookSignIn,
                                        onGoogleSignIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints.expand(),
                                child: Card(
                                  shape: kDefaultShape,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      margin: const EdgeInsets.all(20.0),
                                      child: SignUpEmailForm(
                                        onSignUpByEmail,
                                        onFacebookSignIn,
                                        onGoogleSignIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
