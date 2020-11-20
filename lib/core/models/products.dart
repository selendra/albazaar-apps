import 'package:flutter/material.dart';

// class Product with ChangeNotifier {
//   final String image,
//       fruit,
//       title,
//       flavor,
//       description,
//       sellerName,
//       sellerPhoneNum,
//       category;
//   final int id;
//   final double price;
//   final String color;
//   int orderQty;
//   bool isFavorite;
//   Product({
//     this.id = 0,
//     this.image = '',
//     this.title = '',
//     this.fruit = '',
//     this.flavor = '',
//     this.price = 0.0,
//     this.orderQty = 0,
//     this.description = '',
//     this.color,
//     this.sellerName = '',
//     this.sellerPhoneNum = '',
//     this.category = '',
//     this.isFavorite = false,
//   });

//   void toggleFavStat() {
//     isFavorite = !isFavorite;
//     print(isFavorite);
//     notifyListeners();
//   }
// }
class Product with ChangeNotifier {
  Product({
    this.description,
    this.name,
    this.updatedAt,
    this.thumbnail,
    this.weight,
    this.id,
    this.paymentId,
    this.updatedBy,
    this.shipping,
    this.price,
    this.createdBy,
    this.categoryId,
    this.createdAt,
    this.isSold,
  });

  String description;
  String name;
  dynamic updatedAt;
  String thumbnail;
  String weight;
  String id;
  String paymentId;
  dynamic updatedBy;
  String shipping;
  int price;
  String createdBy;
  String categoryId;
  DateTime createdAt;
  bool isSold;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        description: json["description"],
        name: json["name"],
        updatedAt: json["updated_at"],
        thumbnail: json["thumbnail"],
        weight: json["weight"],
        id: json["id"],
        paymentId: json["payment_id"],
        updatedBy: json["updated_by"],
        shipping: json["shipping"],
        price: json["price"],
        createdBy: json["created_by"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        isSold: json["is_sold"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "name": name,
        "updated_at": updatedAt,
        "thumbnail": thumbnail,
        "weight": weight,
        "id": id,
        "payment_id": paymentId,
        "updated_by": updatedBy,
        "shipping": shipping,
        "price": price,
        "created_by": createdBy,
        "category_id": categoryId,
        "created_at": createdAt.toIso8601String(),
        "is_sold": isSold,
      };
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
