import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int qty = 0;

  void addQty() {
    setState(() {
      qty++;
    });
  }

  void removeQty() {
    setState(() {
      if (qty > 0) {
        qty--;
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: cart.isNotEmpty
            ? Container(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.7,
                        child: ListView.builder(
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  setState(() {
                                    cart.removeAt(index);
                                  });
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
                                          AssetImage(cart[index].image),
                                    ),
                                    title: Text(cart[index].title),
                                    subtitle: Text(
                                      '\$ ' + cart[index].price.toString(),
                                      style: TextStyle(
                                          color: kDefaultColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: CartBtnQty(
                                        addQty, removeQty, qty, cart[index]),
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
