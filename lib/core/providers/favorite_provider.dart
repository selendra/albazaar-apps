import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/core/models/products.dart';

class FavoriteProvider with ChangeNotifier {
  List<Product> _fav = [];

  List<Product> get items => [..._fav];

  //ADD PRODUCT TO FAVORITE LIST
  void addFav(Product product) {
    if (!_fav.contains(product)) {
      _fav.add(product);
      // product.isFavorite = true;
      notifyListeners();
    }
  }

  //REMOVE PRODUCT FROM FAVORITE LIST
  void removeFav(Product product) {
    _fav.remove(product);
    //product.isFavorite = false;
    notifyListeners();
  }
}
