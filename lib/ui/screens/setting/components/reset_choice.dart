import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ResetChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('reset_password'), context),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _reuseInkwell(
                _lang.translate('reset_password_by_email'), Icons.email, () {
              Navigator.push(
                  context, RouteAnimation(enterPage: ResetByEmail()));
            }),
            _reuseInkwell(
                _lang.translate('reset_password_by_phone'), Icons.phone, () {
              Navigator.push(
                  context, RouteAnimation(enterPage: ResetPassPhone()));
            }),
            _reuseInkwell(_lang.translate('reset_wallet_pin'),
                Icons.account_balance_wallet, () {
              Navigator.push(
                  context, RouteAnimation(enterPage: ResetByEmail()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _reuseInkwell(String title, IconData iconData, Function function) {
    return InkWell(
      onTap: () {
        function();
      },
      child: ListTile(
        title: Text(
          title,
        ),
        leading: Icon(
          iconData,
          color: kDefaultColor,
        ),
      ),
    );
  }
}
