import 'package:albazaar_app/all_export.dart';

class CategoriesModel with ChangeNotifier{
  
  String title;
  String img;

  GetRequest _getRequest = GetRequest();
  Backend _backend = Backend();

  List<CategoriesModel> category = [];
  List<Product> listProduct = [];
  List<Product> vegetableList = [];
  List<Product> fruitList = [];
  List<Product> fishList = [];
  List<Product> meatList = [];
  List<Product> carealList = [];
  List<Product> othersList = [];

  List<Map<String, dynamic>> fromDb;
  List<Map<String, dynamic>> listCategories = [];

  CategoriesModel({this.title, this.img}){getCategories();}

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

  List<Product> fillProductByCategories(String category){
    if (category == 'Vegetable'){
      return vegetableList;
    } else if (category == 'Fruit') {
      return fruitList;
    } else if (category == 'Fish'){
      return fishList;
    } else if (category == 'Meat'){
      return meatList;
    } else if (category == 'Cereal'){
      return carealList;
    } else if (category == 'Others'){
      return othersList;
    }
    return null;
  }

  void getCategories() async {
    try{
      _backend.response = await _getRequest.categories();
      _backend.data = json.decode(_backend.response.body);

      listCategories = List.from(_backend.data);

      await StorageServices.setData(listCategories, DbKey.categories);
    } catch (e){
      print(e);
    }

    notifyListeners();
  }

  String findCategoriesById(String categoryId) {
    print("Category ID $categoryId");
    for (var c in listCategories){
      if (c['id'] == categoryId) {
        return c['category_name'];
      }
    }
    return null;
  }

  sortDataByCategory(dynamic data, String account) async {
    clearDataCategory();
    for(var i in data){
      listProductByCategories(account == 'guest' ? Product.fromGuestAccount(i) : i);
    }
    // print("listProduct"+listProduct.length.toString());
    // print("vegetableList"+vegetableList.length.toString());
    // print("fruitList"+fruitList.length.toString());
    // print("fishList"+fishList.length.toString());
    // print("meatList"+meatList.length.toString());
    // print("carealList"+carealList.length.toString());
    // print("othersList"+othersList.length.toString());
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

