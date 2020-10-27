import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class AllDialog {
  Future<void> verifyDialog(BuildContext context, String _alertText,
      Widget _phoneCodePick, Function sendCode) async {
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
                'Cancel',
                style: TextStyle(color: kDefaultColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                'Verify',
                style: TextStyle(color: kDefaultColor),
              ),
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    builder: (context) =>
                        addPhoneNumberDialog(context, _phoneCodePick, sendCode),
                    context: context);
                // showVerifyPhoneDialog();
                // Navigator.of(context).pushNamedAndRemoveUntil(
                // '/root', (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  addPhoneNumberDialog(
      BuildContext context, Widget _phoneCodePick, Function sendCode) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
      ),
      title: Text('Enter your phone Number'),
      content: _phoneCodePick,
      actions: [
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            print('Cancel');
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
            sendCode();
          },
        ),
      ],
    );
  }

  Future<void> verifyPinDialog(
      BuildContext context, Function checkVerifyPin) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
          ),
          title: Text('Enter Verify Code'),
          content: ReusePinAnimate(
            onSubmit: (value) => print(value),
          ),
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                print('Cancel');
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () => checkVerifyPin,
            ),
          ],
        );
      },
    );
  }
}
