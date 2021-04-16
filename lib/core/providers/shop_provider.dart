import 'package:albazaar_app/all_export.dart';
import 'package:http/http.dart' as http;

class ShopProvider extends ChangeNotifier{

  Backend _backend = Backend();
  
  List<OwnerProduct> _allOwnerProduct;

  List<OwnerProduct> get allProduct => _allOwnerProduct;

  ShopProvider(){
    fetchOListingProduct();
  }

  Future<void> fetchOListingProduct() async {
    _allOwnerProduct = [];
    await StorageServices.fetchData('token').then((token) async {
      // token = '';
      // if(token != null){
        print("Hello");
        try {
          _backend.response =  await http.get(ApiUrl.OWNER_LISTING, headers: <String, String>{
            "accept": "application/json",
            "authorization": "Bearer " + 'eyJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI1Y2U0YTg0Mi01OWVjLTQ4OTctODRkNC05MzFjZjAyMTQxZjAiLCJleHAiOjE2MTg2NDE5NTl9.SRizEOs7w6gGNq7QpBft_ZPzwBemC8MTpxbGHTXQnW0',
          });

          _backend.data = json.decode(_backend.response.body);
          print("My response ${_backend.data}");
          await StorageServices.setData(_backend.data, 'oproducts');

          for (var item in _backend.data) {
            print(item);
            _allOwnerProduct.add(OwnerProduct.fromJsons(item));
          }

          // findIsSold(oItems);

        } catch (e) {
          print("My error");
          print(e.toString());
        }
      // }
    });

    // for (var item in _backend.data) {
    //   _allOwnerProduct.add(OwnerProduct.fromJson(item));
    // }

    notifyListeners();
  }
}