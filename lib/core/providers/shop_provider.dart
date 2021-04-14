import 'package:albazaar_app/all_export.dart';
import 'package:http/http.dart' as http;

class ShopProvider extends ChangeNotifier{

  http.Response _response;
  
  List<OwnerProduct> _allOwnerProduct;

  List<OwnerProduct> get allProduct => _allOwnerProduct;

  ShopProvider(){
    fetchOListingProduct();
  }

  Future<void> fetchOListingProduct() async {
    _allOwnerProduct = [];
    await StorageServices.fetchData('token').then((token) async {
      // token = '';
      if(token != null){
        print("Hello");
        try {
            _response =  await http.get(ApiUrl.OWNER_LISTING, headers: <String, String>{
            "accept": "application/json",
            "authorization": "Bearer " + 'eyJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI1Y2U0YTg0Mi01OWVjLTQ4OTctODRkNC05MzFjZjAyMTQxZjAiLCJleHAiOjE2MTg0NzQ4NzN9.Sf39wMbDDIyywa5scJ2OzXc3UvWHGQorU_St9ECGjhE',
          });

          var responseJson = json.decode(_response.body);
          print("My response $responseJson");
          StorageServices.setData(responseJson, 'oproducts');


          for (var item in responseJson) {
            _allOwnerProduct.add(OwnerProduct.fromJson(item));
          }

          // findIsSold(oItems);

        } catch (e) {
          print(e.toString());
        }
      }
    });

    notifyListeners();
  }
}