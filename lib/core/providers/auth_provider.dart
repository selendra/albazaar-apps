import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthProvider with ChangeNotifier {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();
  String _token, _alertText;

  PrefService _pref = PrefService();

  String get token => _token;

  Future<String> signInWithGoogle(BuildContext context) async {
    String googleToken;
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      googleToken = googleSignInAuthentication.idToken;

      final auth.UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final auth.User user = authResult.user;

      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      // assert(user.photoUrl != null);

      var name = user.displayName.split(' ');

      Provider.of<UserProvider>(context, listen: false).fetchSocialUserInfo(
          user.email, name.first, name.last, user.photoURL);
      mBalance = Balance();
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final auth.User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
    } catch (e) {
      await ReuseAlertDialog()
          .successDialog(context, 'Please try again later!');
    }
    return googleToken;
  }

  Future<String> signInFacebook(BuildContext context) async {
    String fbToken;

    // fbLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // if you remove above comment then facebook login will take username and pasword for login in Webview
    try {
      final FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(['email', 'public_profile']);

      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken =
            facebookLoginResult.accessToken;
        final AuthCredential credential =
            FacebookAuthProvider.credential(facebookAccessToken.token);
        fbToken = facebookAccessToken.token;

        final auth.User user =
            (await _auth.signInWithCredential(credential)).user;

        mBalance = Balance();
        var name = user.displayName.split(' ');

        getFbProfileImg(facebookAccessToken.userId, facebookAccessToken.token)
            .then((value) {
          if (value != null) {
            _pref.saveString('fbImg', value);
            Provider.of<UserProvider>(context, listen: false)
                .fetchSocialUserInfo(user.email, name.first, name.last, value);
          } else {
            Provider.of<UserProvider>(context, listen: false)
                .fetchSocialUserInfo(
                    user.email, name.first, name.last, user.photoURL);
          }
        });

        assert(user.email != null);
        assert(user.displayName != null);
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);
      } else {}
    } catch (e) {
      // print(e);
    }
    return fbToken;
  }

  Future<void> getTokenForGoogle(String idToken, BuildContext context) async {
    http.Response response = await http.post(ApiUrl.LOGIN_FROM_GOOGLE,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'token': idToken,
        }));
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      _token = responseJson['token'];
      _pref.saveString(DbKey.token, _token);

      if (token == null) {
        await ReuseAlertDialog().successDialog(
          context,
          responseJson['error']['message'],
        );
      } else {
        await StorageServices.setData(responseJson, DbKey.token);
        Provider.of<ProductsProvider>(context, listen: false)
            .fetchListingProduct();
        Provider.of<UserProvider>(context, listen: false)
            .socialUserInfo(_token);

        Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
        Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
        Navigator.pushReplacementNamed(context, BottomNavigationView);
      }
    }
  }

  Future<void> getTokenForFb(String accesstoken, context) async {
    http.Response response = await http.post(ApiUrl.LOGIN_FROM_FACEBOOK,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'token': accesstoken,
        }));
    var responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      _token = responseJson['token'];
      _pref.saveString('token', _token);

      if (token == null) {
        await ReuseAlertDialog().successDialog(
          context,
          responseJson['error']['message'],
        );
      } else {
        await StorageServices.setData(responseJson, DbKey.token);

        Provider.of<ProductsProvider>(context, listen: false)
            .fetchListingProduct();
        Provider.of<UserProvider>(context, listen: false)
            .socialUserInfo(_token);
        Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
        Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
        Navigator.pushReplacementNamed(context, BottomNavigationView);
      }
    }
  }

  Future<String> getFbProfileImg(String fbUserId, String fbUserToken) async {
    String img;
    try {
      final graphResponse = await http.get(
          'https://graph.facebook.com/$fbUserId?fields=picture.width(720).height(720)&redirect=false&access_token=$fbUserToken');
      final profile = json.decode(graphResponse.body);
      img = profile['picture']['data']['url'];
    } catch (e) {
      return null;
    }
    return img;
  }

  Future<auth.User> get currentUser async {
    return _auth.currentUser;
  }

  Future<void> signOut(BuildContext context) async {
    _pref?.clear('token');
    _pref.clear('seen');
    try {
      auth.User user = _auth.currentUser;
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
        }
      }
    } catch (e) {
      signOutByEmail(context);
    }
  }

  //USER SIGN IN USING EMAIL AND PASSWORD
  Future<String> signInByEmail(String email, String password, context) async {
    try {
      http.Response response = await http.post(
        ApiUrl.LOG_IN_URL,
        headers: ApiHeader.headers,
        body: jsonEncode(
          <String, String>{
            'email': email,
            'password': password,
          },
        ),
      );

      mBalance = Balance();

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);

        _token = responseJson['token'];
        if (_token != null) {
          _pref.saveString('token', _token);
          await StorageServices.setData(responseJson, DbKey.token);

          Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
          Provider.of<UserProvider>(context, listen: false).fetchUserPf(_token);
          Provider.of<ProductsProvider>(context, listen: false)
              .fetchListingProduct();
          Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
          Navigator.pushReplacementNamed(context, BottomNavigationView);
        } else {
          _alertText = responseJson['message'];
          if (_alertText == null) {
            _alertText = responseJson['error']['message'];
          }
        }
      } else {
        _alertText = "Please try again later";
      }
      notifyListeners();
    } on SocketException {
      // print('No Internet connection 😑');
    } on HttpException {
      // print("Couldn't find the post 😱");
    } on FormatException {
      // print("Bad response format 👎");
    }
    return _alertText;
  }

  //USER SIGN IN USING PHONE NUMBER AND PASSWORD
  Future<String> signInByPhone(String phone, String password, BuildContext context) async {
    try {
      var response = await http.post("https://testnet-api.selendra.com/pub/v1/loginbyphone", //ApiUrl.LOG_IN_PHONE,
        headers: ApiHeader.headers,
        body: jsonEncode(<String, String>{
          'phone': phone,
          'password': password,
        })
      );

      if (response.statusCode == 200) {
        
        Map<String,dynamic> responseJson = json.decode(response.body);
        print(responseJson);
        print(responseJson.runtimeType);

        if (responseJson.containsKey('error')){
          return responseJson['error']['message'];
        } else {

          // Store Token
          _token = responseJson['token'];
          await StorageServices.setData(responseJson, DbKey.token);

          mBalance = Balance();

          print("Hello success");

          if (_token != null) {
            print("Logging in");
            _pref.saveString('token', _token);
            await Provider.of<UserProvider>(context, listen: false).fetchPortforlio();
            await Provider.of<UserProvider>(context, listen: false).fetchUserPf(_token);
            await Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct();
            await Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
            print("Start go to home page");
            Navigator.pushReplacementNamed(context, BottomNavigationView);
          }
        }
      } else {
        _alertText = "Please try again later";
      }
    } catch(e){
      print("Sign In error $e");
      _alertText = e.toString();
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
    } else {}
    return _alertText;
  }

  //USER RESET THEIR PASSWORD BY PHONE NUMBER
  Future<String> forgetPasswordByPhone(String phoneNumber) async {
    var response = await http.post(
      ApiUrl.FORGET_BY_PHONE,
      headers: ApiHeader.headers,
      body: jsonEncode(
        <String, String>{'phone': phoneNumber},
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
    } else {}

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

    var responseBody = json.decode(response.body);
    _alertText = responseBody['message'];

    return _alertText;
  }

  //ADD PHONE NUMBER TO THEIR EXISTING ACCOUNT
  Future<String> addPhoneNumber(String _phoneNumber) async {
    try {
      await _pref.read('token').then((onValue) async {
        var response = await http.post(ApiUrl.ADD_PHONE_NUMBER,
            headers: <String, String>{
              "accept": "application/json",
              "authorization": "Bearer " + onValue,
              "Content-Type": "application/json"
            },
            body: jsonEncode(<String, String>{
              "phone": "+855" + _phoneNumber,
            }));
        var responseBody = json.decode(response.body);

        if (response.statusCode == 200) {
          if (responseBody.containsKey('error')){
            _alertText = responseBody['error']['message'];
          } else _alertText = responseBody['message'];
          // if (responseBody != null) {
          //   try {
          //     _alertText = responseBody['message'];
          //     if (_alertText == null) {
          //       _alertText = responseBody['error']['message'];
          //     }
          //   } catch (e) {
          //     // print(e);
          //   }
          // }
        } else {
        }
      });
    } catch (e) {
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
      _alertText = e.toString();
    }
    return _alertText;
  }

  Future<dynamic> accountConfirmationPhone(
      String phone, String verifyCode) async {
    var repsonseBody;
    try {
      var response = await http.post(
        ApiUrl.VERIFY_BY_PHONE,
        headers: ApiHeader.headers,
        body: jsonEncode(
          <String, String>{
            'phone': "+855" + phone,
            'verification_code': verifyCode,
          },
        ),
      );
      repsonseBody = json.decode(response.body);
    } on SocketException {
      // print('No Internet connection 😑');
    } on HttpException {
      // print("Couldn't find the post 😱");
    } on FormatException {
      // print("Bad response format 👎");
    }

    return repsonseBody;
  }

  //RESEND THE OTP CODE BY USING PHONE NUMBER
  Future<String> resendCode(String phoneNumber) async {
    var response = await http.post(ApiUrl.RESEND_CODE,
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: json.encode({
          "phone": phoneNumber,
        }));
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
