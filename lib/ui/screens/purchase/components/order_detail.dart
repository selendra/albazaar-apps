import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/purchase/components/order_detail_body.dart';

class OrderDetail extends StatelessWidget {
  final OrderProduct productOrder;

  OrderDetail({this.productOrder});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Order Detail', context),
      body: OrderDetailBody(
        productOrder: productOrder,
      ),
    );
  }
}
