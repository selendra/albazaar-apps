import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/components/component.dart';
import 'package:selendra_marketplace_app/core/models/sign_up_m.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  
  SignUpModel _signUpModel = SignUpModel();

  bool _isLoading = false, isPageCanChanged = true;
  String alertText;

  onSignUpByEmail(
      String _email, String _password, String _confirmPassword) async {
    setState(() {
      _isLoading = true;
    });
    if (_password != _confirmPassword) {
      await Components.dialog(
          context, Text("Password does not match"), Text("Message"));
      setState(() {
        _isLoading = false;
      });
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
    setState(() {
      _isLoading = true;
    });

    if (_password != _confirmPassword) {
      await Components.dialog(
          context, Text("Password does not match"), Text("Message"));
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await AuthProvider()
            .signUpByPhone(_phone, _password, context)
            .then((value) async {
          if (value == 'Successfully registered!') {
            setState(() {
              _isLoading = false;
            });
            await ReuseAlertDialog().successDialog(context, value);
            await Navigator.push(context,
                RouteAnimation(enterPage: OTPScreen(_phone, _password)));
          } else {
            setState(() {
              _isLoading = false;
            });
            // Already Register
            await ReuseAlertDialog().successDialog(context, value);
          }
        });
      } on SocketException catch (e) {
        await Components.dialog(
            context,
            Text(e.message.toString(), textAlign: TextAlign.center),
            Text("Message"));

        setState(() {
          _isLoading = false;
        });
      } on FormatException catch (e) {
        await Components.dialog(
            context,
            Text(e.message.toString(), textAlign: TextAlign.center),
            Text("Message"));

        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  onGoogleSignUp() async {
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

  onFacebookSignUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthProvider().signInFacebook(context).then((value) {
        if (value == null) {
          setState(() {
            _isLoading = false;
          });
        } else {
          Provider.of<AuthProvider>(context, listen: false)
              .getTokenForFb(value, context);
        }
      });
    } on PlatformException catch (e) {
      setState(() {
        _isLoading = false;
      });
    } finally {
      stopLoading();
    }
  }

  onTabChange() {
    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) {
    //     setState(() {
    //       onPageChange(_tabController.index, p: _pageController);
    //     });
    //   }
    // });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    // if (p != null) {
    //   isPageCanChanged = false;
    //   await _pageController.animateToPage(index,
    //       duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    //   isPageCanChanged = true;
    // } else {
    //   _tabController.animateTo(index);
    // }
  }

  //This function is use to set initial tab when setstate
  void setInitialTab() {
    setState(() {
      _signUpModel.tabController.index = 0;
    });
  }

  //This function is use to stop loading circle indicator
  void stopLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  void onChanged(String value){
    // if (_signUpModel.tabController.index == 0) _signUpModel.phoneFormKey.currentState.validate();
    // else if (_signUpModel.tabController.index == 1) _signUpModel.emailFormKey.currentState.validate();
  }

  void onSubmit(){

  }

  @override
  void initState() {
    super.initState();
    _signUpModel.tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    onTabChange();
  }

  @override
  void dispose() {
    _signUpModel.pageController.dispose();
    _signUpModel.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Column(
      children: [

        PaddingScaffold(
          pTop: pd35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      // padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Text(
                            _lang.translate('signup_string'),
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                      onTap: (){
                        
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Selendra Marketplace',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: kDefaultColor,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ),

              Expanded(
                flex: 1,
                child: SvgPicture.asset('images/sld_logo.svg', alignment: Alignment.centerRight, width: 90, height: 107.37),
              ),
            ],
          )
        ),

        Flexible(
          child: PaddingScaffold(
            pBottom: 25,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ReuseAuthTab(
                _signUpModel.tabController,
                _lang.translate('phone'),
                _lang.translate('email'),
                onPageChange
              )
            ),
          )
        ),
        // tabs(context),
        Container(
          height: 300,
          child: PaddingScaffold(
            child: Form(
              key: _signUpModel.emailFormKey,
              child: TabBarView(
                  controller: _signUpModel.tabController,
                  children: [
                    
                    SignUpPhoneForm(
                      signUpPhoneFunc: onSignUpWithPhone,
                      facebookSignUp: onFacebookSignUp,
                      googleSignUp: onGoogleSignUp,
                      signUpModel: _signUpModel,
                      onChanged: onChanged,
                      onSubmit: onSubmit,
                    ),

                    SignUpEmailForm(
                      signUpEmailFunc: onSignUpByEmail,
                      faceBookSignUp: onFacebookSignUp,
                      googleSignUp: onGoogleSignUp,
                      signUpModel: _signUpModel,
                      onChanged: onChanged,
                      onSubmit: onSubmit,
                    ),
                    
                  ],
                )
              )
          ),
        ),

        MyFlatButton(
          // edgeMargin: EdgeInsets.only(bottom: 25),
          child: MyText(
            pTop: 20,
            pBottom: 20,
            text: _lang.translate('signup_string'),
            color: "#FFFFFF",
          ),
          edgePadding: EdgeInsets.only(left: 78 + pd35, right: 78+ pd35),
          action: (){
          // validateAndSubmit();
          },
        ),
        
        Flexible(
          child: Align(
            alignment: Alignment.center,
            child: Text(
            _lang.translate('or_string'),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          )
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BtnSocial(
              () {
              // facebookSignUp();
              }, 
              'images/icons/facebook.svg'
            ),
            SizedBox(width: 20),
            BtnSocial(() {
              // googleSignUp();
            }, 'images/icons/google.svg'),
          ],
        ),

        SizedBox(height: 10),
        PaddingScaffold(
          child: ReuseFlatButton.getItem(
            _lang.translate('had_an_account'),
            AppLocalizeService.of(context).translate('signin_string'), () {
              Navigator.pushReplacementNamed(context, SignUpView);
            }
          ),
        )
      ],
    );
  }
}
