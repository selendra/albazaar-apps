import 'package:flutter/material.dart';
import 'package:albazaar_app/ui/screens/signup/components/signUp_body.dart';
import 'package:albazaar_app/all_export.dart';

class SignUp extends StatefulWidget{
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {

  SignUpModel _signUpModel = SignUpModel();

  bool _isLoading = false, isPageCanChanged = true;
  String alertText;

  onApiSignUpByEmail(
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
                  MaterialPageRoute(builder: (context) => SignUp()),
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

  Future<void> onApiSignUpByPhone(
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
    _signUpModel.tabController.addListener(() {
      // if (_signInModel)
      // print("My controller ${_signInModel.label}");
      // if (_signInModel.tabController.indexIsChanging) {
      //   setState(() {
      //   });
      // }
      onPageChange(_signUpModel.tabController.index, p: _signUpModel.pageController);
    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if ( index == 1 ){
      clearInput();
      // _signInModel.enable = false;
      _signUpModel.label = "email";
    } else {
      clearInput();
      // _signInModel.enable = false;
      _signUpModel.label = "phone";
    }
    setState(() {});
  }


  void onChangedCountryCode(String code){
    if (code != null){
      setState(() {
        _signUpModel.countryCode = code;
      });
    }
  }

  void showPassword() {
    setState(() {
      _signUpModel.hidePassword  = !_signUpModel.hidePassword;
    });
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
    _signUpModel.formKey.currentState.validate();
  }

  void onSubmit(){

  }

  // Validator
  String validateInput(String value) { /* Initial Validate */
    print("My lable ${_signUpModel.label}");
    if (_signUpModel.label == "email") {
      if (_signUpModel.emailNode.hasFocus) {
        /* If Email Field Has Focus */
        _signUpModel.phoneNMailValidate = instanceValidate.validateEmails(value);
        if (_signUpModel.phoneNMailValidate == null && _signUpModel.passwordValidate == null)
          enableButton();
        else if (_signUpModel.enable == true)
          setState(() => _signUpModel.enable = false);
      }
    } else {
      if (_signUpModel.phoneNode.hasFocus) {
        /* If Phone Number Field Has Focus */
        _signUpModel.phoneNMailValidate = instanceValidate.validatePhone(value);
        if (_signUpModel.phoneNMailValidate == null && _signUpModel.passwordValidate == null)
          enableButton();
        else if (_signUpModel.enable == true)
          setState(() => _signUpModel.enable = false);
      }
    }
    return _signUpModel.phoneNMailValidate;
  }

  String validatePassword(String value) { /* Validate User Password Input */
    if (_signUpModel.passwordNode.hasFocus) {
      _signUpModel.passwordValidate = instanceValidate.validatePassword(value);
      if (
        _signUpModel.phoneNMailValidate == null &&
        _signUpModel.passwordValidate == null
      ) enableButton();
      
      else if (_signUpModel.enable == true) setState(() => _signUpModel.enable = false);
    }
    return _signUpModel.passwordValidate;
  }

  String validateConPassword(String value) { /* Validate User Password Input */
    print("My value$value");
    if (_signUpModel.confirmPasswordNode.hasFocus) {

      _signUpModel.conPasswordValidate= instanceValidate.validatePassword(value);
        if (
          _signUpModel.phoneNMailValidate == null &&
          _signUpModel.conPasswordValidate == null
        ) enableButton();

        else if (_signUpModel.enable == true) setState(() => _signUpModel.enable = false);
    }
    return _signUpModel.conPasswordValidate;
  }

  void enableButton() { /* Validate Button */
    if (_signUpModel.label == 'email') {
      if (_signUpModel.email.text != '' && _signUpModel.password.text != '' && _signUpModel.confirmPassword.text.isNotEmpty) {
        matchPassword();
      }
    } else {
      if (_signUpModel.phone.text != '' && _signUpModel.password.text != '' && _signUpModel.confirmPassword.text.isNotEmpty)
        matchPassword();
    }
  }

  void matchPassword(){

    // Check Password Match With Confirm Password
    if (_signUpModel.password.text == _signUpModel.confirmPassword.text) {

      print("Match");
      if(_signUpModel.passwordNode.hasFocus){
        _signUpModel.conPasswordValidate = null;
        onChanged(_signUpModel.confirmPassword.text);
      }
      _signUpModel.enable = true;
    }
    else {
      print("Notmatch");
      if (_signUpModel.enable) _signUpModel.enable = false;
      _signUpModel.conPasswordValidate = "Password does not match";
      onChanged(_signUpModel.confirmPassword.text);
    }
  }

  void clearInput(){
    _signUpModel.email.clear();
    _signUpModel.phone.clear();
    _signUpModel.password.clear();

    _signUpModel.emailNode.unfocus();
    _signUpModel.phoneNode.unfocus();
    _signUpModel.passwordNode.unfocus();

    _signUpModel.phoneNMailValidate = null;
    _signUpModel.passwordValidate = null;
  }

  @override
  void initState() {
    super.initState();
    _signUpModel.label = 'phone';
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
    return DefaultTabController(
      length: 2, 
      child: MyBodyScaffold(
        height: MediaQuery.of(context).size.height,
        scroll: BouncingScrollPhysics(),
        child: Form(
          key: _signUpModel.formKey,
          child: SignUpBody(
            signUpModel: _signUpModel,
            onApiSignUpByPhone: onApiSignUpByPhone,
            onFacebookSignUp: onFacebookSignUp,
            onGoogleSignUp: onGoogleSignUp,
            onApiSignUpByEmail: onApiSignUpByEmail,
            onPageChange: onPageChange,
            onChangedCountryCode: onChangedCountryCode,
            validateInput:  validateInput,
            validatePassword:  validatePassword,
            validateConPassword:  validateConPassword,
            showPassword: showPassword,
            onChanged: onChanged,
            onSubmit: onSubmit
          )
        )
      )
    );
  }
}
