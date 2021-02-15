import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/components/flat_button.dart';
import 'package:selendra_marketplace_app/core/models/sign_in_m.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';

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
    if (p != null) {
      _signInModel.isPageCanChanged = false;
      await _signInModel.pageController.animateToPage(index,
          duration: Duration(milliseconds: 400), curve: Curves.easeOut);
      _signInModel.isPageCanChanged = true;
    } else {
      _signInModel.tabController.animateTo(index);
    }
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

  void onChanged(String value){
    if (_signInModel.tabController.index == 0) _signInModel.phoneFormKey.currentState.validate();
    else if (_signInModel.tabController.index == 1) _signInModel.emailFormKey.currentState.validate();
  }

  void onSubmit(String value){

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

        Row(
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
                          _lang.translate('signin_string'),
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
        ),

        Expanded(
          child: Container()
        ),

        Container(
          margin: EdgeInsets.only(bottom: 25),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ReuseAuthTab(
              _signInModel.tabController,
              _lang.translate('phone'),
              _lang.translate('email'),
            )
          )
        ),
        // tabs(context),

        Expanded(
          flex: 2,
          // height: 200,
          // padding: EdgeInsets.only(bottom: 12),
          child: PageView(
            controller: _signInModel.pageController,
            onPageChanged: (index) {
              if (_signInModel.isPageCanChanged) {
                onPageChange(index);
              }
            },
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
              ),
            ],
          )
        ),

        Container(
          margin: EdgeInsets.only(bottom: 25),
          alignment: Alignment.centerRight,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
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

        MyFlatButton(
          // edgeMargin: EdgeInsets.only(bottom: 25),
          textButton: _lang.translate('signin_string'),
          edgePadding: EdgeInsets.only(left: 78, right: 78),
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
              // facebookSignIn();
              }, 
              'images/facebook.svg'
            ),
            SizedBox(width: 20),
            BtnSocial(() {
              // googleSignIn();
            }, 'images/google.svg'),
          ],
        ),

        SizedBox(height: 10),
        ReuseFlatButton.getItem(
          _lang.translate('haven\'t_had_account'),
          AppLocalizeService.of(context).translate('signup_string'), () {
            Navigator.pushReplacementNamed(context, SignUpView);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => SignUpScreen()));
          }
        )
      ],
    );
    // SafeArea(
    //   child: Container(
    //     height: MediaQuery.of(context).size.height,
    //     width: MediaQuery.of(context).size.width,
    //     margin: const EdgeInsets.all(20),
    //     padding: const EdgeInsets.symmetric(vertical: 20),
    //     child: _signInModel.isLoading
    //     ? Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     : Column(
    //       children: <Widget>[
    //         Container(
    //             child: Image.asset(
    //           'images/logo.png',
    //           height: 80,
    //           width: 80,
    //         )),
    //         SizedBox(
    //           height: 40,
    //         ),
    //         ReuseAuthTab(
    //           _signInModel.tabController,
    //           _lang.translate('phone'),
    //           _lang.translate('email'),
    //         ),
    //         // tabs(context),
    //         SizedBox(
    //           height: 40,
    //         ),
    //         Expanded(
    //           child: PageView(
    //             controller: _signInModel.pageController,
    //             onPageChanged: (index) {
    //               if (_signInModel.isPageCanChanged) {
    //                 onPageChange(index);
    //               }
    //             },
    //             children: [
    //               SignInPhoneForm(
    //                 onApiSignInByPhone,
    //                 onFacebookSignIn,
    //                 onGoogleSignIn,
    //               ),
    //               SignInEmailForm(
    //                 onApiSignInByEmail,
    //                 onFacebookSignIn,
    //                 onGoogleSignIn,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
