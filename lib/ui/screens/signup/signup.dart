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

  onTabChange() {
    _signUpModel.tabController.addListener(() {
      onPageChange(_signUpModel.tabController.index, p: _signUpModel.pageController);
    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if ( index == 1 ){
      clearInput();
      // _signUpModel.enable = false;
      _signUpModel.label = "email";
    } else {
      clearInput();
      // _signUpModel.enable = false;
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

  void onSubmit(String value){

    if (
      _signUpModel.label == 'phone' && _signUpModel.phoneNode.hasFocus || 
      _signUpModel.label == 'email' && _signUpModel.emailNode.hasFocus){
      FocusScope.of(context).requestFocus(_signUpModel.passwordNode);
    } else if (_signUpModel.passwordNode.hasFocus){
      FocusScope.of(context).requestFocus(_signUpModel.confirmPasswordNode);
    } else if (_signUpModel.confirmPasswordNode.hasFocus){
      onApiSignUp();
    }
  }

  // Validator
  String validateInput(String value) { /* Initial Validate */
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
    if(value != "matching"){
      if (_signUpModel.confirmPasswordNode.hasFocus) {

        _signUpModel.conPasswordValidate = instanceValidate.validatePassword(value);
        if (
          _signUpModel.phoneNMailValidate == null &&
          _signUpModel.conPasswordValidate == null
        ) enableButton();

        else if (_signUpModel.enable == true) setState(() => _signUpModel.enable = false);
      }
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

      _signUpModel.conPasswordValidate = null;
      validateConPassword("matching");
      setState(() {
        _signUpModel.enable = true;
      });
    }
    else {
      _signUpModel.conPasswordValidate = "Password does not match";
      validateConPassword("matching");
      if (_signUpModel.enable) {
        setState(() {
          _signUpModel.enable = false;
        });
      }
    }
  }


  signUpByEmail() async {
    setState(() {
      _isLoading = true;
    });
    if (_signUpModel.password.text != _signUpModel.confirmPassword.text) {
      await Components.dialog(
          context, Text("Password does not match"), Text("Message"));
      setState(() {
        _isLoading = false;
      });
      setInitialTab();
    } else {
      try {
        await AuthProvider()
            .signUpByEmail(_signUpModel.email.text, _signUpModel.password.text)
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
          Text("Please check your connection", textAlign: TextAlign.center),
          Text("Oops")
        );
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

  Future<void> signUpByPhone() async {

    setState(() {
      _isLoading = true;
    });

    if (_signUpModel.password.text != _signUpModel.confirmPassword.text) {
      await Components.dialog(
          context, Text("Password does not match"), Text("Message"));
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await AuthProvider()
            .signUpByPhone("+855" + AppServices.removeZero(_signUpModel.phone.text), _signUpModel.password.text, context)
            .then((value) async {
          if (value == 'Successfully registered!') {
            setState(() {
              _isLoading = false;
            });
            await ReuseAlertDialog().successDialog(context, value);
            await Navigator.push(context,
                RouteAnimation(enterPage: OTPScreen("+855" + AppServices.removeZero(_signUpModel.phone.text), _signUpModel.password.text)));
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

  onApiSignUp() async {

    if(_signUpModel.label == 'phone'){
      await signUpByPhone();
    } else {
      await signUpByEmail();
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

  void clearInput(){
    _signUpModel.email.clear();
    _signUpModel.phone.clear();
    _signUpModel.password.clear();
    _signUpModel.confirmPassword.clear();

    FocusScope.of(context).unfocus();

    _signUpModel.phoneNMailValidate = null;
    _signUpModel.passwordValidate = null;

    if (_signUpModel.enable)  _signUpModel.enable = false;
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
            onFacebookSignUp: onFacebookSignUp,
            onGoogleSignUp: onGoogleSignUp,
            onApiSignUp: onApiSignUp,
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
