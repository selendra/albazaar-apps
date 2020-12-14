import 'package:flutter/material.dart';

import 'package:selendra_marketplace_app/core/models/cart.dart';

class CartProvider with ChangeNotifier {
  int quantity = 0;
  double totalPrice = 0;

  Map<String, Cart> _items = {};
  Map<String, Cart> _buyNow = {};

  Cart _isBuyNow = Cart();

  Cart get isBuyNow => _isBuyNow;

  Map<String, Cart> get items => {..._items};
  Map<String, Cart> get buyNow => {..._buyNow};

  //Add product to cart
  void addCart(String productId, String image, String title, String price,
      int productOrderQty) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingItem) => Cart(
              id: productId,
              image: existingItem.image,
              title: existingItem.title,
              price: existingItem.price,
              qty: existingItem.qty + productOrderQty));
    } else {
      _items.putIfAbsent(
          productId,
          () => Cart(
              id: productId,
              image: image,
              title: title,
              price: price,
              qty: productOrderQty));

      totalPrice = totalPrice + double.parse(price.toString());
    }

    notifyListeners();
  }

  //Add buynow
  void addBuyNow(String productId, String image, String title, String price,
      int productOrderQty) {
    // _buyNow = {};
    totalPrice = 0;

    _isBuyNow = Cart(
        id: productId,
        image: image,
        title: title,
        price: price,
        qty: productOrderQty);
    // _buyNow.putIfAbsent(
    //     productId,
    //     () => Cart(
    //         id: productId,
    //         image: image,
    //         title: title,
    //         price: price,
    //         qty: productOrderQty));

    totalPrice = double.parse(price.toString()) * productOrderQty;
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  //Increase quantity of order product
  void addQty(String productId) {
    _items.update(
        productId,
        (existingItem) => Cart(
            id: productId,
            image: existingItem.image,
            title: existingItem.title,
            price: existingItem.price,
            qty: existingItem.qty + 1));

    notifyListeners();
  }

  //DECRESE QUANTITY OF PRODUCT IN CART
  void minusQty(String productId) {
    _items.update(
        productId,
        (existingItem) => existingItem.qty > 1
            ? Cart(
                id: productId,
                image: existingItem.image,
                title: existingItem.title,
                price: existingItem.price,
                qty: existingItem.qty - 1)
            : Cart(
                id: productId,
                image: existingItem.image,
                title: existingItem.title,
                price: existingItem.price,
                qty: existingItem.qty));

    notifyListeners();
  }

  void getProductID() {
    for (int i = 0; i < _items.length; i++) {
      // print(_items[i].id);
    }
  }

  //CALCULATE TOTAL PRICE OF TOTAL ITEM
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += double.parse(cartItem.price.toString()) * cartItem.qty;
    });
    return total;
  }

  //REMOVE PRODUCT FROM CART
  void removeItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }
}
