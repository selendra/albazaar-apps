import 'package:albazaar_app/core/components/countries.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/scaffold.dart';
import 'package:albazaar_app/ui/screens/signin/components/singIn_body.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {


  Backend _backend = Backend();

  PostRequest _postRequest = PostRequest();

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
      // if (_signInModel)
      // print("My controller ${_signInModel.label}");
      // if (_signInModel.tabController.indexIsChanging) {
      //   setState(() {
      //   });
      // }
      onPageChange(_signInModel.tabController.index, p: _signInModel.pageController);
    });
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if ( index == 1 ){
      clearInput();
      // _signInModel.enable = false;
      _signInModel.label = "email";
    } else {
      clearInput();
      // _signInModel.enable = false;
      _signInModel.label = "phone";
    }
    setState(() {});
  }

  void showPassword() {
    setState(() {
      _signInModel.hidePassword  = !_signInModel.hidePassword;
    });
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
    _signInModel.formKey.currentState.validate();
  }

  void onChangedCountryCode(String code){
    if (code != null){
      setState(() {
        _signInModel.countryCode = code;
      });
    }
  }

  void onSubmit(){

  }

  String validateInput(String value) { /* Initial Validate */
    print("My lable ${_signInModel.label}");
    if (_signInModel.label == "email") {
      if (_signInModel.emailNode.hasFocus) {
        /* If Email Field Has Focus */
        _signInModel.phoneNMailValidate = instanceValidate.validateEmails(value);
        if (_signInModel.phoneNMailValidate == null && _signInModel.passwordValidate == null)
          enableButton();
        else if (_signInModel.enable == true)
          setState(() => _signInModel.enable = false);
      }
    } else {
      if (_signInModel.phoneNode.hasFocus) {
        /* If Phone Number Field Has Focus */
        _signInModel.phoneNMailValidate = instanceValidate.validatePhone(value);
        if (_signInModel.phoneNMailValidate == null && _signInModel.passwordValidate == null)
          enableButton();
        else if (_signInModel.enable == true)
          setState(() => _signInModel.enable = false);
      }
    }
    return _signInModel.phoneNMailValidate;
  }

  String validatePassword(String value) { /* Validate User Password Input */
    if (_signInModel.passwordNode.hasFocus) {
      _signInModel.passwordValidate = instanceValidate.validatePassword(value);
      if (
        _signInModel.phoneNMailValidate == null &&
        _signInModel.passwordValidate == null
      ) enableButton();
      else if (_signInModel.enable == true) setState(() => _signInModel.enable = false);
    }
    return _signInModel.passwordValidate;
  }

  void enableButton() { /* Validate Button */
    if (_signInModel.label == 'email') {
      if (_signInModel.email.text != '' &&
          _signInModel.password.text != '')
        setState(() => _signInModel.enable = true);
    } else {
      if (_signInModel.phone.text != '' &&
          _signInModel.password.text != '')
        setState(() => _signInModel.enable = true);
    }
  }

  Future<void> loginByPhone() async {
    
    // Rest Api
    await _postRequest.loginByPhone(_signInModel.phone.text, _signInModel.password.text).then((value) async {
      
        _backend.response = value;
        if (_backend.response != null) {
          // Navigator.pop(context);
          _backend.mapData = json.decode(_backend.response.body);
        }
        await navigator();
    });

  }

  Future<void> loginByEmail() async {

    // Rest Api
    await _postRequest.loginByEmail(_signInModel.email.text, _signInModel.password.text).then((value) async {
      
        _backend.response = value;
        if (_backend.response != null) {
          // Navigator.pop(context);
          _backend.mapData = json.decode(_backend.response.body);
        }
        await navigator();
    });
  }

  Future<void> navigator() async {

    // Close Loading
    Navigator.pop(context);

    if (_backend.response.statusCode != 502) {
      if (_backend.mapData.containsKey("error")) {
        await Components.dialog( context, textAlignCenter(text: _backend.mapData['error']["message"]), textMessage());
      } else { 
        // If Successfully
        if (_backend.mapData.containsKey("token")) {
          _backend.mapData.addAll({
            "isLoggedIn": true
          });
          await StorageServices.setData(_backend.mapData, 'user_token');
          
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            ModalRoute.withName('/')
          );
        }
        // If Incorrect Email 
        else { 
          await Components.dialog( context, textAlignCenter(text: _backend.mapData["message"]), textMessage());
        }
      }
    } else {
      await Components.dialog(context, textAlignCenter(text: "Something gone wrong !"), textMessage());
    }
  }

  void clearInput(){
    _signInModel.email.clear();
    _signInModel.phone.clear();
    _signInModel.password.clear();

    _signInModel.emailNode.unfocus();
    _signInModel.phoneNode.unfocus();
    _signInModel.passwordNode.unfocus();

    _signInModel.phoneNMailValidate = null;
    _signInModel.passwordValidate = null;
  }

  @override
  void initState() {
    super.initState();
    _signInModel.tabController = TabController(vsync: this, length: 2);
    _signInModel.label = "phone";
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
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: MyBodyScaffold(
        // padding: const EdgeInsets.fromLTRB(35, 35, 35, 35),
        height: MediaQuery.of(context).size.height,
        scroll: BouncingScrollPhysics(),
        child: Form(
          key: _signInModel.formKey,
          child: Column(
            children: [
              Expanded(
                child: SignInBody(
                  signInModel: _signInModel,
                  onApiSignInByPhone: onApiSignInByPhone,
                  onFacebookSignIn: onFacebookSignIn,
                  onGoogleSignIn: onGoogleSignIn,
                  onApiSignInByEmail: onApiSignInByEmail,
                  onPageChange: onPageChange,
                  onChangedCountryCode: onChangedCountryCode,
                  validateInput:  validateInput,
                  validatePassword:  validatePassword,
                  showPassword: showPassword,
                  onChanged: onChanged,
                  onSubmit: onSubmit
                )
              )
            ],
          )
        )
      )
    );
  }
}
