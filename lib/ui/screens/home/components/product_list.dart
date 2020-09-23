import 'package:flutter/material.dart';
import 'item_card.dart';
import 'package:selendra_marketplace_app/core/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: productsData.searchProduct.isEmpty && productsData.isSearching
            ? Center(
                child: Container(
                  child: Text('No item found'),
                ),
              )
            : GridView.builder(
                itemCount: productsData.isSearching
                    ? productsData.searchProduct.length
                    : productsData.items.length,
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
                  value: productsData.isSearching
                      ? productsData.searchProduct[index]
                      : productsData.items[index],
                  child: ItemCard(
                      //product: _products[index],
                      ),
                ),
              ),
      ),
    );
  }
}
