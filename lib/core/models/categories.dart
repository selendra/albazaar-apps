import 'package:albazaar_app/all_export.dart';

class CategoriesModel with ChangeNotifier{
  
  String title;
  String img;

  List<CategoriesModel> category = [];
  List<Product> listProduct = [];
  List<Product> vegetableList = [];
  List<Product> fruitList = [];
  List<Product> fishList = [];
  List<Product> meatList = [];
  List<Product> carealList = [];
  List<Product> othersList = [];

  List<Map<String, dynamic>> fromDb;

  CategoriesModel({this.title, this.img});

  void init(){
    category = [
      CategoriesModel(title: 'Vegetable', img: AppConfig.categoryPath+'vegetable.png'),
      CategoriesModel(title: 'Fruit', img: AppConfig.categoryPath+'fruit.jpg'),
      CategoriesModel(title: 'Fish', img: AppConfig.categoryPath+'fish.jpg'),
      CategoriesModel(title: 'Meat', img: AppConfig.categoryPath+'meat.jpg'),
      CategoriesModel(title: 'Cereal', img: AppConfig.categoryPath+'careal.jpg'),
      CategoriesModel(title: 'Others', img: AppConfig.categoryPath+'koompi.png'),
    ];
  }

  void listProductByCategories(Product product){
    print("Sorting ${product.categoryName}");
    if (product.categoryName == 'Vegetable'){
      vegetableList.add(product);
    } else if (product.categoryName == 'Fruit') {
      fruitList.add(product);
    } else if (product.categoryName == 'Fish'){
      fishList.add(product);
    } else if (product.categoryName == 'Meat'){
      meatList.add(product);
    } else if (product.categoryName == 'Cereal'){
      carealList.add(product);
    } else if (product.categoryName == 'Others'){
      othersList.add(product);
    }
  }

  getData() async {
    fromDb = List<Map<String, dynamic>>.from(await StorageServices.fetchData(AppConfig.categoryPath));
    clearAllData();
    clearDataCategory();
    if (fromDb != null) {
      sortDataByCategory(fromDb, 'guest');
    }
  }

  sortDataByCategory(dynamic data, String account) async {
    clearDataCategory();
    for(var i in data){
      listProductByCategories(account == 'guest' ? Product.fromGuestAccount(i) : i);
    }
  }

  void clearAllData(){
    listProduct.clear();
  }

  void clearDataCategory(){
    vegetableList.clear();
    fruitList.clear();
    fishList.clear();
    meatList.clear();
    carealList.clear();
    othersList.clear();
  }

}

