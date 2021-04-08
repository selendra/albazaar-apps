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

  List<ProductImage> _listImage = [];
  
  @override
  Widget build(BuildContext context) {
    // final Product productId = ModalRoute.of(context).settings.arguments;
    final List<Product>  product = Provider.of<GuestAccProvider>(context).getProducts;
    _listImage = Provider.of<ProductsProvider>(context).imageList;
    // final loadedProduct = Provider.of<ProductsProvider>(context).findById(product[0].id);
    return Scaffold(
      body: product == null ? Center(child: CircularProgressIndicator()) : Body(
        product: product[0]//widget.product,
        // listImage: l
      )
      // bottomNavigationBar: BottomNavigationDetail(product[0]),// widget.product
    );
  }
}
