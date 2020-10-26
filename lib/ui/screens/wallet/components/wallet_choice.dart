import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class WalletChoice extends StatelessWidget {
  final Function onGetWallet;

  WalletChoice(this.onGetWallet);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'images/undraw_wallet.svg',
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
                placeholderBuilder: (context) => Center(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            ReuseButton.getItem(
                AppLocalizeService.of(context).translate('wallet'), () {
              onGetWallet();
            }, context),
          ],
        ),
      ),
    );
  }
}
