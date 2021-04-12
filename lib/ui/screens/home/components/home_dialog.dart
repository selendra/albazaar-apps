import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class HomeDialog {
  Future<void> alertDialog(BuildContext context) async {
    var _lang = AppLocalizeService.of(context);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: kDefaultShape,
          title: Text(
            _lang.translate('logout_string'),
          ),
          content: Text(
            _lang.translate('are_you_sure_to_log_out'),
          ),
          actions: [
            TextButton(
              child: Text(
                _lang.translate('no'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(_lang.translate('yes')),
              onPressed: () {
                Navigator.pop(context);
                AuthProvider().signOut(context);
              },
            )
          ],
        );
      },
    );
  }
}
