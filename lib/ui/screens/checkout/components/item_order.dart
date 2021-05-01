import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/cart.dart';

class ItemOrder extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<CartProvider>(context);
    return GestureDetector(
      onTap: () {
        // Product _product = Provider.of<ProductsProvider>(context, listen: false).findById(order.isBuyNow.id);
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(product: _product,)));
      },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: kDefaultShape,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(kDefaultRadius),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        spreadRadius: 5.0,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child:CachedNetworkImage(imageUrl: order.isBuyNow.image, fit: BoxFit.cover,) //Image.network(order.image, fit: BoxFit.cover),
                ),
              ),
              MyPadding(
                pLeft: 12, pRight: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          MyText(
                            text: "Name:",
                            bottom: 10,
                          ),

                          MyText(
                            left: 6,
                            text: "${order.isBuyNow.title}",
                            bottom: 10,
                          )
                        ],
                      )
                    ),
                    
                    Flexible(
                      child: Row(
                        children: [
                          MyText(
                            text: "Qty:",
                            bottom: 10,
                          ),

                          MyText(
                            left: 6,
                            text: "${order.isBuyNow.qty}",
                            bottom: 10,
                          )
                        ],
                      )
                    ),

                    Flexible(
                      child: Row(
                        children: [
                          MyText(
                            text: "Price:",
                            bottom: 10,
                          ),

                          MyText(
                            left: 6,
                            text: "${order.isBuyNow.price}",
                            bottom: 10,
                          )
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
