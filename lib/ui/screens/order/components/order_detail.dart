import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/screens/order/components/order_detail_body.dart';

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
