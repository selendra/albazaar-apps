import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import '../../screens/wallet/components/body.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar().appBar(
          leading: MyPadding(
            pLeft: 25, pRight: 10,
            child: SvgPicture.asset(AppConfig.iconPath+'wallet.svg', height: 35, width: 35),
          ),
          title: AppLocalizeService.of(context).translate('wallet'),
        ),
        body: BodyScaffold(
          physics: BouncingScrollPhysics(),
          bottom: 0,
          child: Body(),
        ),
      ),
    );
  }
}
