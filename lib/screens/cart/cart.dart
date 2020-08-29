import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/cart/components/body.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_simple_appbar.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Cart', context),
      body: Body(),
    );
  }
}
