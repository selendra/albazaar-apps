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
    print("Hello");
    await StorageServices.fetchData(DbKey.guestAcc).then((value) async {
      print("My Value $value");
      if (value == null){
        print("From api");
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
        print("From db");
        _productList = [];
        for(var i in value){
          print("Item $i");
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
    await StorageServices.setData(list, DbKey.guestAcc).then((value) {
      print(value);
    });
  }
}