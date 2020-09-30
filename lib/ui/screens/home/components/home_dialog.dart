import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';
import 'package:selendra_marketplace_app/core/services/auth/auth_services.dart';

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
            FlatButton(
              child: Text(
                _lang.translate('no'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(_lang.translate('yes')),
              onPressed: () {
                Navigator.pop(context);
                Auth().signOut(context);
              },
            )
          ],
        );
      },
    );
  }
}
