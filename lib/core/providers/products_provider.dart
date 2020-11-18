import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/models/products.dart';
import 'package:http/http.dart' as _http;
import 'package:selendra_marketplace_app/core/storage/storage.dart';

class ProductsProvider with ChangeNotifier {

  List<Product> data = List<Product>();

  ProductsProvider(){
    getData();
  }

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
        await toJson(data).then((value) async => await StorageServices.setData(value, 'fruit'));
      } else {
        print("Retrive data $value");
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
    });
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> toJson(List<Product> data) async{
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
  

  final String myImageUrl = 'https://purepng.com/public/uploads/medium/purepng.com-single-carrotcarrotonesinglevegetablesfreshdeliciousefoodhealthy-481521740676q8i3l.png';
  //LIST OF ALL PRODUCTS
  List<Product> _items = [
    Product(
        id: 1,
        title: "Apple",
        price: 1000000,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image: "https://media.timeout.com/images/105692893/image.jpg",
        color: 'FF3D82AE'),
    Product(
        id: 2,
        title: "Avocado",
        price: 100,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Persea_americana_fruit_2.JPG/1200px-Persea_americana_fruit_2.JPG",
        color: 'FFD3A984'),
    Product(
        id: 3,
        title: "Grapes",
        price: 100,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image:
            "https://www.goodfruit.com/wp-content/uploads/marquetteGrape36018-1-1000x1264.jpg",
        color: 'FF989493'),
    Product(
        id: 4,
        title: "Lemon",
        price: 100,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image:
            "https://cdn.vox-cdn.com/thumbor/AaljX--GNK0VxsnoXfexTOg2TYA=/0x0:5760x3840/1200x800/filters:focal(2420x1460:3340x2380)/cdn.vox-cdn.com/uploads/chorus_image/image/66928266/AdobeStock_320463231.0.0.jpeg",
        color: 'FFE6B398'),
    Product(
        id: 5,
        title: "Orange",
        price: 100,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image:
            "https://www.flowerpower.com.au/media/catalog/product/image/291169a6f0/orange-valencia.jpg",
        color: 'FFFB7883'),
    Product(
        id: 6,
        title: "Banana",
        price: 100,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image:
            "https://www.verywellfit.com/thmb/a4580FjTjbub9q4kI5m9X-Po-p0=/2002x1334/filters:no_upscale():max_bytes(150000):strip_icc()/Bananas-5c6a36a346e0fb0001f0e4a3.jpg",
        color: 'FFD3A984'),
    Product(
      id: 7,
      title: "Lemons",
      price: 100,
      description: dummyText,
      sellerName: 'Chay',
      sellerPhoneNum: '85776978',
      orderQty: 1,
      image:
          "https://github.com/rajayogan/flutterui-fruits/blob/master/assets/lemons.png?raw=true",
      color: 'FFAEAEAE',
    ),
    Product(
        id: 8,
        title: "Watermelon",
        price: 1000000,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image:
            "https://github.com/hakymz/Flutter-Fruit-App-UI/blob/master/assets/fruits/watermelon.png?raw=true",
        color: 'FF3D82AE'),
    Product(
        id: 9,
        title: "Mango",
        price: 100,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image:
            "https://www.netmeds.com/images/cms/wysiwyg/blog/2019/04/Raw_Mango_898.jpg",
        color: 'FF989493'),
    Product(
        id: 10,
        title: "Guava",
        price: 100,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image:
            "https://cdn.cdnparenting.com/articles/2019/03/14174045/794794447-H-1024x700.jpg",
        color: 'FFE6B398'),
    Product(
        id: 11,
        title: "Strawberry",
        price: 100,
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776978',
        orderQty: 1,
        image:
            "https://github.com/ahkohd/flutter-day2-fruit-app-layout/blob/master/images/strawberry.png?raw=true",
        color: 'FFFB7883'),
    Product(
      id: 12,
      title: "Blueberries",
      price: 100,
      description: dummyText,
      sellerName: 'Chay',
      sellerPhoneNum: '85776978',
      orderQty: 1,
      image:
          "https://github.com/rajayogan/flutterui-fruitcookbook/blob/master/assets/blueberries.png?raw=true",
      color: 'FFAEAEAE',
    ),
    Product(
        id: 13,
        title: "Broccoli",
        price: 100,
        category: 'veg',
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776979',
        orderQty: 1,
        image:
            'https://organiclivestockandcrops.org/wp-content/uploads/2018/03/organic-broccoli.png'),
    Product(
        id: 14,
        title: "Potato",
        price: 100,
        category: 'veg',
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776979',
        orderQty: 1,
        image:
            'https://foodimentaryguy.files.wordpress.com/2014/10/www-guildwars2roleplayers-com.png'),
    Product(
        id: 15,
        title: "Carrot",
        price: 100,
        category: 'veg',
        description: dummyText,
        sellerName: 'Chay',
        sellerPhoneNum: '85776979',
        orderQty: 1,
        image:
            'https://purepng.com/public/uploads/medium/purepng.com-single-carrotcarrotonesinglevegetablesfreshdeliciousefoodhealthy-481521740676q8i3l.png'),
  ];



  List<Product> _vegProduct = [];

  List<Product> get items => [..._items];

  List<Product> get vegProduct => [..._vegProduct];

  Product findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
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
    toJson(data).then((value) async => { await StorageServices.setData(value, 'fruit')})
    ;
    notifyListeners();
  }

  //FETCH PRODUCTS INTO DIFFERENT CATEGORIES
  void getVegi() {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].category == 'veg') {
        _vegProduct.add(_items[i]);
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
