import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/services/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/ui/reuse_widget/reuse_simple_appbar.dart';
import 'package:albazaar_app/ui/screens/addlisting/components/body.dart';
import 'package:albazaar_app/core/services/app_localize_service.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'dart:async';

class AddListing extends StatefulWidget{

  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {

AddProductProvider _addProductProvider;

  String _error = 'No Error Dectected';

  PostRequest _postRequest = PostRequest();

  // BuildContext context;
  // void routeA() async {
  //   String resultOfC = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => CategoriesListScreen(category)));
  //   setState(() {
  //     // _addProductProvider.categories = resultOfC;
  //   });
  // }
  
  void removeAsset(List<Asset> asset){
    setState(() {
      _addProductProvider.addProduct.images.remove(asset);
    });
  }

  void onChanged(String value, AddProductProvider  addProductProvider) {
    // print(value);
    // print(addProductProvider.addProduct.imageUrl);
    // print(addProductProvider.addProduct.productName.text);
    // print(addProductProvider.addProduct.hintCategory);
    // print(addProductProvider.addProduct.hintWeight);
    // print(addProductProvider.addProduct.price.text);
    // print(addProductProvider.addProduct.hintPaymentOpt);
    // print(addProductProvider.addProduct.description.text);
    
    _product.formKey.currentState.validate();
  }

  void ddOnChanged(String value) {}

  void enableButton(bool enable) {
    setState(() {
      _addProductProvider.addProduct.enable1 = enable;
    });
  }

  void toSeller(AddProductProvider provider, UserProvider user) async {
    var response = await Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => FillSeller(
          addProduct: provider.addProduct,
          userProvider: user,
        )
      )
    );

    if (response != null) Navigator.pop(context, response);
  }

  Future<void> loadAssets() async {
    String error = 'No Error Dectected';

    try {
      await Permission.camera.request().isGranted.then((value) async {
        if (value){
          _addProductProvider.addProduct.images = await MultiImagePicker.pickImages(
            maxImages: 8,
            enableCamera: false,
            selectedAssets: _addProductProvider.addProduct.images,
            cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
            materialOptions: MaterialOptions(
              actionBarColor: '#${kDefaultColor.value.toRadixString(16)}',
              actionBarTitle: "Selendra App",
              allViewTitle: "All Photos",
              useDetailsView: false,
              selectCircleStrokeColor: "#000000",
            ),
          );

          if (_addProductProvider.addProduct.images.isNotEmpty){
            await imageAssetToFile();
          }
        }
      });
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _error = error;
    });

    if (_addProductProvider.addProduct.images.isNotEmpty){
      await getImageUrl();
    }
  }

  Future<void> imageAssetToFile() async {
    // Fetch Image From Asset
    _addProductProvider.addProduct.fileImagesList.clear();
    for (Asset asset in _addProductProvider.addProduct.images) {
      final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      _addProductProvider.addProduct.fileImagesList.add(File(filePath));
    }
  }

  // Use After Display Image
  Future<void> getImageUrl() async {
    // Upload Image To Get Url Image
    try {
      var value = await _postRequest.upLoadImage(_addProductProvider.addProduct.fileImagesList[0], "upload");

      if (value != "522"){
        _addProductProvider.addProduct.imageUrl = json.decode(value)['uri'];
      } else throw("""Something went wrong at our end""");

      // Validate After Get Url Thumnail
      onChanged(_addProductProvider.addProduct.imageUrl, _addProductProvider);

      // // Loop Upload File Images Per Each
      for (int i = 1; i < _addProductProvider.addProduct.fileImagesList.length; i++) {
        await _postRequest
            .upLoadImage(_addProductProvider.addProduct.fileImagesList[i], "upload")
            .then((value) {
          _addProductProvider.addProduct.imageUrlList
              .add(json.decode(value)['uri']);
        });
      }
    } catch (e) {
      await Components.dialog(context, Text(e.toString(), textAlign: TextAlign.center,), Text("Upload Image failed"));
    }
  } 

  void onChangeCategory(String value){

    setState(() {
      for (int i = 0; i < _addProductProvider.addProduct.categoriesList.length; i++) {
        if (value == _addProductProvider.addProduct.categoriesList[i]['category_name']) {
          _addProductProvider.addProduct.category = _addProductProvider.addProduct.categoriesList[i]['id'];
          break;
        }
      }
      _addProductProvider.addProduct.hintCategory = value;

      // Validate After Choose Category
      onChanged(_addProductProvider.addProduct.imageUrl, _addProductProvider);
    });
  }

  void onChangePaymentOption(String value){
    setState(() {
      for (int i = 0; i < _addProductProvider.addProduct.paymentOptsList.length;i++) {
        if (value == _addProductProvider.addProduct.paymentOptsList[i]['options_name']) {
          _addProductProvider.addProduct.paymentOpt =_addProductProvider.addProduct.paymentOptsList[i]['id'];
          break;
        }
      }
      _addProductProvider.addProduct.hintPaymentOpt = value;
    });
  }

  ProductModel _product = ProductModel();
  List<String> images;

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
        _product.images = images;
      });
    }
  }
  
  void onChangeDropDown(String label, String value){
    print(value);
    setState((){
      if (label == 'currency'){
        _product.currency = value;
      } 
      else if (label == 'scale'){
        _product.scale = value;
      }
      else if (label == 'category'){
        _product.categoryDropDown = value;
        _product.category.text = value;
      }
    });
  }

  validateAllInput(){
    if(
      _product.category.text.isNotEmpty &&
      _product.scale != null &&
      _product.currency != null &&
      _product.location != null &&
      _product.images != null &&
      _product.price.text.isEmpty &&
      _product.productName.text.isNotEmpty
    ){
      enableBtn();
    } else if (_product.enable == true){
      enableBtn();
    }
  }

  submitProduct() async {
    
  }

  void enableBtn(){
    setState((){ _product.enable = !_product.enable;});
  }

  @override
  void initState() {
    _addProductProvider = AddProductProvider();
    super.initState();
  }

  @override
  dispose() {
    Timer(Duration(milliseconds: 500), () {
      _addProductProvider.addProduct.clearProductField();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(AppLocalizeService.of(context).translate('add_listing'), context),
      body: Body(
        addProductProvider: _addProductProvider,
        toSeller: toSeller,
        removeAsset: removeAsset,
        onChanged: onChanged,
        onChangeCategory: onChangeCategory,
        onChangeDropDown: onChangeDropDown,
        validateField: validateField,
        onChangedPaymentOption: onChangePaymentOption,
      ),
    );
  } 
}
