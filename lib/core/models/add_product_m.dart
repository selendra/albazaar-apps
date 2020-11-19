import 'package:selendra_marketplace_app/all_export.dart';

class AddProduct {
  
  final formKeyDetail = GlobalKey<FormState>();
  final formKeySeller = GlobalKey<FormState>();

  List<Asset> images = List<Asset>();
  List<Map<String, dynamic>> shippingServics = List<Map<String, dynamic>>();

  bool enable1 = false;
  bool enable2 = false;

  String weight= '', paymentId = '';

  TextEditingController name = TextEditingController();
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
    name.dispose();
    price.dispose();
    description.dispose();
    sellerName.dispose();
    sellerNumber.dispose();
    address.dispose();
    categories.dispose();
    district.dispose();
    city.dispose();
  }

  Product toProduct(AddProduct addProduct, String id, String image, String color){
    return Product(
      id: int.parse(id),
      image: image,
      title: addProduct.name.text,
      price: double.parse(addProduct.price.text),
      description: addProduct.description.text, 
      color: color, 
      sellerName: addProduct.sellerName.text, 
      sellerPhoneNum: addProduct.sellerNumber.text, 
      category: addProduct.categories.text, 
      isFavorite: false
    );
  }
}