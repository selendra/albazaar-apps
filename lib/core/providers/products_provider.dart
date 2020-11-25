import 'package:http/http.dart' as http;
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/component.dart';

class ProductsProvider with ChangeNotifier {
  PrefService _prefService = PrefService();
  PostRequest _postRequest = PostRequest();

  //List of all product items
  List<Product> _items = [];

  //List of all owner product items
  List<Product> _oItems = [];

  //List of all order product items
  List<OrderProduct> _orItems = [];

  //List of all order product item that is available
  List<Product> _isAvailable = [];

  //List of all order product item that is sold
  List<Product> _isSold = [];

  //All product image
  List<ProductImage> _imageList = [];

  //Each product image url
  List<String> _url = [];

  //initial product orderqty
  int _orderQty = 1;

  List<Product> get items => [..._items];
  List<Product> get oItems => [..._oItems];
  List<Product> get isAvailable => [..._isAvailable];
  List<Product> get isSold => [..._isSold];
  List<OrderProduct> get orItems => [..._orItems];
  List<ProductImage> get imageList => [..._imageList];
  List<String> get url => [..._url];
  int get orderQty => _orderQty;

  Future<void> fetchListingProduct() async {
    try {
      await _prefService.read('token').then((value) async {
        if (value != null) {
          http.Response response =
              await http.get(ApiUrl.LISTING, headers: <String, String>{
            "accept": "application/json",
            "authorization": "Bearer " + value,
          });

          dynamic responseJson = json.decode(response.body);
          _prefService.saveString('products', jsonEncode(responseJson));
          _items = new List<Product>();
          for (var item in responseJson) {
            _items.add(Product.fromMap(item));
          }

          print(responseJson);
          notifyListeners();
          fetchOListingProduct(value);
          fetchOrListingProduct(value);
          getAllProductImg(value);
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void clearList() {
    _items.clear();
    _oItems.clear();
    notifyListeners();
  }

  void addItem(BuildContext context, AddProduct newProduct) async {
    Components.dialogLoading(context: context, contents: "Adding");
    try {
      await _postRequest.addListing(newProduct).then((value) async {
        print(value);
        // Close Loading
        Navigator.pop(context);
        await Components.dialog(context, Text("${json.decode(value.body)['message']}", textAlign: TextAlign.center), Text("Message"));
        // Close Seller Screen
        if (json.decode(value.body)['message'].length > 1) {
          newProduct.productId = json.decode(value.body)['id'];
          Navigator.pop(context, {"add": true});
        }
      });
      // Close Loading
    } on SocketException catch (e) {
      print("Error $e");
    } catch (e) {
      print("Error $e");
    }
  }

  /*Fetch all product image by looping all product id in list 
  and add it into all image list*/
  Future<void> fetchImage(String token, String productId) async {
    try {
      _imageList = List<ProductImage>();
      http.Response response = await http.post(ApiUrl.GET_PRODUCT_IMAGE,
          headers: <String, String>{
            "accept": "application/json",
            "authorization": "Bearer " + token,
            "Content-Type": "application/json",
          },
          body: jsonEncode(<String, String>{
            "url": "string",
            "product-id": productId,
          }));
      dynamic responseJson = json.decode(response.body);

      for (var item in responseJson) {
        _imageList.add(ProductImage.fromJson(item));
      }
      print(_imageList.length);
      //_imageList.add(responseJson);

    } catch (e) {
      print(e.toString());
    }
  }

  void getAllProductImg(String token) {
    for (int i = 0; i < _items.length; i++) {
      fetchImage(token, _items[i].id);
    }
  }

  Future<void> fetchOrListingProduct(token) async {
    try {
      http.Response response = await http.get(ApiUrl.ORDER_LISTING, headers: <String, String>{
        "accept": "application/json",
        "authorization": "Bearer " + token,
      });
      print('order list' + response.body);
      dynamic responseJson = json.decode(response.body);
      _orItems.add(OrderProduct.fromMap(responseJson));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchOListingProduct(String token) async {
    try {
      http.Response response =
          await http.get(ApiUrl.OWNER_LISTING, headers: <String, String>{
        "accept": "application/json",
        "authorization": "Bearer " + token,
      });
      print("Fetch O listing ${response.body}");

      dynamic responseJson = json.decode(response.body);
      _prefService.saveString('oproducts', jsonEncode(responseJson));

      _oItems = new List<Product>();
      for (var item in responseJson) {
        _oItems.add(Product.fromMap(item));
      }

      findIsSold(oItems);

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void findIsSold(List<Product> allListing) {
    _isSold = List<Product>();
    _isAvailable = List<Product>();

    for (int i = 0; i < allListing.length; i++) {
      if (allListing[i].isSold && !_isSold.contains(allListing[i])) {
        _isSold.add(allListing[i]);
      } else {
        if (!_isAvailable.contains(allListing[i])) {
          _isAvailable.add(allListing[i]);
        }
      }
    }

    notifyListeners();
  }

  //find image of each product in image list using product Id
  void findImgById(String productId) async {
    _url = List<String>();

    final product = findById(productId);
    addThumbnail(product.thumbnail);

    for (int i = 0; i < _imageList.length; i++) {
      if (_imageList[i].productId == productId) {
        _url.add(_imageList[i].url);
        notifyListeners();
      }
    }
    print(url.length);
  }

  //Add Image thumbnail to show first index of all images
  void addThumbnail(String thumbnail) {
    _url.add(thumbnail);
    notifyListeners();
  }

  // Future<void> readLocalProduct() async {
  //   await _prefService.read('products').then((value) {
  //     if (value != null) {
  //       dynamic repsonseJson = json.decode(value);
  //       for (var item in repsonseJson) {
  //         _items.add(Product.fromMap(item));
  //       }
  //     }
  //   });
  //   await _prefService.read('oproducts').then((value) {
  //     if (value != null) {
  //       dynamic responseJson = json.decode(value);
  //       _oItems.add(Product.fromMap(responseJson));
  //     }
  //   });
  // }

  //Find product by product ID
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //Increase order quantity of product
  void addOrderQty(Product product) {
    _orderQty++;
    notifyListeners();
  }

  //Decrease order quantity of product
  void minusOrderQty(Product product) {
    if (_orderQty > 1) {
      _orderQty--;
      notifyListeners();
    }
  }
}
