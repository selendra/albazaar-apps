import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

class ReuseQrCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: kDefaultShape,
      color: Colors.white,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Consumer<UserProvider>(
            builder: (context, value, child) => Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                QrImage(
                  data: value.mUser.wallet,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  value.mUser.wallet,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 50.0,
                ),
                ReuseButton.getItem('Copy', () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Copied"),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
