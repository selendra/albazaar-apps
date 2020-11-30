import 'package:selendra_marketplace_app/all_export.dart';

class AddProductProvider with ChangeNotifier {
  AddProduct addProduct;
  GetRequest _getRequest;

  AddProductProvider() {
    addProduct = AddProduct();
    _getRequest = GetRequest();
    fetchShippingServices();
    fetchCategories();
    fetchPaymentOpt();
    fetchWeightOpt();
  }

  // Fetch Shipping To Shipping Listing
  void fetchShippingServices() async {
    await _getRequest.shippingServices().then((value) {
      addProduct.shippingList =
          List<Map<String, dynamic>>.from(json.decode(value.body));
      notifyListeners();
    });
  }

  void fetchCategories() async {
    await _getRequest.categories().then((value) {
      addProduct.categoriesList =
          List<Map<String, dynamic>>.from(json.decode(value.body));
    });
    notifyListeners();
  }

  void fetchPaymentOpt() async {
    await _getRequest.paymentOpt().then((value) {
      addProduct.paymentOptsList =
          List<Map<String, dynamic>>.from(json.decode(value.body));
      addProduct.paymentOpt = addProduct.paymentOptsList[1]['options_name'];
      notifyListeners();
    });
  }

  void fetchWeightOpt() async {
    await _getRequest.weightOpt().then((value) {
      addProduct.weightList =
          List<Map<String, dynamic>>.from(json.decode(value.body));
      notifyListeners();
    });
  }
}
