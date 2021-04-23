import 'package:albazaar_app/core/models/shop_m.dart';
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

  CreateShop({this.shopModel});

  @override
  _CreateShopState createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  //ProductsProvider productsProvider;
  //SellerProvider sellerProvider;

  List<OwnerProduct> listProduct = <OwnerProduct>[]; 

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

  void submit() async   {
    await StorageServices.setData('created', DbKey.shop);
  }

  void onChangeImage(String spotName) async {
    List images = await MyImagePicker.imagePicker();
    if (images != null){
      listImage = await MyImagePicker.getAssettoFile(images);

      print("My Image ${listImage[0]}");
      setState((){
        if(spotName == 'thumbnail'){
          widget.shopModel.thumbnail = listImage[0];
        } else {
          widget.shopModel.bgImage = listImage[0];
        }
      });
    }
  }

  void upLoadedProduct(AddProduct tmpProductOwner){
    setState((){
      listProduct.add(OwnerProduct.fromCreateShop(tmpProductOwner));
    });
  }

  @override
  void initState() {
    listImage = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CreateShopBody(listProduct: listProduct, shopModel: widget.shopModel, onChangeImage: onChangeImage, submit: submit, upLoadedProduct: upLoadedProduct);
    //_buildTapBarView();
  }
}
