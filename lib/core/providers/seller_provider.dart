import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/seller_m.dart';

class SellerProvider with ChangeNotifier {
  Backend _backend = Backend();

  GetRequest _getRequest = GetRequest();

  List<SellerModel> _buyerPendingList = [];
  List<SellerModel> _buyerCompleteList = [];
  List<SellerModel> _allBuyerOrder = [];

  List<SellerModel> get buyerPendingList => _buyerPendingList;
  List<SellerModel> get buyerCompleteList => _buyerCompleteList;
  List<SellerModel> get allBuyerOrder => _allBuyerOrder;

  SellerProvider() {
    fetchBuyerOrder();
  }
  void removeBuyerOrder(String id) {
    _buyerPendingList.removeWhere(
      (element) => element.id == id,
    );
    notifyListeners();
  }

  SellerModel findProductById(String id) {
    return _allBuyerOrder.firstWhere((element) => element.id == id,
        orElse: null);
  }

  Future<void> fetchBuyerOrder() async {
    _backend.response = await _getRequest.getAllBuyerOrder();
    var responseJson = json.decode(_backend.response.body);
    _buyerPendingList.clear();
    buyerPendingList.clear();
    _buyerCompleteList.clear();
    for (var data in responseJson) {
      var itemData = SellerModel.fromJson(data);
      _allBuyerOrder.add(itemData);
      if (itemData.orderStatus != 'Order Complete') {
        _buyerPendingList.add(itemData);
      } else {
        _buyerCompleteList.add(itemData);
      }
    }

    notifyListeners();
  }
}
