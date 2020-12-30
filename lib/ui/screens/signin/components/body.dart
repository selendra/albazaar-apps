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
  bool _hovering;

  onGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    await AuthProvider().signInWithGoogle(context).then((value) {
      if (value == null) {
        setState(() {
          _isLoading = false;
        });
      } else {
        Provider.of<AuthProvider>(context, listen: false)
            .getTokenForGoogle(value, context);
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
        if (value == null) {
          stopLoading();
        } else {
          Provider.of<AuthProvider>(context, listen: false)
              .getTokenForFb(value, context);
        }
      });
    } on PlatformException catch (e) {
      stopLoading();
    }
  }

  onApiSignInByEmail(String _email, String _password) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthProvider()
          .signInByEmail(_email, _password, context)
          .then((onValue) {
        if (onValue != null) {
          ReuseAlertDialog().successDialog(context, onValue);
        }
      }).catchError((onError) {});
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

  onApiSignInByPhone(String _phone, String _password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await AuthProvider()
          .signInByPhone(
              "+855" + AppServices.removeZero(_phone), _password, context)
          .then((value) {
        if (value != null) {
          ReuseAlertDialog().successDialog(context, value);
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
      stopLoading();
    }
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

  //This function is use to set initial tab when setstate
  void setInitialTab() {
    setState(() {
      _tabController.index = 0;
    });
  }

  //This function is use to stop loading circle indicator
  void stopLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  void _mouseHover(bool hover) {
    setState(() {
      _hovering = hover;
    });
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
            mobile: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image.network(
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
                                //letterSpacing: 0.7,
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
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
                                      constraints:
                                          const BoxConstraints.expand(),
                                      child: SingleChildScrollView(
                                        child: Card(
                                          //semanticContainer: ,
                                          shape: kDefaultShape,
                                          child: Container(
                                            //width: 50,
                                            // width: double.infinity,
                                            margin: EdgeInsets.all(20.0),
                                            child: SignInPhoneForm(
                                              onApiSignInByPhone,
                                              onFacebookSignIn,
                                              onGoogleSignIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints.expand(),
                                      child: SingleChildScrollView(
                                        child: Card(
                                          shape: kDefaultShape,
                                          child: Container(
                                            margin: const EdgeInsets.all(20.0),
                                            child: SignInEmailForm(
                                              onApiSignInByEmail,
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
            ),
            desktop: SingleChildScrollView(
              child: Row(
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
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: 400,

                      //color: kDefaultColor,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        //mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Container(
                          //     child: Image.asset(
                          //   'images/logo.png',
                          //   height: 80,
                          //   width: 80,
                          // )),
                          SizedBox(
                            height: 80,
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
                                  child: Responsive(
                                    mobile: SingleChildScrollView(
                                      child: Card(
                                        shape: kDefaultShape,
                                        child: Container(
                                          margin: EdgeInsets.all(20.0),
                                          child: SignInPhoneForm(
                                            onApiSignInByPhone,
                                            onFacebookSignIn,
                                            onGoogleSignIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    desktop: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Card(
                                        semanticContainer: true,
                                        shape: kDefaultShape,
                                        margin: const EdgeInsets.all(20.0),
                                        child: SignInPhoneDesktop(
                                          onApiSignInByPhone,
                                          onFacebookSignIn,
                                          onGoogleSignIn,
                                          _mouseHover,
                                          _hovering,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: Responsive(
                                    mobile: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.47,
                                      child: SingleChildScrollView(
                                        child: Card(
                                          shape: kDefaultShape,
                                          child: Container(
                                            margin: EdgeInsets.all(20.0),
                                            child: SignInEmailForm(
                                              onApiSignInByEmail,
                                              onFacebookSignIn,
                                              onGoogleSignIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    desktop: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Card(
                                        semanticContainer: true,
                                        shape: kDefaultShape,
                                        margin: const EdgeInsets.all(20.0),
                                        child: SignInEmailDesktop(
                                          onApiSignInByEmail,
                                          onFacebookSignIn,
                                          onGoogleSignIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // ConstrainedBox(
                                //   constraints: const BoxConstraints.expand(),
                                //   child: Responsive(
                                //     mobile: SingleChildScrollView(
                                //       child: Card(
                                //         shape: kDefaultShape,
                                //         child: SignInEmailForm(
                                //           onApiSignInByEmail,
                                //           onFacebookSignIn,
                                //           onGoogleSignIn,
                                //         ),
                                //       ),
                                //     ),
                                //     desktop: SizedBox(
                                //       width:
                                //           MediaQuery.of(context).size.width / 4,
                                //       child: Card(
                                //         semanticContainer: true,
                                //         shape: kDefaultShape,
                                //         child: Container(
                                //           margin: const EdgeInsets.all(20.0),
                                //           child: SignInEmailDesktop(
                                //             onApiSignInByEmail,
                                //             onFacebookSignIn,
                                //             onGoogleSignIn,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
      ),
    );
    // return Align(
    //   alignment: isDesktop ? Alignment.centerRight : Alignment.center,
    //   child: Container(
    //     height: MediaQuery.of(context).size.height,
    //     width: isDesktop
    //         ? MediaQuery.of(context).size.width * 0.3
    //         : MediaQuery.of(context).size.width,
    //     margin: const EdgeInsets.all(20),
    //     color: kDefaultColor,
    //     padding: const EdgeInsets.symmetric(vertical: 20),
    //     child: _isLoading
    //         ? Center(
    //             child: CircularProgressIndicator(),
    //           )
    //         : Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               Container(
    //                   child: Image.asset(
    //                 'images/logo.png',
    //                 height: 80,
    //                 width: 80,
    //               )),
    //               SizedBox(
    //                 height: 40,
    //               ),
    //               ReuseAuthTab(
    //                 _tabController,
    //                 _lang.translate('phone'),
    //                 _lang.translate('email'),
    //               ),
    //               // tabs(context),
    //               SizedBox(
    //                 height: 40,
    //               ),
    //               Expanded(
    //                 flex: 2,
    //                 child: PageView(
    //                   controller: _pageController,
    //                   onPageChanged: (index) {
    //                     if (isPageCanChanged) {
    //                       onPageChange(index);
    //                     }
    //                   },
    //                   children: [
    //                     ConstrainedBox(
    //                       constraints: const BoxConstraints.expand(),
    //                       child: Responsive(
    //                         mobile: SingleChildScrollView(
    //                           child: Card(
    //                             //semanticContainer: ,
    //                             shape: kDefaultShape,
    //                             child: Container(
    //                               //width: 50,
    //                               // width: double.infinity,
    //                               margin: EdgeInsets.all(20.0),
    //                               child: SignInPhoneForm(
    //                                 onApiSignInByPhone,
    //                                 onFacebookSignIn,
    //                                 onGoogleSignIn,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         desktop: SizedBox(
    //                           width: MediaQuery.of(context).size.width / 4,
    //                           child: Card(
    //                             semanticContainer: true,
    //                             shape: kDefaultShape,
    //                             margin: EdgeInsets.all(20.0),
    //                             child: SignInPhoneDesktop(
    //                               onApiSignInByPhone,
    //                               onFacebookSignIn,
    //                               onGoogleSignIn,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     ConstrainedBox(
    //                       constraints: const BoxConstraints.expand(),
    //                       child: Responsive(
    //                         mobile: SignInEmailForm(
    //                           onApiSignInByEmail,
    //                           onFacebookSignIn,
    //                           onGoogleSignIn,
    //                         ),
    //                         desktop: SignInEmailDesktop(
    //                           onApiSignInByEmail,
    //                           onFacebookSignIn,
    //                           onGoogleSignIn,
    //                         ), //emailForm(),,//emailForm(),,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //   ),
    // );
  }

  desktopSignIn(bool isDesktop) {}
}
