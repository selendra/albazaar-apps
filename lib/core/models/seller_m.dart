import 'package:selendra_marketplace_app/all_export.dart';

class SellerModel with ChangeNotifier{

  String shippingService;
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
  String type;
  String value;

  SellerModel.fromJson(Map<String, dynamic> data){
    shippingService = data['shipping_service'];
    productId = data['product_id'];
    name = data['name'];
    buyerId = data['buyer_id'];
    sellerPhonenumber = data['seller_phonenumber'];
    total = data['total'];
    thumbnail = data['thumbnail'];
    id = data['id'];
    price = data['price'];
    qauantity = data['qauantity'];
    shippingAddress = data['shipping_ddress'];
    type = data['seller']['type'];
    value = data['seller']['value'];
    notifyListeners();
  }
}