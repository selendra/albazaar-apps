import 'package:flutter/material.dart';

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
  String price;
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
        price: json["price"].toString(),
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
// To parse this JSON data, do
//
//     final orderProduct = orderProductFromMap(jsonString);

class OrderProduct with ChangeNotifier {
  OrderProduct({
    this.statusId,
    this.productId,
    this.buyerId,
    this.updatedAt,
    this.total,
    this.id,
    this.updatedBy,
    this.createdBy,
    this.qauantity,
    this.shippingAddress,
    this.createdAt,
  });

  String statusId;
  String productId;
  String buyerId;
  dynamic updatedAt;
  double total;
  String id;
  dynamic updatedBy;
  String createdBy;
  int qauantity;
  String shippingAddress;
  DateTime createdAt;

  factory OrderProduct.fromMap(Map<String, dynamic> json) => OrderProduct(
        statusId: json["status_id"],
        productId: json["product_id"],
        buyerId: json["buyer_id"],
        updatedAt: json["updated_at"],
        total: json["total"].toDouble(),
        id: json["id"],
        updatedBy: json["updated_by"],
        createdBy: json["created_by"],
        qauantity: json["qauantity"],
        shippingAddress: json["shipping_address"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "status_id": statusId,
        "product_id": productId,
        "buyer_id": buyerId,
        "updated_at": updatedAt,
        "total": total,
        "id": id,
        "updated_by": updatedBy,
        "created_by": createdBy,
        "qauantity": qauantity,
        "shipping_address": shippingAddress,
        "created_at": createdAt.toIso8601String(),
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
