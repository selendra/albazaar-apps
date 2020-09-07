import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/products.dart';

class FavoriteProvider with ChangeNotifier {
  List<Product> _fav = [];

  List<Product> get items => [..._fav];

  void addFav(Product product) {
    if (!_fav.contains(product)) {
      _fav.add(product);
      product.isFavorite = true;
      notifyListeners();
      print(_fav[0]);
    }
  }

  void removeFav(Product product) {
    _fav.remove(product);
  }
}
