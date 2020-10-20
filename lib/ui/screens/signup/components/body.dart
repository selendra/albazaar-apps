import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  bool _isLoading = false, isPageCanChanged = true;
  String alertText;
  final PageController _pageController = PageController(initialPage: 0);
  TabController _tabController;

  onSignUpByEmail(String _email, String _password) async {
    setState(() {
      _isLoading = true;
    });
    await ApiPostServices().signUpByEmail(_email, _password).then((value) {
      setState(() {
        _isLoading = false;
      });
      alertText = value;
      if (alertText != "Your email account already exists!") {
        Navigator.pushReplacementNamed(context, SignInView);
      } else {
        ReuseAlertDialog().successDialog(context, alertText);
      }
    });
  }

  onSignUpWithPhone(String _phone, String _password) async {
    setState(() {
      _isLoading = true;
    });
    await ApiPostServices()
        .signUpByPhone(_phone, _password, context)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      alertText = value ?? "";

      if (alertText != 'Your phone number already exists!') {
        Navigator.pushReplacement(
            context, RouteAnimation(enterPage: OTPScreen(_phone, _password)));
      } else {
        ReuseAlertDialog().successDialog(context, alertText);
      }
    });
  }

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
          Navigator.pushReplacementNamed(context, BottomNavigationView);
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  onFacebookSignIn() async {
    setState(() {
      _isLoading = true;
    });
    await Auth().signInFacebook(context).then((value) {
      if (value == null) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacementNamed(context, BottomNavigationView);
      }
    });
  }

  onTabChange() {
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          onPageChange(_tabController.index, p: _pageController);
        });
      }
    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      isPageCanChanged = false;
      await _pageController.animateToPage(index,
          duration: Duration(milliseconds: 400), curve: Curves.easeOut);
      isPageCanChanged = true;
    } else {
      _tabController.animateTo(index);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    onTabChange();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20),
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
                    ),
                  ),
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
                        onPageChange(index);
                      },
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: SignUpPhoneForm(
                            onSignUpWithPhone,
                            onFacebookSignIn,
                            onGoogleSignIn,
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: SignUpEmailForm(
                            onSignUpByEmail,
                            onFacebookSignIn,
                            onGoogleSignIn,
                          ),
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
