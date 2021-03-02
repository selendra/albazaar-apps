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
      padding: EdgeInsets.only(left: 20, right: 20),
      color: AppServices.hexaCodeToColor(AppColors.white),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Container(
          //   height: 50.0,
          //   width: 50.0,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.grey[100],
          //     boxShadow: [
          //       BoxShadow(
          //           color: Colors.white, offset: Offset(0, 2), blurRadius: 6.0),
          //     ],
          //   ),
          //   child: Consumer<FavoriteProvider>(
          //     builder: (context, value, child) => IconButton(
          //       onPressed: () {
          //         value.isFav(loadedProduct);
          //       },
          //       icon: Icon(loadedProduct.isFav
          //           ? Icons.favorite
          //           : Icons.favorite_border),
          //       color: Colors.red,
          //     ),
          //   ),
          // ),
          Expanded(
            child: Row(
              children: [
                MyText(
                  textAlign: TextAlign.left,
                  text: 'Total = ',
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: "#000000",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      textAlign: TextAlign.left,
                      text: "( ",
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: "#000000",
                    ),
                    Image.asset('images/symbols/riel_symbol.png', width: 12.3, height: 20),
                    MyText(
                      textAlign: TextAlign.right,
                      text: " )",
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: "#000000",
                    )
                  ],
                ),
                MyText(
                  left: 8,
                  textAlign: TextAlign.left,
                  text: "5000 /Kg",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ],
            )
          ),
          
          Container(
            width: 100,
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
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
                  Navigator.push(context,
                      RouteAnimation(enterPage: Checkout(action: 'buy_now'))
                  );
                }, 
                context,
              ),
            ),
          )
          // Row(
          //   children: [
          //     // BtnAddToCart(loadedProduct),
          //     ,
          //   ],
          // ),
        ],
      ),
    );
  }
}
