import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  Product({
    this.description,
    this.shippingService,
    this.address,
    this.name,
    this.categoryName,
    this.updatedAt,
    this.thumbnail,
    this.phonenumber,
    this.weight,
    this.id,
    this.paymentId,
    this.updatedBy,
    this.shipping,
    this.price,
    this.shippingFee,
    this.createdBy,
    this.categoryId,
    this.createdAt,
    this.seller,
    this.isSold,
    this.isFav,
    this.orderQty,
  });

  String description;
  String shippingService;
  dynamic address;
  String name;
  String categoryName;
  dynamic updatedAt;
  String thumbnail;
  String phonenumber;
  String weight;
  String id;
  String paymentId;
  dynamic updatedBy;
  String shipping;
  String price;
  String shippingFee;
  String createdBy;
  String categoryId;
  DateTime createdAt;
  Seller seller;
  bool isSold;
  bool isFav;
  int orderQty;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        description: json["description"],
        shippingService: json["shipping_service"],
        name: json["name"],
        categoryName: json["category_name"],
        updatedAt: json["updated_at"],
        thumbnail: json["thumbnail"],
        phonenumber: json["phonenumber"],
        weight: json["weight"],
        id: json["id"],
        paymentId: json["payment_id"],
        updatedBy: json["updated_by"],
        address: json["address"],
        price: json["price"].toString(),
        shippingFee: json["shipping_fee"].toString(),
        createdBy: json["created_by"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        seller: Seller.fromJson(json["seller"]),
        isSold: json["is_sold"],
        isFav: false,
        orderQty: 1,
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
//     final orderProduct = orderProductFromJson(jsonString);

class OrderProduct with ChangeNotifier {
  OrderProduct({
    this.shippingService,
    this.orderStatus,
    this.productId,
    this.name,
    this.buyerId,
    this.sellerPhonenumber,
    this.total,
    this.thumbnail,
    this.id,
    this.price,
    this.qauantity,
    this.shippingAddress,
    this.seller,
  });

  String shippingService;
  String orderStatus;
  String productId;
  String name;
  String buyerId;
  String sellerPhonenumber;
  double total;
  String thumbnail;
  String id;
  int price;
  int qauantity;
  String shippingAddress;
  Seller seller;

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        shippingService: json["shipping_service"],
        orderStatus: json["order_status_dec"],
        productId: json["product_id"],
        name: json["name"],
        buyerId: json["buyer_id"],
        sellerPhonenumber: json["seller_phonenumber"],
        total: json["total"].toDouble(),
        thumbnail: json["thumbnail"],
        id: json["id"],
        price: json["price"],
        qauantity: json["qauantity"],
        shippingAddress: json["shipping_address"],
        seller: Seller.fromJson(json["seller"]),
      );

  Map<String, dynamic> toJson() => {
        "shipping_service": shippingService,
        "product_id": productId,
        "name": name,
        "buyer_id": buyerId,
        "seller_phonenumber": sellerPhonenumber,
        "total": total,
        "thumbnail": thumbnail,
        "id": id,
        "price": price,
        "qauantity": qauantity,
        "shipping_address": shippingAddress,
        "seller": seller.toJson(),
      };
}

class Seller {
  Seller({
    this.type,
    this.value,
  });

  String type;
  String value;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}

class OwnerProduct {
  OwnerProduct({
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

  factory OwnerProduct.fromJson(Map<String, dynamic> json) => OwnerProduct(
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

  Map<String, dynamic> toJson() => {
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

// class OrderProduct with ChangeNotifier {
//   OrderProduct({
//     this.statusId,
//     this.productId,
//     this.buyerId,
//     this.updatedAt,
//     this.total,
//     this.id,
//     this.updatedBy,
//     this.createdBy,
//     this.qauantity,
//     this.shippingAddress,
//     this.createdAt,
//   });

//   String statusId;
//   String productId;
//   String buyerId;
//   dynamic updatedAt;
//   double total;
//   String id;
//   dynamic updatedBy;
//   String createdBy;
//   int qauantity;
//   String shippingAddress;
//   DateTime createdAt;

//   factory OrderProduct.fromMap(Map<String, dynamic> json) => OrderProduct(
//         statusId: json["status_id"],
//         productId: json["product_id"],
//         buyerId: json["buyer_id"],
//         updatedAt: json["updated_at"],
//         total: json["total"].toDouble(),
//         id: json["id"],
//         updatedBy: json["updated_by"],
//         createdBy: json["created_by"],
//         qauantity: json["qauantity"],
//         shippingAddress: json["shipping_address"],
//         createdAt: DateTime.parse(json["created_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "status_id": statusId,
//         "product_id": productId,
//         "buyer_id": buyerId,
//         "updated_at": updatedAt,
//         "total": total,
//         "id": id,
//         "updated_by": updatedBy,
//         "created_by": createdBy,
//         "qauantity": qauantity,
//         "shipping_address": shippingAddress,
//         "created_at": createdAt.toIso8601String(),
//       };
// }

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
