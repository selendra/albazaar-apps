import 'package:albazaar_app/core/services/auth/find_service.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
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
                  fontSize: 20,
                  color: "#000000",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      textAlign: TextAlign.left,
                      text: "(",
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: "#000000",
                    ),
                    SvgPicture.asset('${AppConfig.symbolPath}riel.svg', width: 12.3, height: 20),
                    MyText(
                      textAlign: TextAlign.right,
                      text: ")",
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: "#000000",
                    )
                  ],
                ),
                MyText(
                  left: 8,
                  textAlign: TextAlign.left,
                  text: "${cartProvider.totalPrice} / ${FindingServices().findScaleById(loadedProduct.weight, Provider.of<AddProductProvider>(context, listen: false).addProduct.weightList)}",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ],
            )
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: ReuseButton.getItem(
              AppLocalizeService.of(context).translate('check_out'), () {

                  // print(loadedProduct.id);
                  // print(loadedProduct.thumbnail);
                  // print(loadedProduct.name);
                  // print(loadedProduct.price);
                  // print(loadedProduct.orderQty);
                cartProvider.addBuyNow(
                  loadedProduct.id,
                  loadedProduct.thumbnail,
                  loadedProduct.name,
                  loadedProduct.price,
                  loadedProduct.orderQty,
                );
                Navigator.push(context, RouteAnimation(enterPage: Checkout(action: 'buy_now')));
              }, 
              context,
              width: 100
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
