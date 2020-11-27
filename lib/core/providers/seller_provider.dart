import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/seller_m.dart';

class SellerProvider with ChangeNotifier {
  Backend _backend = Backend();

  GetRequest _getRequest = GetRequest();

  PostRequest _postRequest = PostRequest();

  List<SellerModel> allBuyerOrder = [];

  SellerProvider() {
    fetchBuyerOrder();
  }

  void fetchBuyerOrder() async {
    allBuyerOrder.clear();
    _backend.response = await _getRequest.getAllBuyerOrder();

    _backend.data = json.decode(_backend.response.body);

<<<<<<< HEAD
    for (var data in _backend.data) {
      //print(data);
=======
    for(var data in _backend.data){
>>>>>>> 5a81c08d288d909b28ea4aa4e9aa0ace4f2a05a3
      allBuyerOrder.add(SellerModel.fromJson(data));
    }
    print(allBuyerOrder);
    notifyListeners();
  }
}
