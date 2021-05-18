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

  final Function uploadedProduct;

  CreateShop({this.shopModel, this.shopProvider, this.uploadedProduct});

  @override
  _CreateShopState createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  //ProductsProvider productsProvider;
  //SellerProvider sellerProvider;
  PostRequest _postRequest = PostRequest();
  Backend _backend = Backend();

  List<String> listImage;

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
    Components.dialogLoading(context: context);
    try {
      widget.shopProvider.listProductCreateShop.forEach((element) async {
        _backend.response = await _postRequest.addListing(OwnerProduct().toAddProduct(element));
      });

      await Components.dialog(context, Text(_backend.data['message'].toString(), textAlign: TextAlign.center), Text("Message"));

      await Future.delayed(Duration(seconds: 1), (){
        // Close Dialog Loading
        Navigator.pop(context);
      });
      
      await Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct();
      await Provider.of<ShopProvider>(context, listen: false).fetchOListingProduct();

    } catch (e) {
      // Close Dialog Loading
      Navigator.pop(context);
      await Components.dialog(context, Text(e['message'].toString()), Text("Message"));
    }
  }

  // Upload Remain Image After Upload Product
  Future<void> uploadSubImage() async {
    _backend.response = await GetRequest().listProductByOwner();
    _backend.data = json.decode(_backend.response.body);
    
    // Upload Image By Product Id
    for (int i = 0; i < _backend.data.length; i++){
      widget.shopProvider.listProductCreateShop[i].subImages.forEach((element) async {
        await _postRequest.addProductImage(element, _backend.data[i]['id']);
      });
    }
    // for (int i = 1; i < listImage.length; i++){
    //   _postRequest.addProductImage(image, productId)
    // }
    print(_backend.response.body);
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
      upLoadedProduct: widget.uploadedProduct
    );
    //_buildTapBarView();
  }
}
