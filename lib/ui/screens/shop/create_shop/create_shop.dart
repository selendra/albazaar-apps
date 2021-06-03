import 'package:albazaar_app/core/models/shop_m.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/core/services/image_picker.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product.dart';
import 'package:albazaar_app/ui/screens/shop/create_shop/create_shop_body.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/card_c.dart';
import 'package:albazaar_app/core/providers/seller_provider.dart';
import 'package:albazaar_app/ui/screens/shop/components/my_dropdown.dart';
import 'package:image_picker/image_picker.dart';

class CreateShop extends StatefulWidget {

  final ShopModel shopModel;

  final ShopProvider shopProvider;

  final Function addingProduct;

  CreateShop({this.shopModel, this.shopProvider, this.addingProduct});

  @override
  _CreateShopState createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  //ProductsProvider productsProvider;
  //SellerProvider sellerProvider;
  PostRequest _postRequest = PostRequest();
  Backend _backend = Backend();

  List<String> listImage;

  List<Map<String, dynamic>> dataUploadedImage = [];

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchListingProduct();
    });
  }

  Future<Null> _refreshSellerList() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
    });
  }

  void onChangeImage(String spotName) async {
    List images = await MyImagePicker.imagePicker();
    if (images != null){
      listImage = await MyImagePicker.getAssettoFile(images);

      print("My Image ${listImage[0]}");
      setState((){
        if(spotName == 'thumbnail'){
          widget.shopModel.thumbnail = listImage[0];

          // Save Sub Image Into shopmodel subimage
          widget.shopProvider.listProductCreateShop.forEach((element) {
            element.subImages = listImage;
          });
        } else {
          widget.shopModel.cover = listImage[0];
        }
      });
    }
  }

  Future<void> submitCreateShop() async {
    Components.dialogLoading(context: context, contents: "Please wait! Your products are uploading");
    try {
      print("List createshop ${widget.shopProvider.listProductCreateShop}");
      
      for(int i = 0; i< widget.shopProvider.listProductCreateShop.length; i++){
        print("Index ${widget.shopProvider.listProductCreateShop[i]}");
        _backend.response = await _postRequest.addListing(OwnerProduct().toAddProduct(widget.shopProvider.listProductCreateShop[i]));

        // Add Response That From Upload Product 
        // For take product Id that response upload with remain product image Url
        _backend.data = await json.decode(_backend.response.body);
        dataUploadedImage.add(_backend.data);
      }

      // Parse Json To Object
      _backend.data = json.decode(_backend.response.body);

      print("What wrong");

      await Components.dialog(context, Text(_backend.data['message'].toString(), textAlign: TextAlign.center), Text("Message"));

      print("2");

      // Upload Remain Image
      uploadSubImage();
      print("1");

      await Future.delayed(Duration(seconds: 1), (){
        // Close Dialog Loading
        Navigator.pop(context);
      });
      
      await Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct(refetch: true);
      // For Upload Image
      await StorageServices.fetchData(DbKey.token).then((value) async {
        await Provider.of<ProductsProvider>(context, listen: false).getAllProductImg(value['token']);
      });

      await Provider.of<ShopProvider>(context, listen: false).fetchOListingProduct();


    } on Exception catch (e){
      
      print(e);
      // Close Dialog Loading
      Navigator.pop(context);
      await Components.dialog(context, Text("Connection timed out"), Text("Oops"));
    }
    catch (e) {
      print(e);
      // Close Dialog Loading
      Navigator.pop(context);
      await Components.dialog(context, Text(e.toString()), Text("Oops"));
    }
  }

  // Upload Remain Image After Upload Product
  void uploadSubImage() async {

    print(dataUploadedImage);
    print(dataUploadedImage.length);
    int i = 0;

    // Upload Image By Product Id
    for (; i < dataUploadedImage.length; i++){

      print("REmain images ${widget.shopProvider.listProductCreateShop[i].subImages}");
      print(dataUploadedImage[i]['id']);
      print("Leng ${widget.shopProvider.listProductCreateShop[i].subImages.length}");

      if (widget.shopProvider.listProductCreateShop[i].subImages.isEmpty) break;

      for (int j = 0; j < widget.shopProvider.listProductCreateShop[i].subImages.length; j++){
        print("Hello j $j");
        print("J length ${widget.shopProvider.listProductCreateShop[i].subImages.length}");
        final res = await _postRequest.addProductImage(widget.shopProvider.listProductCreateShop[i].subImages[j], dataUploadedImage[i]['id']);
        print("Upload remain image ${res.body}");
      }

      print("what the fuck");
      // widget.shopProvider.listProductCreateShop[i].subImages.forEach((element) async {
      //   await _postRequest.addProductImage(element, _backend.data[i]['id']);
      // });
    }

    

    print("I $i");
    // for (int i = 1; i < listImage.length; i++){
    //   _postRequest.addProductImage(image, productId)
    // }
  }
  
  // Clear All Upload Product
  void cleanData(){
    dataUploadedImage.clear();
    widget.shopProvider.listProductCreateShop.clear();
  }

  @override
  void initState() {
    listImage = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreateShopBody(
      listProduct: widget.shopProvider.listProductCreateShop, 
      shopModel: widget.shopModel, 
      onChangeImage: onChangeImage,
      submitCreateShop: submitCreateShop, 
      addingProduct: widget.addingProduct
    );
    //_buildTapBarView();
  }
}