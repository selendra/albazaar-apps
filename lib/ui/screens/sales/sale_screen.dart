import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_appbar.dart';
import 'package:selendra_marketplace_app/ui/screens/sales/components/body.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseAppBar.getTitle(
          _lang.translate('sale'),
          context,
          _lang.translate('all'),
          _lang.translate('complete'),
          _lang.translate('pending'),
          _controller),
      body: Body(_controller),
    );
  }
}
