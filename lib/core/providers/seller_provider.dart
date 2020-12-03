import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/seller_m.dart';

class SellerProvider with ChangeNotifier {
  Backend _backend = Backend();

  GetRequest _getRequest = GetRequest();

  List<SellerModel> _allBuyerOrder = [];

  List<SellerModel> get allBuyerOrder => _allBuyerOrder;

  SellerProvider() {
    fetchBuyerOrder();
  }
  void removeBuyerOrder(String id) {
    _allBuyerOrder.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> fetchBuyerOrder() async {
    _backend.response = await _getRequest.getAllBuyerOrder();
    var responseJson = json.decode(_backend.response.body);
    _allBuyerOrder.clear();
    allBuyerOrder.clear();
    for (var data in responseJson) {
      var itemData = SellerModel.fromJson(data);
      if (itemData.orderStatus == 'Pay Success' ||
          itemData.orderStatus == 'Place Order') {
        _allBuyerOrder.add(SellerModel.fromJson(data));
      }
    }

    notifyListeners();
  }
}
