import 'package:selendra_marketplace_app/all_export.dart';

class AddProductProvider extends ChangeNotifier{

  AddProduct addProduct = AddProduct();

  AddProductProvider() {
    fetchShippingServices();
  }

  // Fetch Shipping To Shipping Listing
  void fetchShippingServices() async {
    // Condition Prevent Multi Refetch
    if (addProduct.shippingServics.isEmpty){
      await GetRequest().shippingServices().then((value) {
        if (value.body.isNotEmpty){
          addProduct.shippingServics.clear();
          addProduct.shippingServics = List<Map<String, dynamic>>.from(json.decode(value.body));
          notifyListeners();
        }
      });
    }
  }
}