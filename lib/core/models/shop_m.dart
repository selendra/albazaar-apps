import 'package:albazaar_app/all_export.dart';

class ShopModel {

  TabController controller;

  bool isSold = false;
  String shopCreate = 'no';

  String thumbnail;
  String bgImage;
  String address;
  List<Product> product;
  TextEditingController about;

  void init(){
    thumbnail = '';
    bgImage = '';
    address = '';
    product = [];
    about = TextEditingController();
  }
}