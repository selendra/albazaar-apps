import 'package:selendra_marketplace_app/all_export.dart';

class GuestAccProvider extends ProductsProvider{

  GetRequest _getRequest = GetRequest();
  Backend _backend = Backend();

  // List All Product
  List<Product> _productList;

  List<Product> get getProducts => _productList;
  
  GuestAccProvider(){
    fetchProducts();
  }

  void fetchProducts() async {
    print("Provider");
    _backend.response = await _getRequest.guestAccount();
    print(_backend.response.body);
    _backend.listData = json.decode(_backend.response.body);
    _productList = List<Product>();
    for(var i in _backend.listData){
      print("Index ${i['id']}");
      _productList.add(Product.fromGuestAccount(i));
    }
    print("After $_productList");
    // print(productList);
    notifyListeners();
  }
}