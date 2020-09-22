import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class SignInDialog {
  Future<void> errorDialog(BuildContext context, String _alertText) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: kDefaultShape,
          title: Text('Message'),
          content: Container(
            child: Text(_alertText),
          ),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showResetAlertDialog(BuildContext context,String _alertText){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: kDefaultShape,
          title: Text('Message'),
          content: Container(
            child: Text(_alertText),
          ),
          actions: [
           FlatButton(
             child: Text('Cancel'),
             onPressed: () => Navigator.pop(context),
           ),
          ],
        );
      },
    );
  }
}
