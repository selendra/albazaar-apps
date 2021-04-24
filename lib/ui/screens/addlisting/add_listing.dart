import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/core/services/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/ui/reuse_widget/reuse_simple_appbar.dart';
import 'package:albazaar_app/ui/screens/addlisting/components/body.dart';
import 'package:albazaar_app/core/services/app_localize_service.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'dart:async';

class AddListing extends StatefulWidget {

  final String from;

  AddListing({this.from});

  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {

  AddProductProvider _addProductProvider;

  String _error = 'No Error Dectected';

  PostRequest _postRequest = PostRequest();

  ProductModel _productModelModel = ProductModel();

  Backend _backend = Backend();

  void removeAsset(List<Asset> asset) {
    setState(() {
      _addProductProvider.addProduct.images.remove(asset);
    });
  }

  void onChanged(String value, AddProductProvider addProductProvider) {
    // print(value);
    // print(addProductProvider.addProduct.imageUrl);
    // print(addProductProvider.addProduct.productName.text);
    // print(addProductProvider.addProduct.hintCategory);
    // print(addProductProvider.addProduct.hintWeight);
    // print(addProductProvider.addProduct.price.text);
    // print(addProductProvider.addProduct.hintPaymentOpt);
    // print(addProductProvider.addProduct.description.text);

    _productModel.formKey.currentState.validate();
    validateAllInput();
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
                )));

    if (response != null) Navigator.pop(context, response);
  }

  Future<void> loadAssets() async {
    // String error = 'No Error Dectected';

    // try {
    //   await Permission.camera.request().isGranted.then((value) async {
    //     if (value) {
    //       _addProductProvider.addProduct.images =
    //           await MultiImagePicker.pickImages(
    //         maxImages: 8,
    //         enableCamera: false,
    //         selectedAssets: _addProductProvider.addProduct.images,
    //         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
    //         materialOptions: MaterialOptions(
    //           actionBarColor: '#${kDefaultColor.value.toRadixString(16)}',
    //           actionBarTitle: "Selendra App",
    //           allViewTitle: "All Photos",
    //           useDetailsView: false,
    //           selectCircleStrokeColor: "#000000",
    //         ),
    //       );

    //       if (_addProductProvider.addProduct.images.isNotEmpty) {
    //         await imageAssetToFile();
    //       }
    //     }
    //   });
    // } on Exception catch (e) {
    //   error = e.toString();
    // }

    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   _error = error;
    // });

    // if (_addProductProvider.addProduct.images.isNotEmpty) {
    //   await getImageUrl();
    // }
  }

  Future<void> imageAssetToFile() async {
    // Fetch Image From Asset
    _addProductProvider.addProduct.fileImagesList.clear();
    for (Asset asset in _addProductProvider.addProduct.images) {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      _addProductProvider.addProduct.fileImagesList.add(File(filePath));
    }
  }

  // Use After Display Image
  // Future<void> getImageUrl() async {
  //   // Upload Image To Get Url Image
  //   try {
  //     var value = await _postRequest.upLoadImage(
  //         _addProductProvider.addProduct.fileImagesList[0], "upload");

  //     if (value != "522") {
  //       _addProductProvider.addProduct.imageUrl = json.decode(value)['uri'];
  //     } else
  //       throw ("""Something went wrong at our end""");

  //     // Validate After Get Url Thumnail
  //     onChanged(_addProductProvider.addProduct.imageUrl, _addProductProvider);

  //     // // Loop Upload File Images Per Each
  //     for (int i = 1;
  //         i < _addProductProvider.addProduct.fileImagesList.length;
  //         i++) {
  //       await _postRequest
  //           .upLoadImage(
  //               _addProductProvider.addProduct.fileImagesList[i], "upload")
  //           .then((value) {
  //         _addProductProvider.addProduct.imageUrlList
  //             .add(json.decode(value)['uri']);
  //       });
  //     }
  //   } catch (e) {
  //     await Components.dialog(
  //         context,
  //         Text(
  //           e.toString(),
  //           textAlign: TextAlign.center,
  //         ),
  //         Text("Upload Image failed"));
  //   }
  // }

  void onChangeCategory(Map<String, dynamic> category) {
    setState(() {
      _productModel.categoryDropDown = category['category_name'];
      // for (int i = 0;
      //     i < _addProductProvider.addProduct.categoriesList.length;
      //     i++) {
      //   if (value ==
      //       _addProductProvider.addProduct.categoriesList[i]['category_name']) {
      //     _addProductProvider.addProduct.category =
      //         _addProductProvider.addProduct.categoriesList[i]['id'];
      //     break;
      //   }
      // }
      // _addProductProvider.addProduct.hintCategory = value;

      // Validate After Choose Category
      validateAllInput();
    });
  }

  void onChangePaymentOption(String value) {
    setState(() {
      // _productModel.categoryDropDown = category['category_name'];
      // for (int i = 0;
      //     i < _addProductProvider.addProduct.paymentOptsList.length;
      //     i++) {
      //   if (value ==
      //       _addProductProvider.addProduct.paymentOptsList[i]['options_name']) {
      //     _addProductProvider.addProduct.paymentOpt =
      //         _addProductProvider.addProduct.paymentOptsList[i]['id'];
      //     break;
      //   }
      // }
      // _addProductProvider.addProduct.hintPaymentOpt = value;
      // Validate After Choose Category
      validateAllInput();
    });
  }

  ProductModel _productModel;
  List<String> images;

  void onSubmit(String value) {}

  String validateField(String value, {String label}) {
    if (_productModel.productNameNode.hasFocus) {
      // print("Product $label");
    } else if (_productModel.priceNode.hasFocus) {
      // print("Price $label");
    } else if (_productModel.locationNode.hasFocus) {
      // print("Location $label");
    } else if (_productModel.descriptionNode.hasFocus) {
      // print("Description $label");
    }
    return "Error";
  }

  // void onChangeImage() async {
  //   List fromPicker = await MyImagePicker.imagePicker();
  //   if (fromPicker != null) {
  //     images = await MyImagePicker.getAssettoFile(fromPicker);

  //     setState(() {
  //       _productModel.images = images;
  //     });
  //   }
  // }

  void onChangeDropDown(String label, Map<String, dynamic> value) {
    print(value);
    setState(() {
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
    });
    validateAllInput();
  }

  void validateAllInput() {
    // print(_productModel.images);
    // print(_productModel.productName.text);
    // print(_productModel.price.text);
    // print(_productModel.categoryDropDown);
    // print(_productModel.scale);
    if (
      // _productModel.category.text.isNotEmpty &&
      // _productModel.currency != null &&
      // _productModel.location != null &&
      _productModel.images.isNotEmpty &&
      _productModel.productName.text.isNotEmpty &&
      _productModel.price.text.isNotEmpty &&
      _productModel.categoryDropDown != 'Category' &&
      _productModel.scale != 'Scale'
    ) {
      enableBtn(true);
    } else if (_productModel.enable == true) {
      enableBtn(false);
    }
  }

  void enableBtn(bool value) {
    print("Button ${_productModel.enable}");
    setState(() {
      _productModel.enable = value;
    });
  }

  void removeImageByIndex(int index){
    print("My index $index");
    setState(()=> _productModel.images.removeAt(index));
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

  Future<void> submitProduct(AddProduct addProduct) async {
    print("From ${widget.from}");
    if(widget.from == "fromCreateShop"){
      Navigator.pop(context, addProduct);
    } else {
      Components.dialogLoading(context: context);
      try{
        _backend.response = await _postRequest.addListing(addProduct);

        _backend.data = json.decode(_backend.response.body);

        await Future.delayed(Duration(seconds: 1), (){
          //Close Loading
          Navigator.pop(context);
        });

        await Components.dialog(context, Text(_backend.data['message'].toString(), textAlign: TextAlign.center,), Text("Message"));

        Provider.of<ShopProvider>(context, listen: false).fetchOListingProduct();
        Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct();

        Navigator.pop(context);
        
      } catch (e){

        //Close Loading
        Navigator.pop(context);
        await Components.dialog(context, Text(e['message'].toString()), Text("Message"));
      }
    }
  }

  @override
  void initState() {
    print("From my ${widget.from}}");
    _productModel = ProductModel.initalizeData();
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
    _addProductProvider = Provider.of<AddProductProvider>(context);
    // UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(AppLocalizeService.of(context).translate('add_listing'), context),
      body: BodyScaffold(
        physics: BouncingScrollPhysics(),
        child: Body(
          addProductProvider: _addProductProvider,
          productModel: _productModel,
          toSeller: toSeller,
          removeAsset: removeAsset,
          removeImageByIndex: removeImageByIndex,
          onChangeImage: onChangeImage,
          onChanged: onChanged,
          onChangeCategory: onChangeCategory,
          onChangeDropDown: onChangeDropDown,
          validateField: validateField,
          onChangedPaymentOption: onChangePaymentOption,
          submitProduct: submitProduct,
        )
      ),
    );
  }
}
