import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/screens/detail/components/body.dart';
import '../../models/products.dart';
import '../home/components/products.dart';
import '../home/components/products.dart';

class DetailScreen extends StatelessWidget {

  final Product products;
  DetailScreen(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Body(products),
    );
  }

}
