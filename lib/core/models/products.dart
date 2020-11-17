import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';

class   Product with ChangeNotifier {

  final String image, fruit, title, flavor, description, sellerName, sellerPhoneNum, category;
  final int id;
  final double price;
  final String color;
  int orderQty;
  bool isFavorite;
  Product({
    this.id = 0,
    this.image = '',
    this.title = '',
    this.fruit = '',
    this.flavor = '',
    this.price = 0.0,
    this.orderQty = 0,
    this.description = '',
    this.color,
    this.sellerName = '',
    this.sellerPhoneNum = '',
    this.category = '',
    this.isFavorite = false,
  });

  void toggleFavStat() {
    isFavorite = !isFavorite;
    print(isFavorite);
    notifyListeners();
  }
}

List<String> foodCategories = [
  'Cereals',
  'Fruit',
  'Fish',
  'Vegetable',
  'Meat',
  'Fertilizer',
  'Other'
];

String dummyText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
