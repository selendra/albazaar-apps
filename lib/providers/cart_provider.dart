import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/products.dart';

class CartProvider with ChangeNotifier {
  int quantity = 0;
  double totalPrice = 0;
  List<Product> _cart = [];
  List<Product> get items => [..._cart];

  void addCart(Product product) {
    if (!_cart.contains(product)) {
      _cart.add(product);
      quantity = product.orderQty;
      totalPrice = totalPrice + product.price;
    } else {
      product.orderQty++;
      totalPrice = totalPrice + product.price;
    }

    notifyListeners();
  }

  void addQty(Product product) {
    product.orderQty++;
    totalPrice = totalPrice + product.price;
    notifyListeners();
  }

  void minusQty(Product product) {
    if (product.orderQty > 1) {
      product.orderQty--;
      totalPrice = totalPrice - product.price;
    }
    notifyListeners();
  }

  void remove(Product product) {
    _cart.remove(product);
    double price = product.orderQty * product.price;
    totalPrice = totalPrice - price;

    if (_cart.isEmpty) {
      totalPrice = 0;
    }
    notifyListeners();
  }
}
