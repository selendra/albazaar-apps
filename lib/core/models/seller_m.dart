import 'package:selendra_marketplace_app/all_export.dart';

class SellerModel with ChangeNotifier{

  bool isPayment = false;
  bool isShipping = false;
  String shippingService = '';
  String productId = '';
  String name = '';
  String buyerId = '';
  String sellerPhonenumber = '';
  double total = 0;
  String thumbnail = '';
  String id = '';
  int price = 0;
  int qauantity = 0;
  String shippingAddress = '';
  String type = '';
  String value = '';

  SellerModel.fromJson(Map<String, dynamic> data){
    shippingService = '';// data != null ? '' : data['shipping_service'];
    productId = '';// data != null ? '' : data['product_id'];
    name = '';// data != null ? '' : data['name'];
    buyerId = '';// data != null ? '' : data['buyer_id'];
    sellerPhonenumber = '';// data != null ? '' : data['seller_phonenumber'];
    total = 0.0;//data != null ? 0.0 : data['total'];
    thumbnail = '';//data != null ? '' : data['thumbnail'];
    id = '';//data != null ? '' : data['id'];
    price = 0;//data != null ? 0 : data['price'];
    qauantity = 0;//data != null ? 0 : data['qauantity'];
    shippingAddress = '';//data != null ? '' : data['shipping_address'];
    type = ''; // data != null ? '' : data['buyer']['type'];
    value = ''; // data != null ? '' : data['buyer']['value'];
    StorageServices.fetchData('confirm_products').then((value) {
      if (value != null){
        isPayment = value['isPayment'];
        isShipping = value['isShipping'];
      }
    });
    notifyListeners();
  }
}