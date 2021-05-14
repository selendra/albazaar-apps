import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/component.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

const pd35 = 35.0;

const double pd10 = 10;
const double pd12 = 12;
const double pd20 = 20;
const double heightInput = 70;

class MyPadding extends StatelessWidget{
  
  final double pTop; 
  final double pBottom; 
  final double pLeft;
  final double pRight;
  final Widget child;

  MyPadding({this.pTop: 0, this.pBottom: 0, this.pLeft: pd35, this.pRight: pd35, this.child});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: pTop, bottom: pBottom, right: pRight, left: pLeft),
      child: child
    );
  }
}


/* Transition Animation Fade Up And Down */
Route transitionRoute(Widget child, {offsetLeft: 0.0, offsetRight: 0.25, sigmaX: 10.0, sigmaY: 10.0}) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(offsetLeft, offsetRight);
      var end = Offset.zero;
      var curve = Curves.fastOutSlowIn;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: FadeTransition(
          opacity: animation,
          child: Material(
            color: Colors.white.withOpacity(0.1),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: sigmaX,
                sigmaY: sigmaY,
              ),
              child: child,
            ),
          ),
        )
      );
    }
  );
}

Route popUpRoute(Widget child, {offsetLeft: 0.0, offsetRight: 0.25, sigmaX: 10.0, sigmaY: 10.0}) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(offsetLeft, offsetRight);
      var end = Offset.zero;
      var curve = Curves.fastOutSlowIn;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return FadeTransition(
          opacity: animation,
          child: Material(
            color: Colors.white.withOpacity(0.1),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: sigmaX,
                sigmaY: sigmaY,
              ),
              child: child,
            ),
          ),
        );
      // SlideTransition(
      //   position: animation.drive(tween),
      //   child: FadeTransition(
      //     opacity: animation,
      //     child: Material(
      //       color: Colors.white.withOpacity(0.1),
      //       child: BackdropFilter(
      //         filter: ui.ImageFilter.blur(
      //           sigmaX: sigmaX,
      //           sigmaY: sigmaY,
      //         ),
      //         child: child,
      //       ),
      //     ),
      //   )
      // );
    }
  );
}

dialogblurBgDeco(BuildContext context, dynamic screen) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Material(
        color: Colors.white.withOpacity(0.5),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: screen,
        ),
      );
    }
  );
}

BoxShadow boxShadow(){
  return BoxShadow(
    color: Colors.grey[300],
    spreadRadius: 2.0,
    offset: Offset(0,0),
    blurRadius: 5.0,
  );
}


Future<void> requestSignUpDialog(BuildContext context) async {
  await Components.dialog(
    context, 
    Padding(
      padding: EdgeInsets.all(20),
      child: MyText(
        text: "You are in test account to access all features\nplease register and sign in", 
        textAlign: TextAlign.center,
        width: 300,
      )
    ),
    Text("Hi"),
    action: ElevatedButton(
      onPressed: () async {
        await StorageServices.removeKey(DbKey.guestAcc);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          ModalRoute.withName('/')
        );
      }, 
      child: Text("Back")
    )
  );
}
