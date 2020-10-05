import 'package:flutter/material.dart';
import 'item_card.dart';
//import 'package:selendra_marketplace_app/core/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/core/models/products.dart';

class ProductList extends StatelessWidget {
  final List<Product> productsData;
  ProductList(this.productsData);

  @override
  Widget build(BuildContext context) {
   
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: productsData.length,
          /*productsData.isQueryEmpty
                  ? _products.length
                  : productsData.searchProduct.length,*/
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: productsData[index],
            child: ItemCard(
                //product: _products[index],
                ),
          ),
        ),
      ),
    );
  }
}
