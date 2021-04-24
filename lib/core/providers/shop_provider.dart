import 'package:albazaar_app/all_export.dart';
import 'package:http/http.dart' as http;

class ShopProvider extends ChangeNotifier{

  Backend _backend = Backend();
  
  List<OwnerProduct> _allOwnerProduct;

  List<OwnerProduct> get allOwnerProduct => _allOwnerProduct;

  ProductsProvider productsProvider = ProductsProvider();

  List<ProductImage> productImages;

  String shopCheck = '';

  List<OwnerProduct> listProductCreateShop = [];

  ShopProvider(){
    fetchOListingProduct();
  }

  set allOwnwerProductSetter(dynamic value){
    _allOwnerProduct = value;
  }

  Future<void> fetchOListingProduct() async {
    _allOwnerProduct = [];
    try{
      await StorageServices.fetchData('user_token').then((token) async {
        print("My token ${token['token']} Hello");
        if(token != null){
          _backend.response = await http.get(ApiUrl.OWNER_LISTING, headers: <String, String>{
            "accept": "application/json",
            "authorization": "Bearer " + token['token'],
          });

          if (json.decode(_backend.response.body).isEmpty){
            shopCheck = 'create';
          } else {

            shopCheck = 'created';
            
            print("Body ${_backend.response.body}");

            _backend.data = json.decode(_backend.response.body);
            // print("My response ${_backend.data}");
            await StorageServices.setData(_backend.data, 'oproducts');

            print("Hey My data very ${_backend.data}");

            for (var item in _backend.data) {
              // print(item);
              _allOwnerProduct.add(OwnerProduct.fromJsons(item));
            }

            // findIsSold(oItems);

            await getAllImageProductOwner(token['token']);
          }

        }
      });
    } catch (e) {
      print("My error ${e.toString()}");
    }

    notifyListeners();
  }



  // After Retrieve Product And Then Get All Images Of Products
  Future<void> getAllImageProductOwner(String token) async {
    
    // Clear All Images
    // _allOwnerProduct.forEach((element) {element.productModel.image.clear();});

    // Fetching All Images Per Product ID 
    // And Put Into listImage of Product Provider
    // print("Getting all image product onwer");
    productImages = [];

    try {
      for(int i =0; i < _allOwnerProduct.length; i++){
        final listImagesResponse = await productsProvider.fetchImage(token, _allOwnerProduct[i].id);
        print("All Images Get response $listImagesResponse");
        await addImgIntoProductOwner(listImagesResponse, i);
        // print("Index $i");
        // print("My Product ${_allOwnerProduct[i].name}");
      }
    } catch (e){
      print("Error ${e.toString()}"); 
    }
  }

  Future<void> addImgIntoProductOwner(List<Map<String, dynamic>> images, int i) async {
    // Loop Add All Images Of Product Provider
    // Into Owner Product Images
    _allOwnerProduct[i].listImages = [];
    // Add Images Fetched Into image variable Of ProductModel's AllOwner
    images.forEach((element) {
      _allOwnerProduct[i].listImages.add(element['url']);
    });
  }
}