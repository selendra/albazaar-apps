import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/seller_m.dart';

class SellerProvider with ChangeNotifier {
  Backend _backend = Backend();

  GetRequest _getRequest = GetRequest();

  PostRequest _postRequest = PostRequest();

  List<SellerModel> allBuyerOrder = [];

  bool _isPayment = false;
  bool _isShipment = false;

  bool get isPayment => _isPayment;
  bool get isShipment => _isShipment;
  SellerProvider() {
    fetchBuyerOrder();
  }

  void setPayment() {
    _isPayment = true;
    print(_isPayment);
    print(isPayment);
    notifyListeners();
  }

  void setShipment() {
    _isShipment = true;
    notifyListeners();
  }

  void fetchBuyerOrder() async {
    allBuyerOrder.clear();
    _backend.response = await _getRequest.getAllBuyerOrder();

    _backend.data = json.decode(_backend.response.body);

    for (var data in _backend.data) {
      allBuyerOrder.add(SellerModel.fromJson(data));
    }
    print(allBuyerOrder);
    notifyListeners();
  }
}
