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

<<<<<<< HEAD
  Future<void> fetchBuyerOrder() async {
=======
  void fetchBuyerOrder() async {
>>>>>>> dd18c4b3fc878514e99f470516adf93856470ba9
    _backend.response = await _getRequest.getAllBuyerOrder();
    var responseJson = json.decode(_backend.response.body);
    _allBuyerOrder.clear();
    allBuyerOrder.clear();
<<<<<<< HEAD
    for (var data in responseJson) {
      var itemData = SellerModel.fromJson(data);
      if (itemData.orderStatus == 'Pay Success' ||
          itemData.orderStatus == 'Place Order') {
        _allBuyerOrder.add(SellerModel.fromJson(data));
      }
=======
    for (var data in _backend.data) {
      _allBuyerOrder.add(SellerModel.fromJson(data));
>>>>>>> dd18c4b3fc878514e99f470516adf93856470ba9
    }

    notifyListeners();
  }
}
