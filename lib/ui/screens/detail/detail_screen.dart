import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/detail/components/body.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'components/bottom_navigation_detail.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as int;
    final loadedProduct =
        Provider.of<ProductsProvider>(context).findById(productId);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: BottomNavigationDetail(loadedProduct),
    );
  }
}
