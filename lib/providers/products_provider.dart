import 'package:selendra_marketplace_app/models/products.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: 1,
        title: "Super Grape",
        price: 1000000,
        qty: 0,
        description: dummyText,
        image: "images/grapes.jpg",
        color: Color(0xFF3D82AE)),
    Product(
        id: 2,
        title: "Grapes",
        price: 100,
        qty: 0,
        description: dummyText,
        image: "images/grapes.jpg",
        color: Color(0xFFD3A984)),
    Product(
        id: 3,
        title: "Pineapple",
        price: 100,
        qty: 0,
        description: dummyText,
        image: "images/pineapple.jpg",
        color: Color(0xFF989493)),
    Product(
        id: 4,
        title: "Tomatoe",
        price: 100,
        qty: 0,
        description: dummyText,
        image: "images/tomato.jpg",
        color: Color(0xFFE6B398)),
    Product(
        id: 5,
        title: "Veg",
        price: 100,
        qty: 0,
        description: dummyText,
        image: "images/veg.jpg",
        color: Color(0xFFFB7883)),
    Product(
      id: 6,
      title: "Frozen",
      price: 100,
      qty: 0,
      description: dummyText,
      image: "images/frozen.jpg",
      color: Color(0xFFAEAEAE),
    ),
    Product(
        id: 7,
        title: "Super Grape",
        price: 1000000,
        qty: 0,
        description: dummyText,
        image: "images/grapes.jpg",
        color: Color(0xFF3D82AE)),
    Product(
        id: 8,
        title: "Grapes",
        price: 100,
        qty: 0,
        description: dummyText,
        image: "images/grapes.jpg",
        color: Color(0xFFD3A984)),
    Product(
        id: 9,
        title: "Pineapple",
        price: 100,
        qty: 0,
        description: dummyText,
        image: "images/pineapple.jpg",
        color: Color(0xFF989493)),
    Product(
        id: 10,
        title: "Tomatoe",
        price: 100,
        qty: 0,
        description: dummyText,
        image: "images/tomato.jpg",
        color: Color(0xFFE6B398)),
    Product(
        id: 11,
        title: "Veg",
        price: 100,
        qty: 0,
        description: dummyText,
        image: "images/veg.jpg",
        color: Color(0xFFFB7883)),
    Product(
      id: 12,
      title: "Frozen",
      price: 100,
      qty: 0,
      description: dummyText,
      image: "images/frozen.jpg",
      color: Color(0xFFAEAEAE),
    ),
  ];

  List<Product> get items => [..._items];

  Product findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Product setFav(int id) {
    _items.firstWhere((prod) {
      if (prod.id == id) {
        print(prod.isFavorite);
      }
    });

    return _items.firstWhere((prod) => prod.id == id);
  }

  void addItem() {
    notifyListeners();
  }
}
