import 'package:flutter/material.dart';

import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void addQty() {}
  void minusQty() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        child: cart.isNotEmpty
            ? ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        cart.removeAt(index);
                      });
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Product Removed")));
                    },
                    background: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(kDefaultRadius),
                      ),
                      child: ListTile(
                        shape: kDefaultShape,
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(cart[index].image),
                        ),
                        title: Text(cart[index].title),
                        subtitle: Text(
                          '\$ ' + cart[index].price.toString(),
                          style: TextStyle(
                              color: kDefaultColor,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          print(cart[index].title);
                        },
                      ),
                    ),
                  );
                })
            : Center(
                child: Image.network(
                  'https://www.kindpng.com/picc/m/174-1749396_empty-cart-your-cart-is-empty-hd-png.png',
                  width: 300,
                  height: 300,
                ),
              ));
  }
}
