import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class ResetChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Reset Password', context),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _reuseInkwell('Reset by email', Icons.email, () {
              Navigator.push(
                  context, RouteAnimation(enterPage: ResetByEmail()));
            }),
            _reuseInkwell('Reset by phone', Icons.phone, () {
              Navigator.push(
                  context, RouteAnimation(enterPage: ResetPassPhone()));
            }),
            _reuseInkwell('Reset Wallet Pin', Icons.account_balance_wallet, () {
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
