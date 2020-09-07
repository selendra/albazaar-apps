import 'package:flutter/material.dart';
import 'item_card.dart';
import 'package:selendra_marketplace_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final _products = productsData.items;
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            itemCount: _products.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: _products[index],
                child: ItemCard(
                    //product: _products[index],
                    )),
          ),
        ));
  }
}
