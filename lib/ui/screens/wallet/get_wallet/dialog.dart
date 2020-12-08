import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class AllDialog {
  String _pin;

  Future verifyDialog(BuildContext context, String _alertText, Widget _phoneCodePick, Function sendCode) async {
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
              onPressed: () async {

                // Wallet Add Phone Number
                
                //Close Previous Dialog "Verify PIN"
                Navigator.pop(context, true);
                // Close Current Dialog "Add Phone"
                // Navigator.pop(context);
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

  addPhoneNumberDialog(BuildContext context, Widget _phoneCodePick, Function sendCode) {
    var _lang = AppLocalizeService.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(kDefaultRadius)),
      ),
      title: Text(_lang.translate('enter_your_phone_number')),
      content: _phoneCodePick,
      actions: [
        FlatButton(
          child: Text(_lang.translate('no')),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(_lang.translate('yes')),
          onPressed: () async {
            Navigator.pop(context,true);
          },
        ),
      ],
    );
  }

  // SMS Verification Code
  Future verifyPinDialog(BuildContext context, Function checkVerifyPin) async {
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
            onSubmit: (value) {
              _pin = value;
            },
          ),
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () async {
                Navigator.pop(context, _pin);
              },
            ),
          ],
        );
      },
    );
  }

  simpleAlertDialog(BuildContext context, String alertText) async {
    return showDialog(
      context: (context),
      builder: (context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text(alertText),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, '');
              },
            )
          ],
        );
      },
    );
  }
}


