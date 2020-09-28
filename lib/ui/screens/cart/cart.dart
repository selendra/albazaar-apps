import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/cart/components/body.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_simple_appbar.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('cart'), context),
      body: Body(),
    );
  }
}
