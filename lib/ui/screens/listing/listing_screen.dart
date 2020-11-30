import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
import 'package:selendra_marketplace_app/ui/screens/listing/components/body.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_appbar.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

class ListingScreen extends StatefulWidget {
  @override
  _ListingScreenState createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  bool isSold = false;

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
    var lang = AppLocalizeService.of(context);

    return Scaffold(
      appBar: ReuseAppBar.getTitle(
          lang.translate('listing'),
          context,
          'Products',
          'Pending',
          'Sold',
          _controller), //lang.translate('Products')
      body: Body(_controller),
    );
  }
}
