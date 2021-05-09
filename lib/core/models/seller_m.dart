import 'package:albazaar_app/all_export.dart';

class SellerModel with ChangeNotifier {
  bool isPayment = false;
  bool isShipping = false;
  bool isComplete = false;
  String shippingService = '';
  String orderStatus = '';
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
    orderStatus = data["order_status_dec"];
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

  OrderProduct sellerToOrder(SellerModel seller){
    OrderProduct order = OrderProduct();

    order.shippingService = seller.shippingService;
    order.orderStatus = seller.orderStatus;
    order.productId = seller.productId;
    order.name = seller.name;
    order.buyerId = seller.buyerId;
    // order.sellerPhonenumber = seller.
    order.total = seller.total;
    order.thumbnail = seller.thumbnail;
    order.id = seller.id;
    order.price = seller.price;
    order.qauantity = seller.qauantity;
    order.shippingAddress = seller.shippingAddress;
    
    return order;
  }

}
