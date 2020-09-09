import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String image, title, description, sellerName, sellerPhoneNum;
  final int id;
  final double price;
  final Color color;
  int orderQty;
  bool isFavorite;
  Product({
    this.id,
    this.image,
    this.title,
    this.price,
    this.orderQty,
    this.description,
    this.color,
    this.sellerName,
    this.sellerPhoneNum,
    this.isFavorite = false,
  });

  void toggleFavStat() {
    isFavorite = !isFavorite;
    print(isFavorite);
    notifyListeners();
  }
}

List<String> foodCategories = [
  'Meats',
  'Fruit',
  'Drinks',
  'Vegetable',
  'Seasoning',
  'Desserts',
  'Other'
];

String dummyText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
