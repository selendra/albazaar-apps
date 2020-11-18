import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'components/body.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('notification'), context),
      body: Body(),
    );
  }
}
