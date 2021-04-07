import 'package:flutter/material.dart';
import 'package:albazaar_app/ui/screens/detail/components/body.dart';
import 'package:provider/provider.dart';
import 'package:albazaar_app/all_export.dart';
import 'components/bottom_navigation_detail.dart';

class DetailScreen extends StatefulWidget {

  final Product product;

  DetailScreen({
    this.product
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    // final Product productId = ModalRoute.of(context).settings.arguments;
    // final loadedProduct = Provider.of<ProductsProvider>(context).findById(productId.id);
    return Scaffold(
      body: Body(
        product: widget.product,
      ),
      bottomNavigationBar: BottomNavigationDetail(widget.product),
    );
  }
}
