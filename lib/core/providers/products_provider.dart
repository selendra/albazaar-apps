import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/products.dart';
import 'package:http/http.dart' as _http;
import 'package:selendra_marketplace_app/core/storage/storage.dart';

class ProductsProvider with ChangeNotifier {

  List<Product> data = List<Product>();

  final String myImageUrl = 'https://purepng.com/public/uploads/medium/purepng.com-single-carrotcarrotonesinglevegetablesfreshdeliciousefoodhealthy-481521740676q8i3l.png';

  List<Product> _vegProduct = [];

  List<Product> get items => [...data];

  List<Product> get vegProduct => [..._vegProduct];

  Product findById(int id) => data.firstWhere((prod) => prod.id == id);

  Future<void> getData() async {
    await StorageServices.fetchData('fruit').then((value) async {
      if (value == null) {
        _http.Response response = await _http.get(
          'https://data.wa.gov/resource/tgdf-dvhm.json',
          headers: {
            "Content-Type": "application/json; charset=utf-8", 
          }
        );
        
        List.from(json.decode(response.body)).forEach((element) {
          data.addAll({
            Product(
              id: int.parse(element['id']),
              image: myImageUrl,
              title: element['fruit'],
              price: double.parse(element['price']),
            )
          });
        });
        await objectToJson(data).then((value) async => await StorageServices.setData(value, 'fruit'));
      } else {
        jsonToObject(value);
      }
    });
    notifyListeners();
  }

  // Extract Data From Object To Json
  Future<List<Map<String, dynamic>>> objectToJson(List<Product> data) async{
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>();
    data.forEach((element) {
      list.add({
        'id': element.id,
        'image': element.image,
        'title': element.title,
        'fruit': element.fruit,
        'flavor': element.flavor,
        'price': element.orderQty,
        'description': element.description,
        'color': element.color,
        'seller_name': element.sellerName,
        'seller_phone': element.sellerPhoneNum,
        'category': element.category,
        'isFavority': element.isFavorite,
      });
    });
    return list;
  }

  // Extract Data From Json To Object
  Future<void> jsonToObject(List value) async {
    List.from(value).forEach((element) {
      print(element['price'].toDouble().runtimeType.toString());
      data.addAll({
        Product(
          id: element['id'].round(),
          image: element['image'],
          title: element['title'],
          fruit: element['fruit'],
          flavor: element['flavor'],
          price: element['price'].toDouble(),
          description: element['description'],
          color: element['color'],
          sellerName: element['seller_name'],
          sellerPhoneNum: element['seller_phone'],
          category: element['category'],
          isFavorite: element['isFavority'] ? true : false,
        )
      });
    });
  }

  //ADD NEW PRODUCT
  void addItem(String _title, double _price, String _description,
      String sellerName, String sellerPhone) {
    data.add(Product(
        id: 20,
        title: _title,
        price: _price,
        description: _description,
        image: "https://github.com/rajayogan/flutterui-fruitcookbook/blob/master/assets/blueberries.png?raw=true",
        sellerName: sellerName,
        sellerPhoneNum: sellerPhone,
        orderQty: 1,
        color: 'FF3D82AE'
    ));
    objectToJson(data).then((value) async => { await StorageServices.setData(value, 'fruit')})
    ;
    notifyListeners();
  }

  //FETCH PRODUCTS INTO DIFFERENT CATEGORIES
  void getVegi() {
    for (int i = 0; i < data.length; i++) {
      if (data[i].category == 'veg') {
        _vegProduct.add(data[i]);
      }

      notifyListeners();
    }
  }

  //INCREASE ORDER QUANTITY OF PRODUCT
  void addOrderQty(Product product) {
    product.orderQty++;
    notifyListeners();
  }

  //DECREASE ORDER QUANTIY OF PRODUCT
  void minusOrderQty(Product product) {
    if (product.orderQty > 1) {
      product.orderQty--;
      notifyListeners();
    }
  }
}
