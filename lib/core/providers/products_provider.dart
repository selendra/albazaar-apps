import 'package:selendra_marketplace_app/core/models/products.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
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
        color: Color(0xFF3D82AE)),
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
        color: Color(0xFFD3A984)),
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
        color: Color(0xFF989493)),
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
        color: Color(0xFFE6B398)),
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
        color: Color(0xFFFB7883)),
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
        color: Color(0xFFD3A984)),
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
      color: Color(0xFFAEAEAE),
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
        color: Color(0xFF3D82AE)),
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
        color: Color(0xFF989493)),
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
        color: Color(0xFFE6B398)),
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
        color: Color(0xFFFB7883)),
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
      color: Color(0xFFAEAEAE),
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

  List<Product> get items => [..._items];

  List<Product> _vegProduct = [];
  List<Product> get vegProduct => [..._vegProduct];

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  Product findById(int id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addItem(String _title, double _price, String _description,
      String sellerName, String sellerPhone) {
    _items.add(Product(
        id: 20,
        title: _title,
        price: _price,
        description: _description,
        image: "images/new-house.jpg",
        sellerName: sellerName,
        sellerPhoneNum: sellerPhone,
        orderQty: 1,
        color: Color(0xFF3D82AE)));
    notifyListeners();
  }

  void addOrderQty(Product product) {
    product.orderQty++;
    notifyListeners();
  }

  void getVegi() {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].category == 'veg') {
        _vegProduct.add(_items[i]);
      }

      notifyListeners();
    }
  }

  void minusOrderQty(Product product) {
    if (product.orderQty > 1) {
      product.orderQty--;
      notifyListeners();
    }
  }
}
