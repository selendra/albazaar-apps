import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class BottomNavigationDetail extends StatelessWidget {
  final Product loadedProduct;
  BottomNavigationDetail(this.loadedProduct);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Consumer<FavoriteProvider>(
              builder: (context, value, child) => IconButton(
                onPressed: () {
                  value.isFav(loadedProduct);
                },
                icon: Icon(loadedProduct.isFav
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Colors.red,
              ),
            ),
          ),
          BtnAddToCart(loadedProduct),
        ],
      ),
    );
  }
}
