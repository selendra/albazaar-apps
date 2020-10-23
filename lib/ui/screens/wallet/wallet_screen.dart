import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/constants/constants.dart';
import 'package:selendra_marketplace_app/ui/screens/wallet/components/body.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: Text(
          AppLocalizeService.of(context).translate('wallet'),
          style: TextStyle(fontWeight: FontWeight.w600, color: kDefaultColor),
        ),
        leading: Icon(
          Icons.account_balance_wallet,
          color: kDefaultColor,
        ),
      ),
      body: Body(),
    );
  }
}
