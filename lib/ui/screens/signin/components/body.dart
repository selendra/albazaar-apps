import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/component.dart';
import 'package:albazaar_app/core/models/sign_in_m.dart';
import 'package:albazaar_app/core/services/app_services.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {

  SignInModel _signInModel = SignInModel();

  onGoogleSignIn() async {
    setState(() {
      _signInModel.isLoading = true;
    });
    await AuthProvider().signInWithGoogle(context).then((value) {
      if (value == null) {
        setState(() {
          _signInModel.isLoading = false;
        });
      } else {
        Provider.of<AuthProvider>(context, listen: false)
            .getTokenForGoogle(value, context);
      }
    }).catchError((onError) {
      setState(() {
        _signInModel.isLoading = false;
      });
      ReuseAlertDialog().successDialog(context, onError);
    });
  }

  onFacebookSignIn() async {
    setState(() {
      _signInModel.isLoading = true;
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
      _signInModel.isLoading = true;
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
      _signInModel.isLoading = true;
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
    _signInModel.tabController.addListener(() {
      if (_signInModel.tabController.indexIsChanging) {
        setState(() {
          onPageChange(_signInModel.tabController.index, p: _signInModel.pageController);
        });
      }
    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    print("My index"+index.toString());
    print("Index ${_signInModel.tabController.index}");
    if ( index == 1 ){
      _signInModel.phone.clear();
      _signInModel.phoneNode.unfocus();
      // _signInModel.enable = false;
      // _signInModel.label = "email";
    } else {
      _signInModel.email.clear();
      _signInModel.emailNode.unfocus();
      // _signInModel.enable = false;
      // _signUpM.label = "phone";
    }
    setState(() {});

    // if (p != null) {
    //   _signInModel.isPageCanChanged = false;
    //   await _signInModel.pageController.animateToPage(index,
    //       duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    //   _signInModel.isPageCanChanged = true;
    // } else {
    //   _signInModel.tabController.animateTo(index);
    // }
  }

  //This function is use to set initial tab when setstate
  void setInitialTab() {
    setState(() {
      _signInModel.tabController.index = 0;
    });
  }

  //This function is use to stop loading circle indicator
  void stopLoading() {
    setState(() {
      _signInModel.isLoading = false;
    });
  }

  String validateInput(String value) { /* Initial Validate */
    // if (_signInModel.label == "email") {
    //   if (_signInModel.nodeEmails.hasFocus) {
    //     /* If Email Field Has Focus */
    //     _signInModel.responseEmailPhone = instanceValidate.validateEmails(value);
    //     if (_signInModel.responseEmailPhone == null && _signInModel.responsePassword == null)
    //       enableButton();
    //     else if (_signInModel.enable == true)
    //       setState(() => _signInModel.enable = false);
    //   }
    // } else {
    //   if (_signInModel.nodePhoneNums.hasFocus) {
    //     /* If Phone Number Field Has Focus */
    //     _signInModel.responseEmailPhone = instanceValidate.validatePhone(value);
    //     if (_signInModel.responseEmailPhone == null && _signInModel.responsePassword == null)
    //       enableButton();
    //     else if (_signInModel.enable == true)
    //       setState(() => _signInModel.enable = false);
    //   }
    // }
    // return _signInModel.responseEmailPhone;
  }

  String validatePassword(String value) { /* Validate User Password Input */
    // if (_signInModel.passwordNode.hasFocus) {
    //   _signInModel.passwordValidate = instanceValidate.validatePassword(value);
    //   if (
    //     _signInModel.phone == null &&
    //     _signInModel.passwordValidate == null
    //   ) enableButton();
    //   else if (_signInModel.enable == true) setState(() => _signInModel.enable = false);
    // }
    // return _signInModel.passwordValidate;
  }

  void onChanged(String value){
    _signInModel.formKey.currentState.validate();
    // if (_signInModel.tabController.index == 0) _signInModel.phoneFormKey.currentState.validate();
    // else if (_signInModel.tabController.index == 1) _signInModel.emailFormKey.currentState.validate();
  }

  void onSubmit(){

  }

  @override
  void initState() {
    super.initState();
    _signInModel.tabController = TabController(vsync: this, length: 2);
    onTabChange();
  }

  @override
  void dispose() {
    _signInModel.pageController.dispose();
    _signInModel.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Column(
      children: [

        MyPadding(
          pTop: pd35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      // padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Text(
                            _lang.translate('signin_string'),
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Albazaar',
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
                child: SvgPicture.asset('assets/sld_logo.svg', alignment: Alignment.centerRight, width: 90, height: 107.37),
              ),
            ],
          )
        ),

        Flexible(
          child: MyPadding(
            child: Container()
          )
        ),

        Container(
          child: MyPadding(
            pBottom: 25,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ReuseAuthTab(
                _signInModel.tabController,
                _lang.translate('phone'),
                _lang.translate('email'),
                onPageChange
              )
            )
          )
        ),
        // tabs(context),

        Expanded(
          child: MyPadding(
            child: Form(
              key: _signInModel.formKey,
              child: TabBarView(
                controller: _signInModel.tabController,
                children: [
                  
                  SignInPhoneForm(
                    signInPhoneFunc: onApiSignInByPhone,
                    facebookSignIn: onFacebookSignIn,
                    googleSignIn: onGoogleSignIn,
                    signInModel: _signInModel,
                    onChanged: onChanged,
                    onSubmit: onSubmit,
                  ),

                  SignInEmailForm(
                    signInEmailFunc: onApiSignInByEmail,
                    faceBookSignIn: onFacebookSignIn,
                    googleSignIn: onGoogleSignIn,
                    signInModel: _signInModel,
                    onChanged: onChanged,
                    onSubmit: onSubmit,
                  )
                ],
              )
            )
          ),
        ),
        
        Container(
          alignment: Alignment.centerRight,
          child: MyPadding(
            pLeft: 10, pTop: 10, pBottom:10,
            child: TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.push(
                    context, RouteAnimation(enterPage: ResetPassPhone()));
              },
              child: MyText(
                text: _lang.translate('forget_password'),
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
          ),
        ),

        MyFlatButton(
          // edgeMargin: EdgeInsets.only(bottom: 25),
          child: MyText(
            pTop: 20,
            pBottom: 20,
            text: _lang.translate('signin_string'),
            color: "#FFFFFF",
          ),
          edgePadding: EdgeInsets.only(left: 78 + pd35, right: 78+ pd35),
          action: (){
          // validateAndSubmit();
          },
        ),
        
        Flexible(
          child: MyPadding(
            child: Align(
              alignment: Alignment.center,
              child: Text(
              _lang.translate('or_string'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            )
          )
        ),

        MyPadding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BtnSocial(
                () {
                // facebookSignIn();
                }, 
                'assets/facebook.svg'
              ),
              SizedBox(width: 20),
              BtnSocial(() {
                // googleSignIn();
              }, 'assets/google.svg'),
            ],
          )
        ),

        SizedBox(height: 10),
        MyPadding(
          child: ReuseFlatButton.getItem(
            _lang.translate('haven\'t_had_account'),
            AppLocalizeService.of(context).translate('signup_string'), () {

              FocusScope.of(context).unfocus();
              Navigator.pushReplacementNamed(context, SignUpView);
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => SignUpScreen()));
            }
          )
        )
      ],
    );
  }
}
