import 'package:albazaar_app/all_export.dart';
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
    this.shippingId,
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
  String shippingId;
  int price;
  double shippingFee;
  String createdBy;
  String categoryId;
  String createdAt;
  Seller seller;
  bool isSold;
  bool isFav;
  int orderQty;
  
  // For Sub Image Of Product
  List<String> subImageUrl = [];

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
    price: json["price"],
    shippingId: json["shipping"],
    shippingFee: json["shipping_fee"],
    createdBy: json["created_by"],
    categoryId: json["category_id"],
    // createdAt: DateTime.parse(json["created_at"]),
    seller: Seller.fromJson(json["seller"]),
    isSold: json["is_sold"],
    isFav: false,
    orderQty: 1,
  );

  Map<String, dynamic> toMap() => {
    "description": description, 
    "shipping_service": shippingService, 
    "name": name, 
    "category_name": categoryName, 
    "updated_at": updatedAt, 
    "thumbnail": thumbnail, 
    "phonenumber": phonenumber, 
    "weight": weight, 
    "id": id, 
    "payment_id": paymentId, 
    "updated_by": updatedBy, 
    "address": address, 
    "price": price, 
    "shipping": shippingId,
    "shipping_fee": shippingFee, 
    "created_by": createdBy, 
    "category_id": categoryId, 
    "seller": seller.toJson(),
    "is_sold": isSold,
    // "description": description,
    // "name": name,
    // "updated_at": updatedAt,
    // "thumbnail": thumbnail,
    // "weight": weight,
    // "id": id,
    // "payment_id": paymentId,
    // "updated_by": updatedBy,
    // "shipping": shipping,
    // "price": price,
    // "created_by": createdBy,
    // "category_id": categoryId,
    // // "created_at": createdAt.toIso8601String(),
    // "is_sold": isSold,
  };

  // Product.fromGuestAccount(Map<String, dynamic> item){
  //   print(item);
  //   print(item.runtimeType);
  //   description = item['description'];
  //   shippingService = item["shipping_service"];
  //   address = item["address"];
  //   name = item["name"];
  //   categoryName = item["category_name"];
  //   thumbnail = item["thumbnail"];
  //   phonenumber = item["phonenumber"];
  //   weight = item["weight"];
  //   id = item["id"];
  //   paymentId = item["payment_id"];
  //   price = item["price"];
  //   shippingFee = item["shipping_fee"];
  //   createdAt = item["created_at"];
  //   seller = Seller.fromJson(item["seller"]);
  //   isSold = item["is_sold"];
  // }
}

// Model Almost For Edit
class ProductModel {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // This Variable For Images After First Image Upload
  // To Prepare For Upload Afrter Submit
  List<String> tmpImagesUrl;

  bool enable = false;
  // For Search And Getting Location
  bool isLocation = false;

  List<String> images;
  String currency;
  String categoryDropDown;
  String scale;
  String shippingOpt;
  String paymentOpt;

  String scaleId;
  String shippingOptId;
  String paymentOptId;
  String categoryId;

  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();

  FocusNode productNameNode = FocusNode();
  FocusNode priceNode = FocusNode();
  FocusNode locationNode = FocusNode();
  FocusNode categoryNode = FocusNode();
  FocusNode descriptionNode = FocusNode();

  ProductModel();

  ProductModel.initalizeData(){
    tmpImagesUrl = [];
    images = [];
    
    scale = 'Scale';
    currency = 'Currency';
    categoryDropDown = 'Category';
    shippingOpt = 'Shipping';
    paymentOpt = 'Payment';

    scaleId = '';
    shippingOptId = '';
    paymentOptId = '';
    categoryId = '';
  }

  // Call When We Fetching Data From Server
  ProductModel.fromOwner(OwnerProduct productOwner){
    images = [];
    print(productOwner.categoryName.toString()+"Category");
    images = productOwner.listImages;
    productName.text = productOwner.name;
    price.text = productOwner.price.toString();
    currency = "Currency";
    location.text = '';

    scale = productOwner.weightName ?? scale;
    categoryDropDown = productOwner.categoryName ?? categoryDropDown;
    shippingOpt = productOwner.shippingName ?? shippingOpt;
    paymentOpt = productOwner.paymentName ?? paymentOpt;

    scaleId = productOwner.weight;
    categoryId = productOwner.categoryId;
    paymentOptId = productOwner.paymentId;
    shippingOptId = productOwner.shippingId;

    description.text = productOwner.description;
  }
  AddProduct fromAddProduct(ProductModel productModel){
    AddProduct _addProduct = AddProduct();
    _addProduct.productName.text = productModel.productName.text;
    _addProduct.price.text = productModel.price.text;
    _addProduct.shipping = productModel.shippingOptId;
    _addProduct.weight = productModel.scaleId;
    _addProduct.description.text = productModel.description.text;
    
    _addProduct.imageUrl = productModel.tmpImagesUrl[0];

    // For Multiple Image
    if (productModel.tmpImagesUrl.length > 1){
      print("True");
      _addProduct.subImagesUrl = List<String>.from(productModel.tmpImagesUrl.getRange(1, productModel.tmpImagesUrl.length));
    }

    print("Hey length ${productModel.tmpImagesUrl.length}");
    print("Remain Image Url for upload ${_addProduct.subImagesUrl}");;
    
    _addProduct.category = productModel.categoryId;
    _addProduct.paymentOpt = productModel.paymentOptId;

    // For Display On Creating Shop
    _addProduct.hintCategory = productModel.categoryDropDown;
    _addProduct.hintPaymentOpt = productModel.paymentOpt;
    _addProduct.hintShipping = productModel.shippingOpt;
    _addProduct.hintWeight = productModel.scale;
    return _addProduct;
  }
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

  factory Seller.fromJson(Map<String, dynamic> jsons) => Seller(
    type: jsons == null ? '' : jsons["type"],
    value: jsons == null ? '' : jsons["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}

class OwnerProduct extends Product{

  OwnerProduct({
    description,
    shippingService,
    address,
    name,
    updatedAt,
    thumbnail,
    phonenumber,
    weight,
    id,
    paymentId,
    updatedBy,
    shippingId,
    price,
    shippingFee,
    createdBy,
    categoryId,
    createdAt,
    seller,
    isSold,
    isFav,
    orderQty,

    categoryName,
    // For Add Product Display
    this.weightName,
    this.shippingName,
    this.paymentName,

    this.subImages
  }) : super(
    description: description,
    shippingService: shippingService,
    address: address,
    name: name,
    categoryName: categoryName,
    updatedAt: updatedAt,
    thumbnail: thumbnail,
    phonenumber: phonenumber,
    weight: weight,
    id: id,
    paymentId: paymentId,
    updatedBy: updatedBy,
    shippingId: shippingId,
    price: price,
    shippingFee: shippingFee,
    createdBy: createdBy,
    categoryId: categoryId,
    createdAt: createdAt,
    seller: seller,
    isSold: isSold,
    isFav: isFav,
    orderQty: orderQty
  );

  List<String> listImages;
  List<String> subImages;

  String weightName;
  String paymentName;
  String shippingName;

  factory OwnerProduct.fromJsons(Map<String, dynamic> json) {
    print("Shop category product ${json['category_name']}");
    return OwnerProduct(
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
      price: json["price"],
      shippingId: json["shipping"],
      shippingFee: json["shipping_fee"],
      createdBy: json["created_by"],
      categoryId: json["category_id"],
      // createdAt: DateTime.parse(json["created_at"]),
      seller: Seller.fromJson(json["seller"]),
      isSold: json["is_sold"],
      isFav: false,
      orderQty: 1,
      
    );
  }

  factory OwnerProduct.fromEdit(ProductModel productModel, OwnerProduct owner){
    return OwnerProduct(
      updatedAt: owner.updatedAt,
      phonenumber: owner.phonenumber,
      id: owner.id,
      updatedBy: owner.updatedBy,

      thumbnail: productModel.images[0],
      description: productModel.description.text,
      name: productModel.productName.text,
      categoryName: productModel.categoryDropDown,
      weight: productModel.scaleId, //productModel.scale == "Scale" ? owner.weight : productModel.scale,
      shippingService: productModel.shippingOptId,
      paymentId: productModel.paymentOptId,
      shippingId: productModel.shippingOptId,
      categoryId: productModel.categoryId,
      price: int.parse(productModel.price.text),

      shippingFee: owner.shippingFee,
      createdBy: owner.createdBy,
      createdAt: owner.createdAt,
      seller: owner.seller,
      isSold: owner.isSold,
      isFav: owner.isFav,
      orderQty: owner.orderQty
    );
  }
  
  factory OwnerProduct.fromCreateShop(AddProduct addProduct){
    return OwnerProduct(
      description: addProduct.description.text,
      shippingService: addProduct.shipping,
      name: addProduct.productName.text,
      thumbnail: addProduct.imageUrl,
      weight: addProduct.weight,
      paymentId: addProduct.paymentOpt,
      shippingId: addProduct.shipping,
      price: int.parse(addProduct.price.text),
      categoryId: addProduct.category,
      orderQty: 1,
      // For Display Product When Create Shop
      categoryName: addProduct.hintCategory,
      paymentName: addProduct.hintPaymentOpt,
      weightName: addProduct.hintWeight,
      shippingName: addProduct.hintShipping,
      // For Remain Image Url
      subImages: addProduct.subImagesUrl
    );
  }

  AddProduct toAddProduct(OwnerProduct productOwner){

    AddProduct _addProduct = AddProduct();
    _addProduct.productName.text = productOwner.name;
    _addProduct.price.text = productOwner.price.toString();
    _addProduct.shipping = productOwner.shippingId;
    _addProduct.weight = productOwner.weight;
    _addProduct.description.text = productOwner.description;
    _addProduct.imageUrl = productOwner.thumbnail;
    _addProduct.category = productOwner.categoryId;
    _addProduct.paymentOpt = productOwner.paymentId;
    return _addProduct;
  }

  Map<String, dynamic> toJson() => {
    "description": description,
    "name": name,
    "updated_at": updatedAt,
    "thumbnail": thumbnail,
    "weight": weight,
    "id": id,
    "payment_id": paymentId,
    "updated_by": updatedBy,
    "shipping": shippingId,
    "price": price,
    "created_by": createdBy,
    "category_id": categoryId,
    "created_at": DateTime.parse(createdAt).toIso8601String(),
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
