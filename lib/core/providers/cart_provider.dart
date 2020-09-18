import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/models/cart.dart';

class CartProvider with ChangeNotifier {
  int quantity = 0;
  double totalPrice = 0;
  Map<String, Cart> _items = {};

  Map<String, Cart> get items => {..._items};

  void addCart(String productId, String image, String title, double price,
      int productOrderQty) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingItem) => Cart(
              id: DateTime.now().toString(),
              image: existingItem.image,
              title: existingItem.title,
              price: existingItem.price,
              qty: existingItem.qty + productOrderQty));
    } else {
      _items.putIfAbsent(
          productId,
          () => Cart(
              id: DateTime.now().toString(),
              image: image,
              title: title,
              price: price,
              qty: productOrderQty));

      totalPrice = totalPrice + price;
    }

    notifyListeners();
  }

  void addQty(String productId) {
    _items.update(
        productId,
        (existingItem) => Cart(
            id: DateTime.now().toString(),
            image: existingItem.image,
            title: existingItem.title,
            price: existingItem.price,
            qty: existingItem.qty + 1));
    // totalPrice = totalPrice + product.price;
    notifyListeners();
  }

  void minusQty(String productId) {
    _items.update(
        productId,
        (existingItem) => existingItem.qty > 1
            ? Cart(
                id: DateTime.now().toString(),
                image: existingItem.image,
                title: existingItem.title,
                price: existingItem.price,
                qty: existingItem.qty - 1)
            : null);
    //totalPrice = totalPrice - product.price;

    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qty;
    });
    return total;
  }

  void removeItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }
}
