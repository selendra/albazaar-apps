import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/cart.dart';

class ItemOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Cart>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/detail',
          arguments: order.id,
        );
        Provider.of<ProductsProvider>(context, listen: false)
            .findImgById(order.id);
      },
      child: Card(
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
                  child: Image.network(order.image, fit: BoxFit.cover),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ListTile(
                      title: Text(
                        order.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      isThreeLine: true,
                      subtitle: Text('Qty: ${order.qty}'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ListTile(
                      subtitle: Text(
                        'Price: ${order.price}៛ ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kDefaultColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
