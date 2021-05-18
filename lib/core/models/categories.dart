import 'package:albazaar_app/all_export.dart';

class CategoriesModel with ChangeNotifier{
  
  String title;
  String img;

  GetRequest _getRequest = GetRequest();
  Backend _backend = Backend();

  // List Type Of Category
  List<CategoriesModel> category = [];
  List<Product> listProduct = [];
  List<Product> vegetableList = [];
  List<Product> fruitList = [];
  List<Product> fishList = [];
  List<Product> meatList = [];
  List<Product> carealList = [];
  List<Product> othersList = [];

  // For Related Product
  List<Product> relatedProduct = [];

  List<Map<String, dynamic>> fromDb;
  List<Map<String, dynamic>> listCategories = [];

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

  void collectProductByCategories(Product product){
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
      sortDataByCategory(fromDb);
    }
  }

  List<Product> getListProductCategory(String category){

    print("Fill category");
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

  List<Product> getRelatedProduct(String category){
    if (category == 'Vegetable'){
      vegetableList.forEach((element) {
        relatedProduct.add(element);
      });
    } else if (category == 'Fruit') {
      fruitList.forEach((element) {
        relatedProduct.add(element);
      });
    } else if (category == 'Fish'){
      fishList.forEach((element) {
        relatedProduct.add(element);
      });
    } else if (category == 'Meat'){
      meatList.forEach((element) {
        relatedProduct.add(element);
      });
    } else if (category == 'Cereal'){
      carealList.forEach((element) {
        relatedProduct.add(element);
      });
    } else if (category == 'Others'){
      othersList.forEach((element) {
        relatedProduct.add(element);
      });
    }
    return relatedProduct;
  }

  String findCategoriesById(String categoryId) {
    for (var c in listCategories){
      if (c['id'] == categoryId) {
        return c['category_name'];
      }
    }
    return null;
  }

  // Run in Home Body
  sortDataByCategory(dynamic data) async {

    print("My List product $data");
    try {
      clearDataCategory();

      // await StorageServices.fetchData('guestAcc').then((value) {
      //   if (value != null){
      //     print("From Guest");
      //     for(var i in data){
      //       collectProductByCategories(Product.fromGuestAccount(i));
      //     }
      //   } else {
      //     print("From User"); 
      //   }
      // });
      for(var i in data){
        collectProductByCategories(i);
      }
    } catch (e){
      print("Sort Data By Category Error ${e.toString()}");
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
    print("Before $vegetableList");
    print("Start clear category data");
    relatedProduct.clear();
    vegetableList.clear();
    fruitList.clear();
    fishList.clear();
    meatList.clear();
    carealList.clear();
    othersList.clear();
  }

}

