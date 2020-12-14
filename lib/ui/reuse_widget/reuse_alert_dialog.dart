import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ReuseAlertDialog {
  Future<void> successDialog(BuildContext context, String alertText) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: kDefaultShape,
          title: Text('Message'),
          content: Text(alertText),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> customDialog(
      BuildContext context, String alertText, Function func) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: kDefaultShape,
          title: Text('Message'),
          content: Text(alertText),
          actions: [
            FlatButton(
              onPressed: () {
                func();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> resetAlertDialog(BuildContext context, String alertText) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: kDefaultShape,
          title: Text('Message'),
          content: Text(alertText),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
