import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_simple_appbar.dart';
import 'package:selendra_marketplace_app/ui/screens/addlisting/components/body.dart';
import 'package:selendra_marketplace_app/core/services/app_localize_service.dart';

class AddListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(AppLocalizeService.of(context).translate('add_listing'), context),
      body: Body(),
    );
  } 
}
