import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

import 'package:provider/provider.dart';

class SellerInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Card(
      elevation: 0,
      shape: kDefaultShape,
      child: Consumer<ProductsProvider>(
        builder: (context, value, child) => Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SellerProfile(product.sellerName),
                    )),
                leading: Icon(
                  Icons.person,
                  color: kDefaultColor,
                ),
                title: Text(product.sellerName),
              ),
              ListTile(
                leading: Icon(
                  Icons.phone,
                  color: kDefaultColor,
                ),
                title: Text(product.sellerPhoneNum),
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: kDefaultColor,
                ),
                title: Text('Phnom Penh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
