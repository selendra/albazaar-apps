import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();
  String _token, _alertText;

  PrefService _pref = PrefService();

  getToken() async {
    await _pref.read('token').then((onValue) {
      _token = onValue;
    });
  }

  String get token => _token;

  Future<String> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    print(googleSignInAuthentication.accessToken);
    print(googleSignInAuthentication.idToken);

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    print(user);
    // Provider.of<ProductsProvider>(context, listen: false).getVegi();

    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    //getUserInfo(user);
    Provider.of<UserProvider>(context, listen: false)
        .fetchSocialUserInfo(user.email, user.displayName, user.photoUrl);

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  Future<FirebaseUser> signInFacebook(BuildContext context) async {
    FirebaseUser currentUser;
    // fbLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // if you remove above comment then facebook login will take username and pasword for login in Webview
    try {
      final FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(['email', 'public_profile']);
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);
        print(facebookAccessToken.token);
        final FirebaseUser user =
            (await _auth.signInWithCredential(credential)).user;
        print(credential);
        Provider.of<UserProvider>(context, listen: false)
            .fetchSocialUserInfo(user.email, user.displayName, user.photoUrl);
        print(user.photoUrl);

        assert(user.email != null);
        assert(user.displayName != null);
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        // getUserInfo(user);

        currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);
        return currentUser;
      }
    } catch (e) {
      print(e);
    }
    return currentUser;
  }

  Future<FirebaseUser> get currentUser async {
    return await _auth.currentUser();
  }

  Future<void> signOut(BuildContext context) async {
    mBalance = Balance();
    _pref?.clear('token');
    _pref.clear('seen');
    try {
      FirebaseUser user = await _auth.currentUser();
      for (UserInfo profile in user.providerData) {
        switch (profile.providerId) {
          case 'facebook.com':
            facebookLogin.logOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
            break;
          case 'google.com':
            googleSignIn.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
            break;
          default:
            await _auth.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
            print("User Sign Out");
        }
      }
    } catch (e) {
      signOutByEmail(context);
    }
  }

  //USER SIGN IN USING EMAIL AND PASSWORD
  Future<String> signInByEmail(String email, String password, context) async {
    try {
      var response = await http.post(ApiUrl.LOG_IN_URL,
          headers: ApiHeader.headers,
          body: jsonEncode(<String, String>{
            'email': email,
            'password': password,
          }));
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        _token = responseJson['token'];
        print(_token);
        if (_token != null) {
          _pref.saveString('token', _token);
          Provider.of<UserProvider>(context, listen: false).fetchUserPf(_token);
          // Provider.of<ProductsProvider>(context, listen: false).getVegi();
          Navigator.pushReplacementNamed(context, BottomNavigationView);
        } else {
          _alertText = responseJson['message'];
          if (_alertText == null) {
            _alertText = responseJson['error']['message'];
            print(_alertText);
          }
        }
      } else {
        print(response.body);
      }
      notifyListeners();
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
    return _alertText;
  }

  //USER SIGN IN USING PHONE NUMBER AND PASSWORD
  Future<String> signInByPhone(String phone, String password, context) async {
    var response = await http.post(ApiUrl.LOG_IN_PHONE,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'phone': phone,
          'password': password,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      _token = responseJson['token'];

      if (_token != null) {
        _pref.saveString('token', _token);
        Provider.of<UserProvider>(context, listen: false)
            .fetchPortforlio()
            .then((onValue) {
          if (onValue == '200') {
            Provider.of<UserProvider>(context, listen: false)
                .fetchUserPf(_token);
            Navigator.pushReplacementNamed(context, BottomNavigationView);
          }
        });
      } else {
        try {
          _alertText = responseJson['error']['message'];
        } catch (e) {
          _alertText = responseJson['message'];
        }
      }
    } else {
      print(response.body);
    }
    return _alertText;
  }

  //USER RESET THEIR PASSWORD BY EMAIL
  Future<String> forgetPasswordByEmail(String email) async {
    var response = await http.post(ApiUrl.FORGET_BY_EMAIL,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{'email': email}));
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      _alertText = responseBody['message'];
    } else {
      print(response.body);
    }
    return _alertText;
  }

  //USER RESET THEIR PASSWORD BY PHONE NUMBER
  Future<String> forgetPasswordByPhone(String phoneNumber) async {
    var response = await http.post(
      ApiUrl.FORGET_BY_PHONE,
      headers: ApiHeader.headers,
      body: jsonEncode(
        <String, String>{'phone': '+855' + phoneNumber},
      ),
    );
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      _alertText = responseBody['message'];
    }
    return _alertText;
  }

  //USER SIGN UP THEIR ACCOUNT USING EMAIL AND PASSWORD
  Future<String> signUpByEmail(String email, String password) async {
    var response = await http.post(ApiUrl.SIGN_UP_EMAIL,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      _alertText = responseBody['message'];
    } else {
      print(response.body);
    }

    return _alertText;
  }

  //USER SIGN UP THEIR ACCOUNT USING PHONE AND PASSWORD
  Future<String> signUpByPhone(String phone, String password, context) async {
    var response = await http.post(ApiUrl.SIGN_UP_PHONE,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'phone': phone,
          'password': password,
        }));

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      _alertText = responseBody['message'];

      if (_alertText == 'Successfully registered!') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreen(phone, password)));
      } else {
        return _alertText;
      }
    } else {
      print(response.body);
    }
    return _alertText;
  }

  //ADD PHONE NUMBER TO THEIR EXISTING ACCOUNT
  Future<String> addPhoneNumber(String _phoneNumber) async {
    try {
      await _pref.read('token').then((onValue) async {
        print(onValue);
        var response = await http.post(ApiUrl.ADD_PHONE_NUMBER,
            headers: <String, String>{
              "accept": "application/json",
              "authorization": "Bearer " + onValue,
              "Content-Type": "application/json"
            },
            body: jsonEncode(<String, String>{
              "phone": _phoneNumber,
            }));
        var responseBody = json.decode(response.body);

        if (response.statusCode == 200) {
          print(responseBody);
          if (responseBody != null) {
            try {
              _alertText = responseBody['message'];
              if (_alertText == null) {
                _alertText = responseBody['error']['message'];
              }
            } catch (e) {
              print(e);
            }
          }
          print(_alertText);
        } else {
          print(responseBody);
          _alertText = responseBody['error']['message'];
        }
        print(response.body);
      });
    } catch (e) {
      print(e.toString());
      _alertText = e.toString();
    }

    return _alertText;
  }

  Future<String> resetByEmail(
      String _tempCode, String _email, String _password) async {
    try {
      var response = await http.post(ApiUrl.RESET_BY_EMAIL,
          headers: ApiHeader.headers,
          body: jsonEncode(<String, String>{
            'temp_code': _tempCode,
            'email': _email,
            'password': _password,
          }));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        _alertText = responseJson['message'];
        if (_alertText == null) {
          _alertText = responseJson['error']['message'];
        }
      }
    } catch (e) {
      print(e.toString());
      _alertText = e.toString();
    }
    return _alertText;
  }

  Future<String> resetByPhone(
      String _tempCode, String _phone, String _password) async {
    try {
      var response = await http.post(ApiUrl.RESET_BY_PHONE,
          headers: ApiHeader.headers,
          body: jsonEncode(<String, String>{
            'temp_code': _tempCode,
            'phone': _phone,
            'password': _password,
          }));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        _alertText = responseJson['message'];
        if (_alertText == null) {
          _alertText = responseJson['error']['message'];
        }
      }
    } catch (e) {
      print(e.toString());
      _alertText = e.toString();
    }
    return _alertText;
  }

  Future<String> verifyByPhone(String phone, String verifyCode) async {
    try {
      var response = await http.post(
        ApiUrl.VERIFY_BY_PHONE,
        headers: ApiHeader.headers,
        body: jsonEncode(
          <String, String>{
            'phone': phone,
            'verification_code': verifyCode,
          },
        ),
      );

      if (response.statusCode == 200) {
        var repsonseBody = json.decode(response.body);

        _alertText = repsonseBody['message'];
        if (_alertText == null) {
          _alertText = repsonseBody['error']['message'];
        }
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }

    return _alertText;
  }

  //RESEND THE OTP CODE BY USING PHONE NUMBER
  Future<String> resendCode(String phoneNumber) async {
    var response = await http.post(ApiUrl.RESEND_CODE,
        headers: ApiHeader.headers,
        body: <String, String>{
          'phone': phoneNumber,
        });
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      try {
        _alertText = responseJson['message'];
      } catch (e) {
        _alertText = responseJson['error']['message'];
      }
    }

    return _alertText;
  }

  void signOutByEmail(context) async {
    Navigator.pushReplacementNamed(context, WelcomeView);
  }
}
