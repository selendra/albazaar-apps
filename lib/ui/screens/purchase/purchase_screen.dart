import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/purchase/components/body.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_appbar.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  var result;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseAppBar.getTitle(
          _lang.translate('order'),
          context,
          _lang.translate('all'),
          _lang.translate('pending'),
          _lang.translate('complete'),
          _controller),
      body: Body(_controller),
    );
  }
}
