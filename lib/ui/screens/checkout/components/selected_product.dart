import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/reuse_simple_appbar.dart';

class SelectedProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Selected Product', context),
      body: Container(),
    );
  }
}
