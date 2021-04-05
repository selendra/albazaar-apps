import 'package:albazaar_app/all_export.dart';

class CategoriesModel {
  String title;
  String img;
  List<CategoriesModel> category;
  List<Product> listProduct;

  CategoriesModel({this.title, this.img});

  CategoriesModel.init(){
    category = [
      CategoriesModel(title: 'Vegetable', img: AppConfig.categoryPath+'vegetable.png'),
      CategoriesModel(title: 'Fruit', img: AppConfig.categoryPath+'fish.jpg'),
      CategoriesModel(title: 'Fish', img: AppConfig.categoryPath+'fish.jpg'),
      CategoriesModel(title: 'Meats', img: AppConfig.categoryPath+'meat.jpg'),
      CategoriesModel(title: 'Cereals', img: AppConfig.categoryPath+'careal.jpg'),
      CategoriesModel(title: 'Others', img: AppConfig.categoryPath+'koompi.png'),
    ];
  }

  void listProductCategories(Product product){
    // if (product.categoryName == 'Fish'){

    // } else if (product.categoryName == 'Others') {
      
    // } else if (product.categoryName == 'Meat')
  }

}

