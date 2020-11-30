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
  final PageController _pageController = PageController(initialPage: 0);
  TabController _tabController;
  bool isPageCanChanged = true;

  onGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    await AuthProvider().signInWithGoogle(context).then((value) {
      if (value == null) {
        Navigator.pop(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacementNamed(context, BottomNavigationView);
      }
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
      ReuseAlertDialog().successDialog(context, onError);
    });
  }

  onFacebookSignIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthProvider().signInFacebook(context).then((value) {
        // if (value == null) {
        //   setState(() {
        //     _isLoading = false;
        //   });
        // } else {
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   //Navigator.pushReplacementNamed(context, BottomNavigationView);
        // }
      });
    } on PlatformException catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  onApiSignInByEmail(String _email, String _password) async {
    setState(() {
      _isLoading = true;
    });
    await AuthProvider()
        .signInByEmail(_email, _password, context)
        .then((onValue) {
      if (onValue != null) {
        setState(() {
          _isLoading = false;
        });
        ReuseAlertDialog().successDialog(context, onValue);
      }
    }).catchError((onError) {
    });
  }

  onApiSignInByPhone(String _phone, String _password) async {
    setState(() {
      _isLoading = true;
    });

    await AuthProvider()
        .signInByPhone("+855" + _phone, _password, context)
        .then((value) {
      if (value != null) {
        setState(() {
          _isLoading = false;
        });
        ReuseAlertDialog().successDialog(context, value);
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
      await _pageController.animateToPage(index, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
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
    _tabController.dispose();
    //print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
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
              )),
              SizedBox(
                height: 40,
              ),
              ReuseAuthTab(
                _tabController,
                _lang.translate('phone'),
                _lang.translate('email'),
              ),
              // tabs(context),
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
