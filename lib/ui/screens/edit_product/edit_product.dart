import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/services/image_picker.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product_body.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  ProductModel _product = ProductModel();
  List<String> images;

  void onChanged(String value){
    _product.formKey.currentState.validate();
  }

  void onSubmit(String value){

  }

  String validateField(String value, {String label}){
    if (_product.productNameNode.hasFocus){
      print("Product $label");
    } else if (_product.priceNode.hasFocus){
      print("Price $label");
    } else if (_product.locationNode.hasFocus){
      print("Location $label");
    } else if (_product.descriptionNode.hasFocus){
      print("Description $label");
    }
    return "Error";
  }

  void onChangeImage() async {
    List fromPicker = await MyImagePicker.imagePicker();
    if (fromPicker != null){
      images = await MyImagePicker.getAssettoFile(fromPicker);

      setState((){
        _product.image = images[0];
      });
    }
  }
  
  void onChangeDropDown(String label, String value){
    print(value);
    setState((){
      if (label == 'currency'){
        _product.currency = value;
      } else {
        _product.category.text = value;
      }
    });
  }

  @override
  void initState(){
    _product.currency = 'Currency';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          brightness: Brightness.light,
          titleSpacing: 0,
          // leadingWidth: 25,
          title: MyText(
            text: "Add Product",
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
          // bottom: ReuseTabBar.getItem(appBarItemOne, appBarItemTwo, appBarItemThree, controller, context),
          //  backgroundColor: Colors.white,
          leading: IconButton(
            padding: EdgeInsets.only(left: 25),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: AppServices.hexaCodeToColor(AppColors.primary),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BodyScaffold(
          // height: MediaQuery.of(context).size.height,
          child: EditProductBody(
            product: _product,
            onChanged: onChanged,
            validate: validateField,
            onChangeImage: onChangeImage,
            onChangeDropDown: onChangeDropDown,
            onSubmit: onSubmit,
          )
        ),
      ),
    );
  }
}