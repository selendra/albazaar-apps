import 'package:selendra_marketplace_app/all_export.dart';

class AddProduct with ChangeNotifier {
  final formKeyDetail = GlobalKey<FormState>();
  final formKeySeller = GlobalKey<FormState>();

  String productId;

  // Image Url For Upload First Time
  String imageUrl;

  List<String> imageUrlList = List<String>();
  List<Asset> images = List<Asset>();
  List<File> fileImagesList = List<File>();

  List<Map<String, dynamic>> shippingList = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> paymentOptsList = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> categoriesList = List<Map<String, dynamic>>();
  List<Map<String, dynamic>> weightList = List<Map<String, dynamic>>();

  bool enable1 = false;
  bool enable2 = false;

  String  hintWeight = 'Weight',
          hintPaymentOpt = 'Direct Payment',
          hintCategory = 'Category',
          hintShipping = 'Shipping Services';

  String weight = '';
  String paymentOpt = '';
  String category = '';
  String shipping = '';

  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController sellerName = TextEditingController();
  TextEditingController sellerNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  // TextEditingController categories = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController city = TextEditingController();

  FocusNode productNameNode = FocusNode();
  FocusNode titleNode = FocusNode();
  FocusNode priceNode = FocusNode();
  FocusNode descriptionNode = FocusNode();
  FocusNode sellerNameNode = FocusNode();
  FocusNode sellerNumberNode = FocusNode();
  FocusNode addressNode = FocusNode();
  // FocusNode categoriesNode = FocusNode();
  FocusNode districtNode = FocusNode();
  FocusNode cityNode = FocusNode();

  void clearProductField() {
    imageUrl = '';
    images.clear();
    fileImagesList.clear();
    productName.clear();
    price.clear();
    description.clear();
    sellerName.clear();
    sellerNumber.clear();
    address.clear();
    district.clear();
    city.clear();
  }

  void clearSellerField() {
    sellerName.clear();
    sellerNumber.clear();
    address.clear();
    district.clear();
    city.clear();
    hintWeight = 'Weight';
    hintPaymentOpt = 'Payment Method';
    hintCategory = 'Category';
    hintShipping = 'Shipping Services';
  }

  // Product toProduct(AddProduct addProduct, String id, String image, String color, {String categories}){
  //   return Product(
  //     id: int.parse(id),
  //     image: image,
  //     title: addProduct.productName.text,
  //     price: double.parse(addProduct.price.text),
  //     description: addProduct.description.text,
  //     color: color,
  //     sellerName: addProduct.sellerName.text,
  //     sellerPhoneNum: addProduct.sellerNumber.text,
  //     category: categories,
  //     isFavorite: false
  //   );
  // }
}
