import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ProfileDialog {
  Future<void> usernameDialog(BuildContext context, String titleText) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: kDefaultShape,
          title: Text(titleText),
          content: Container(
            height: 180,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: ReuseTextField(
                    labelText: 'First Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: ReuseTextField(
                    labelText: 'Mid Name',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: ReuseTextField(
                    labelText: 'Last Name',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
