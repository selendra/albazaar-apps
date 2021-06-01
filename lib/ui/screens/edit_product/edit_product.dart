import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/core/services/auth/find_service.dart';
import 'package:albazaar_app/core/services/image_picker.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product_body.dart';

class EditProduct extends StatefulWidget {

  final OwnerProduct productOwner;

  // We declare For Get All Of (Category, Shipping service, Weight, Payment method)
  final AddProductProvider addProductProvider;

  EditProduct({this.productOwner, this.addProductProvider});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  ProductModel _productModel = ProductModel();
  PostRequest _postRequest = PostRequest();
  Backend _backend = Backend();

  void onChanged(String value){
    _productModel.formKey.currentState.validate();
  }

  void onSubmit(String value){

  }

  String validateField(String value, {String label}){
    if (_productModel.productNameNode.hasFocus){
      print("Product $label");
    } else if (_productModel.priceNode.hasFocus){
      print("Price $label");
    } else if (_productModel.locationNode.hasFocus){
      print("Location $label");
    } else if (_productModel.descriptionNode.hasFocus){
      print("Description $label");
    }
    return "Error";
  }

  void onChangeImage() async {
    // Trigger Image
    List fromPicker = await MyImagePicker.imagePicker(maxImages: 10);
    if (fromPicker != null){
      // Get Image From List Asset 
      await MyImagePicker.getAssettoFile(fromPicker).then((value) => 
        _productModel.images.addAll(value)
      );

      print(_productModel.images);
      setState((){
      });
    }

        
    _productModel.images.forEach((element) async {
      if (!element.contains('https')){
        await getImageUrl(element);
      }
    });
  }

  Future<void> getImageUrl(String image) async {
    print("Image path $image");
    try {
      await _postRequest.upLoadImage(File(image), 'upload').then((value) {
        _backend.data = json.decode(value);

        // Add Image Uri Into TmpImageUrl For After Submit Edit Will Submit later
        _productModel.tmpImagesUrl.add(_backend.data['uri']);
      });

      print("Temp images url ${_productModel.tmpImagesUrl}");
    } catch (e){
      print("Error of get image ${e.toString()}");
    }
  }
  
  void onChangeDropDown(String label, Map<String, dynamic> value){
    print(value);
    setState((){

      if (label == 'currency') {
        _productModel.currency = value['currency_name'];
      } else if (label == 'scale') {
        _productModel.scale = value['weight_option'];
        _productModel.scaleId = value['id'];
      } else if (label == 'category') {
        _productModel.categoryDropDown = value['category_name'];
        _productModel.categoryId = value['id'];
      } else if (label == 'shipping') {
        _productModel.shippingOpt = value['shipping_service'];
        _productModel.shippingOptId = value['id'];
      } else if (label == 'payment') {
        _productModel.paymentOpt = value['options_name'];
        _productModel.paymentOptId = value['id'];
      }

      print("My category name ${_productModel.categoryDropDown}");

      // if (label == 'currency'){
      //   _productModel.currency = value;
      // } 
      // else if (label == 'scale'){
      //   _productModel.scale = value;
      // }
      // else if (label == 'category'){
      //   _productModel.categoryDropDown = value;
      //   _productModel.category.text = value;
      // }
    });
  }

  validateAllInput(){
    if(
      _productModel.category.text.isNotEmpty &&
      _productModel.scale != null &&
      _productModel.currency != null &&
      _productModel.location != null &&
      _productModel.images != null &&
      _productModel.price.text.isEmpty &&
      _productModel.productName.text.isNotEmpty
    ){
      enableBtn();
    } else if (_productModel.enable == true){
      enableBtn();
    }
  }

  void enableBtn(){
    setState((){ _productModel.enable = !_productModel.enable;});
  }

  void removeImageByIndex(int index){
    print("My index $index");
    setState(()=> widget.productOwner.listImages.removeAt(index));
  }

  Future<void> submitProduct(OwnerProduct ownerProduct) async {
    Components.dialogLoading(context: context);
    
    try{
      await PostRequest().updateProduct(ownerProduct).then((value) async {
        // Close Loading
        Navigator.pop(context);

        print("Edit ${value.body}");

        if (value.statusCode == 200){
          await Components.dialog(context, MyText(text: json.decode(value.body)['message']), Text("Message"));

          // // Refetch Product Owner
          // await Provider.of<ShopProvider>(context, listen: false).fetchOListingProduct();

          // Close Edit Screen
          // We pass productModel because we need images inside tmpImagesUrl To Upload One By One
          // We pass productOwner.Category because we need product Id
          Navigator.pop(context, {'remainUrlImage': _productModel.tmpImagesUrl, 'productId': widget.productOwner.id});
        }
      });
    } catch (e){
      print("Hello error");

      // Close Dialog Loading
      Navigator.pop(context);
      await Components.dialog(context, Text(e.toString()), Text("Message"));
      print(e);
    }
  }

  @override
  void initState(){
    _productModel.images = [];

    _productModel = ProductModel.initalizeData();

    widget.productOwner.weightName = FindingServices().findScaleById(widget.productOwner.weight, widget.addProductProvider.addProduct.weightList);
    widget.productOwner.shippingName = FindingServices().findShippingById(widget.productOwner.shippingId, widget.addProductProvider.addProduct.shippingList);
    widget.productOwner.paymentName = FindingServices().findPaymentById(widget.productOwner.paymentId, widget.addProductProvider.addProduct.paymentOptsList);
    // print("My weight ${widget.productOwner.weightName}");

    _productModel = ProductModel.fromOwner(widget.productOwner);

    // Insert Thumbnail Into images of ProductModel
    if (_productModel.images.isEmpty){
      _productModel.images.insert(0, widget.productOwner.thumbnail);
    }
    _productModel.tmpImagesUrl = [];

    // widget.productOwner.productModel.currency = 'Currency';
    // widget.productOwner.productModel.scale = 'Scale';
    // widget.productOwner.productModel.categoryDropDown = 'Category';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    // _productModel.categoryDropDown = _productModel.category.text;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          brightness: Brightness.light,
          titleSpacing: 0,
          // leadingWidth: 25,
          title: MyText(
            text: "Edit Product",
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
            productOwner: widget.productOwner,
            productModel: _productModel,
            onChanged: onChanged,
            validate: validateField,
            onChangeImage: onChangeImage,
            onChangeDropDown: onChangeDropDown,
            removeImageByIndex: removeImageByIndex,
            onSubmit: onSubmit,
            submitProduct: submitProduct,
          )
        ),
      ),
    );
  }
}