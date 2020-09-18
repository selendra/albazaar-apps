import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'cart_items.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final _cartData = Provider.of<CartProvider>(context);
    final _items = _cartData.items;
    return Container(
        child: _items.isNotEmpty
            ? Container(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.7,
                        child: ListView.builder(
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              return CartItems(
                                _items.values.toList()[index].image,
                                _items.values.toList()[index].title,
                                _items.values.toList()[index].price,
                                _items.values.toList()[index].qty,
                                _items.keys.toList()[index],
                              );
                            }),
                      ),
                    ),
                    Expanded(
                      child: CheckoutCard(),
                    ),
                  ],
                ),
              )
            : Center(
                child: Image.network(
                  'https://www.kindpng.com/picc/m/174-1749396_empty-cart-your-cart-is-empty-hd-png.png',
                  width: 300,
                  height: 300,
                ),
              ));
  }
}
