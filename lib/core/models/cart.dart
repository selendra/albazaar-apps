import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  final String image, title;
  final String price;
  final String id;
  final productId;
  int qty;

  Cart({this.image, this.title, this.price, this.id, this.qty, this.productId});
}
