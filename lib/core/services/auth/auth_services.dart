import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:selendra_marketplace_app/ui/screens/welcome/welcome_screen.dart';
import 'package:selendra_marketplace_app/core/models/user.dart';
import 'package:selendra_marketplace_app/core/models/acc_balance.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final FacebookLogin facebookLogin = FacebookLogin();

String alertText;

void getUserInfo(FirebaseUser user) {
  mUser.email = user.email;
  mUser.firstName = user.displayName;
  mUser.lastName = '';
  mUser.midName = '';
  mUser.profileImg = user.photoUrl;
}

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  print(user);

  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  getUserInfo(user);

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
      FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
      final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: facebookAccessToken.token);
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print(credential);

      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      getUserInfo(user);

      currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      return currentUser;
    }
  } catch (e) {
    print(e);
  }
  return currentUser;
}

Future<void> signOut(BuildContext context) async {
  mBalance.clear();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs?.clear();
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

void signOutByEmail(context) async {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
}
