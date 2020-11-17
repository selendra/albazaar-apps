import 'package:selendra_marketplace_app/all_export.dart';

class AddProduct {
  
  final formKeyDetail = GlobalKey<FormState>();
  final formKeySeller = GlobalKey<FormState>();

  List<Asset> images = List<Asset>();

  bool enable1 = false;
  bool enable2 = false;

  TextEditingController title = TextEditingController();
  TextEditingController price =  TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController sellerName = TextEditingController();
  TextEditingController sellerNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController categories = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController city = TextEditingController();

  FocusNode titleNode = FocusNode();
  FocusNode priceNode = FocusNode();
  FocusNode descriptionNode = FocusNode();
  FocusNode sellerNameNode = FocusNode();
  FocusNode sellerNumberNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode categoriesNode = FocusNode();
  FocusNode districtNode = FocusNode();
  FocusNode cityNode = FocusNode();

  void dispose(){
    title.dispose();
    price.dispose();
    description.dispose();
    sellerName.dispose();
    sellerNumber.dispose();
    address.dispose();
    categories.dispose();
    district.dispose();
    city.dispose();
  }
}