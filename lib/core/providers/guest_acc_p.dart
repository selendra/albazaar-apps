import 'package:albazaar_app/all_export.dart';

class GuestAccProvider extends ProductsProvider{

  GetRequest _getRequest = GetRequest();
  Backend _backend = Backend();

  // List All Product
  List<Product> _productList;

  List<Map<String, dynamic>> _productListToMap;

  List<Product> get getProducts => _productList;
  
  GuestAccProvider(){
    fetchProducts();
  }

  void fetchProducts() async {
    await StorageServices.fetchData(DbKey.guestAcc).then((value) async {
      if (value == null){
        _backend.response = await _getRequest.guestAccount();
        _backend.listData = json.decode(_backend.response.body);

        _productList = [];
        for(var i in _backend.listData){
          _productList.add(Product.fromGuestAccount(i));
        }

        _productListToMap = [];
        for(var i in _productList){
          _productListToMap.add(i.toMap());
        }
        await storeData(_productListToMap);

      } else {
        _productList = [];
        for(var i in value){
          _productList.add(Product.fromGuestAccount(i));
        }

        _productListToMap = [];
        for(var i in _productList){
          _productListToMap.add(i.toMap());
        }
      }

    });
    notifyListeners();
    
  }

  Future<void> storeData(List<Map<String, dynamic>> list) async {
    await StorageServices.setData(list, DbKey.guestAcc);
  }
}