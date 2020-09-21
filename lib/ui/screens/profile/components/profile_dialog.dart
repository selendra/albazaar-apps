import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ProfileDialog {
  Future<void> successDialog(BuildContext context, String _alertText) async {
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
              child: Text(
                'OK',
                style: TextStyle(color: kDefaultColor),
              ),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.of(context).pushNamedAndRemoveUntil(
                // '/root', (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
