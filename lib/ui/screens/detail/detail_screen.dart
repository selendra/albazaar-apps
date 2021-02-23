import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/detail/components/body.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'components/bottom_navigation_detail.dart';

class DetailScreen extends StatefulWidget {

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    final Product productId = ModalRoute.of(context).settings.arguments;
    // final loadedProduct = Provider.of<ProductsProvider>(context).findById(productId.id);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: BottomNavigationDetail(productId),
    );
  }
}
