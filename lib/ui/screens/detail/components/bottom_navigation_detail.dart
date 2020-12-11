import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class BottomNavigationDetail extends StatelessWidget {
  final Product loadedProduct;
  BottomNavigationDetail(this.loadedProduct);
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
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
              color: Colors.grey[100],
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
          Row(
            children: [
              BtnAddToCart(loadedProduct),
              SizedBox(
                width: 5.0,
              ),
              Container(
                width: 100,
                child: ReuseButton.getItem(
                    AppLocalizeService.of(context).translate('buy_now'), () {
                  cartProvider.addBuyNow(
                    loadedProduct.id,
                    loadedProduct.thumbnail,
                    loadedProduct.name,
                    loadedProduct.price,
                    loadedProduct.orderQty,
                  );
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      RouteAnimation(
                          enterPage: Checkout(
                        action: 'buy_now',
                      )));
                }, context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
