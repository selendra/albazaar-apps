import 'package:selendra_marketplace_app/all_export.dart';

class SellerModel with ChangeNotifier {
  bool isPayment = false;
  bool isShipping = false;
  String shippingService = '';
<<<<<<< HEAD
  String orderStatus = '';
=======
  String orderStatusDec = '';
>>>>>>> dd18c4b3fc878514e99f470516adf93856470ba9
  String productId = '';
  String name = '';
  String buyerId = '';
  String buyerPhonenumber = '';
  double total = 0;
  String thumbnail = '';
  String id = '';
  int price = 0;
  int qauantity = 0;
  String shippingAddress = '';
  String type = '';
  String value = '';

  SellerModel();

  SellerModel.fromJson(Map<String, dynamic> data) {
    shippingService = data['shipping_service'];
<<<<<<< HEAD
    orderStatus = data["order_status_dec"];
=======
    orderStatusDec = data['order_status_dec'];
>>>>>>> dd18c4b3fc878514e99f470516adf93856470ba9
    productId = data['product_id'];
    name = data['name'];
    buyerId = data['buyer_id'];
    buyerPhonenumber = data['buyer_phonenumber'];
    total = data['total'];
    thumbnail = data['thumbnail'];
    id = data['id'];
    price = data['price'];
    qauantity = data['qauantity'];
    shippingAddress = data['shipping_address'];
    type = data['buyer']['type'];
    value = data['buyer']['value'];
    StorageServices.fetchData('confirm_products').then((value) {
      if (value != null) {
        isPayment = value['isPayment'];
        isShipping = value['isShipping'];
      }
    });
    // notifyListeners();
  }
}
