import 'package:flutter/material.dart';
import 'package:albazaar_app/core/models/products.dart';

class FavoriteProvider with ChangeNotifier {
  List<Product> _fav = [];

  List<Product> get items => [..._fav];

  void isFav(Product product) {
    if (product.isFav) {
      product.isFav = false;
      removeFav(product);
    } else {
      product.isFav = true;
      addFav(product);
    }
    notifyListeners();
  }

  //ADD PRODUCT TO FAVORITE LIST
  void addFav(Product product) {

    if (!_fav.contains(product)) {
      _fav.add(product);
      product.isFav = true;
    }
  }

  //REMOVE PRODUCT FROM FAVORITE LIST
  void removeFav(Product product) {
    _fav.remove(product);
    product.isFav = false;
    notifyListeners();
  }
}
