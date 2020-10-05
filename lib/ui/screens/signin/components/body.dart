import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  TextEditingController _textFieldController;
  final PageController _pageController = PageController(initialPage: 0);
  TabController _tabController;
  var isPageCanChanged = true;

  onGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Auth().signInWithGoogle(context).then((value) {
        if (value == null) {
          Navigator.pop(context);
        } else {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BottomNavigation()));
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
    //signInWithGoogle().whenComplete(() => ));
  }

  onFacebookSignIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Auth().signInFacebook(context).then((value) {
        if (value == null) {
          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BottomNavigation()));
        }
      });
    } on PlatformException catch (e) {
      print(e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  onApiSignInByEmail(String _email, String _password) async {
    setState(() {
      _isLoading = true;
    });
    await ApiPostServices()
        .signInByEmail(_email, _password, context)
        .then((value) {
      if (value == null) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });

        SignInDialog().errorDialog(context, value);
        // alertText = value;
        //_alertDialog(context);
        // showAlertDialog(context);
      }
    });
  }

  onForgetPwEmail(String email) async {
    await ApiPostServices().forgetPasswordByEmail(email).then((value) {
      if (value == 'Your Email doesn\'t exist') {
        alertText = value;
        // _alertDialog(context);
      } else {
        SignInDialog().showResetAlertDialog(context, value);
      }
    });
  }

  onApiSignInByPhone(String _phone, String _password) async {
    setState(() {
      _isLoading = true;
    });
    await ApiPostServices()
        .signInByPhone(_phone, _password, context)
        .then((value) {
      if (value != null) {
        setState(() {
          _isLoading = false;
        });
        SignInDialog().errorDialog(context, value);
      }
    });
  }

  _resetDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ReuseAlertDialog.getItem(
              alertText,
              '',
              'Cancel',
              () {
                Navigator.pop(context);
              },
              'Reset',
              () {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetByEmail(_email)));*/
              });
        });
  }

  onTabChange() {
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        onPageChange(_tabController.index, p: _pageController);
      }
    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      isPageCanChanged = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
      isPageCanChanged = true;
    } else {
      _tabController.animateTo(index);
    }
  }

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
    _tabController = TabController(vsync: this, length: 2);
    onTabChange();
    //_pageController = PageController();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Container(
                      child: Image.asset(
                    'images/logo.png',
                    height: 80,
                    width: 80,
                  )),
                  SizedBox(
                    height: 40,
                  ),
                  ReuseAuthTab(_tabController),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        if (isPageCanChanged) {
                          onPageChange(index);
                        }
                      },
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: SignInPhoneForm(
                            onApiSignInByPhone,
                            onFacebookSignIn,
                            onGoogleSignIn,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: SignInEmailForm(
                            onApiSignInByEmail,
                            onFacebookSignIn,
                            onGoogleSignIn,
                          ), //emailForm(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
