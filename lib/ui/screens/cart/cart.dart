import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';
import 'package:selendra_marketplace_app/ui/screens/cart/components/body.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_simple_appbar.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';
import '../../../all_export.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('cart'), context),
      body: Responsive(
        mobile: Body(),
        desktop: ReuseDesktop(widget: Body()),
      ),
    );
  }
}
