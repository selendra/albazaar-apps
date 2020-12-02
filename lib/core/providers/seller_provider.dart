import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/seller_m.dart';

class SellerProvider with ChangeNotifier {
  Backend _backend = Backend();

  GetRequest _getRequest = GetRequest();

  List<SellerModel> _allBuyerOrder = [];

  List<SellerModel> get allBuyerOrder => [..._allBuyerOrder];

  bool _isPayment = false;
  bool _isShipment = false;
  bool _isComplete = false;

  bool get isPayment => _isPayment;
  bool get isShipment => _isShipment;
  bool get isComplete => _isComplete;

  void setPayment() {
    _isPayment = true;
    notifyListeners();
  }

  void setShipment() {
    _isShipment = true;
    notifyListeners();
  }

  void setComplete() {
    _isComplete = true;
    notifyListeners();
  }

  SellerProvider() {
    fetchBuyerOrder();
  }
  void removeBuyerOrder(String id) {
    _allBuyerOrder.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void fetchBuyerOrder() async {
    // allBuyerOrder.clear();
    _backend.response = await _getRequest.getAllBuyerOrder();

    _backend.data = json.decode(_backend.response.body);

    for (var data in _backend.data) {
      _allBuyerOrder.add(SellerModel.fromJson(data));
      notifyListeners();
    }
  }
}
