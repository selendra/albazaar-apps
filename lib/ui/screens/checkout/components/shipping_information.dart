import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:provider/provider.dart';

class ShippingInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: kDefaultShape,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Consumer<UserProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizeService.of(context)
                          .translate('shipping_information'),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: kDefaultColor,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              RouteAnimation(enterPage: OrderConfirmation()));
                        })
                  ],
                ),
                value.mUser.address == null
                    ? Container()
                    : Column(
                        children: [
                          ReuseInkwell.getItem(
                            value.mUser.firstName,
                            () {},
                            icon: Icon(Icons.account_circle), 
                          ),
                          ReuseInkwell.getItem(
                            value.mUser.address ?? 'null',
                            () {},
                            icon: Icon(Icons.location_on), 
                          ),
                          ReuseInkwell.getItem(
                            value.mUser.phonenumber ?? 'phone',
                            () {},
                            icon: Icon(Icons.phone),
                          ),
                          ReuseInkwell.getItem(
                            value.mUser.email ?? 'email', 
                            () {},
                            icon: Icon(Icons.mail), 
                          ),
                        ],
                      )
              ],
            );
          },
        ),
      ),
    );
  }
}
