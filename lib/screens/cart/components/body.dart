import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final _cartData = Provider.of<CartProvider>(context);
    final _items = _cartData.items;
    print(_items.length);
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
                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  _cartData.remove(_items[index]);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Product Removed"),
                                    duration: Duration(milliseconds: 300),
                                  ));
                                },
                                background: DimissibleBackground(),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(kDefaultRadius),
                                  ),
                                  child: ListTile(
                                    shape: kDefaultShape,
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage(_items[index].image),
                                    ),
                                    title: Text(_items[index].title),
                                    subtitle: Text(
                                      '\$ ' + _items[index].price.toString(),
                                      style: TextStyle(
                                          color: kDefaultColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: ChangeNotifierProvider.value(
                                      value: _items[index],
                                      child: CartBtnQty(_items[index]),
                                    ),
                                  ),
                                ),
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
