import 'package:albazaar_app/core/models/shop_m.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/ui/screens/shop/create_shop/create_shop.dart';
import 'package:albazaar_app/ui/screens/shop/create_shop/create_shop_body.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/screens/shop/components/body.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  
  ShopModel _shopModel = ShopModel();
  ShopProvider _shopProvider;
  ProductsProvider _productProvider;

  PostRequest _postRequest = PostRequest();
  Backend _backend = Backend();

  // void submit(){
  //   setState(() {
  //     _shopModel.shopCreate = 'created';
  //   });
  // }
  
  void isCreatedShop() async {
    try {
      await StorageServices.fetchData(DbKey.shop).then((value) {
        print("MY response DBKey shop $value");
        if (value != null){
          setState((){
            _shopModel.shopCreate = value;
          });
        }
      });

      if (_shopModel.shopCreate == "created")
      print(_shopModel.shopCreate.runtimeType);
    } catch (e){
      print(e.toString() + "Is created shop");
    }
  }

  // This Function Pass By Parameter (Shop -> Body -> All)
  Future<void> uploadRemainUrlImage(ProductModel productModel, String productId) async {

    print("After  Success edit");
    print(productModel.tmpImagesUrl);
    print(productId);

    // Remove File Images From Images Url
    // productOwner.listImages.forEach((element) {
    //   if(!element.contains('https')){
    //     productOwner.listImages.removeAt(productOwner.listImages.indexOf(element));
    //   }
    // });
    
    // Upload Image One By One
    productModel.tmpImagesUrl.forEach((element) async {
      await _postRequest.addProductImage(element, productId).then((value) {
        print(value.body);
      });
    });

    // Refetch Data product Owner
    await Provider.of<ShopProvider>(context, listen: false).fetchOListingProduct();
  }

  // This Function Pass By Parameter (Shop -> Body -> All)
  Future<void> deleteProduct(String id) async {
    print("Delete $id");

    Components.dialogLoading(context: context);
    try {
      // _backend.response = await _postRequest.deleteProduct(id);
      //CLose Loading
      Navigator.pop(context);
      // _backend.data = json.decode(_backend.response.body);
      await Components.dialog(context, Text('_backend.data.toString()', textAlign: TextAlign.center), Text("Message"));

      // Refetch All Product After Deleted
      setState((){});
      await Provider.of<ShopProvider>(context, listen: false).fetchOListingProduct();
    } catch (e){
      await Components.dialog(context, Text(e.toString()), Text("Message"));
    }
  }

  @override
  void initState() {
    super.initState();

    isCreatedShop();

    _shopModel.init();
    _shopModel.controller = TabController(vsync: this, length: 3);
    
  }


  @override
  void dispose() {
    _shopModel.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    _shopProvider = Provider.of<ShopProvider>(context);
    print("My all ${_shopProvider.allOwnerProduct}");
    // Use Product Provder Here to get All Product Images
    _productProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: ReuseAppBar.getTitle(
        _lang.translate('listing'),
        context,
        _lang.translate('all_seller'),
        _lang.translate('pending'),
        _lang.translate('complete'),
        _shopModel.controller
      ), //lang.translate('Products')x
      body: 
      _shopProvider.allOwnerProduct == null 
      ? BodyScaffold(
        height: MediaQuery.of(context).size.height,
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/create_shop.svg', width: 293, height: 293),

              MyFlatButton(
                edgeMargin: EdgeInsets.only(left: 110, right: 110),
                height: 70,
                border: Border.all(color: AppServices.hexaCodeToColor(AppColors.primary), width: 2),
                isTransparent: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.primary)),
                    MyText(left: pd10, text: "Create Shop", fontWeight: FontWeight.w600, color: AppColors.primary,),
                  ],
                ),
                action: (){
                  setState(() {
                    _shopProvider.allOwnwerProductSetter = List<OwnerProduct>.empty(growable: true);
                    print("After set ${_shopProvider.allOwnerProduct}");
                  });
                },
              )
            ],
          ),
        )
      ) 
      // Check User Press Create Shop
      : _shopProvider.allOwnerProduct.isEmpty
        ? BodyScaffold(
          // height: MediaQuery.of(context).size.height,
          physics: BouncingScrollPhysics(),
          child: CreateShop(shopModel: _shopModel)
        ) : Body(_shopModel.controller, shopProvider: _shopProvider, productProvider: _productProvider, uploadRemainUrlImage: uploadRemainUrlImage, deleteProduct: deleteProduct)

      // Check Shop Already Create And Display Shop
      // _shopProvider.allOwnerProduct != List<OwnerProduct>.empty() && _shopProvider.allOwnerProduct != null ? 

        // BodyScaffold(
        //   physics: BouncingScrollPhysics(),
        //   child: 
          
        // )
         
      
        // Check User Not Yet Create Shop And Show Create Shop Screen
    );
  }
}
