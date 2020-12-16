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
          child: Column(
            children: [
              _infoRow(Icons.person, product.seller.value),
              SizedBox(height: 20.0),
              _infoRow(Icons.phone, product.phonenumber),
              SizedBox(height: 20.0),
              _infoRow(Icons.location_on, product.address ?? 'no address'),
              SizedBox(height: 20.0),
              _infoRow(Icons.commute, product.shippingService)
              // ListTile(
              //   // onTap: () {}=> Navigator.push(
              //   //     context,
              //   //     MaterialPageRoute(
              //   //       builder: (context) => SellerProfile(product.),
              //   //     )),
              //   leading: Icon(
              //     Icons.person,
              //     color: kDefaultColor,
              //   ),
              //   title: Text('Seller name'),
              // ),
              // ListTile(
              //   leading: Icon(
              //     Icons.phone,
              //     color: kDefaultColor,
              //   ),
              //   title: Text('phone number'),
              // ),
              // ListTile(
              //   leading: Icon(
              //     Icons.location_on,
              //     color: kDefaultColor,
              //   ),
              //   title: Text('Phnom Penh'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _infoRow(IconData _iconData, String title) {
    return Row(
      children: [
        Icon(
          _iconData,
          // color: kDefaultColor,
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
