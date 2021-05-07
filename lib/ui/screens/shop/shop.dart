import 'package:albazaar_app/core/models/shop_m.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/ui/screens/shop/create_shop/create_shop.dart';
import 'package:albazaar_app/ui/screens/shop/create_shop/create_shop_body.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/ui/screens/shop/components/body.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  
  ShopModel _shopModel = ShopModel();
  ShopProvider _shopProvider = ShopProvider();
  ProductsProvider _productProvider;

  PostRequest _postRequest = PostRequest();
  Backend _backend = Backend();

  // void submit(){
  //   setState(() {
  //     _shopModel.shopCreate = 'created';
  //   });
  // }

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
    await Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct();
    
  }

  // This Function Pass By Parameter (Shop -> Body -> All)
  Future<void> deleteProduct(String id) async {
    print("Delete $id");

    Components.dialogLoading(context: context);
    try {
      _backend.response = await _postRequest.deleteProduct(id);
      _backend.data = json.decode(_backend.response.body);
      //CLose Loading
      Navigator.pop(context);
      
      // _backend.data = json.decode(_backend.response.body);
      await Components.dialog(context, Text('${_backend.data['message'].toString()}', textAlign: TextAlign.center), Text("Message"));

      // Refetch All Product After Deleted
      setState((){});
      await Provider.of<ShopProvider>(context, listen: false).fetchOListingProduct();
      await Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct();
    } catch (e){
      //CLose Loading
      Navigator.pop(context);
      await Components.dialog(context, Text(e.toString()), Text("Message"));
    }
  }

  void upLoadedProduct(AddProduct tmpProductOwner){
    print("Category hint ${tmpProductOwner.hintCategory}");
    setState((){
      // Parse Data From Input Into OwnerProduct Model
      _shopProvider.listProductCreateShop.add(OwnerProduct.fromCreateShop(tmpProductOwner));
    });
  }


  Future<void> triggerLocation() async {

    Components.dialogLoading(context: context);

    await Permission.location.request().then((value) {
      print(value);
    });
    
    if (await Permission.location.status.isGranted){
      await Geolocator().isLocationServiceEnabled().then((value) async {
        if (value){
          await AppServices.getLatLng().then((location) {
            print("Lat ${location.latitude}");
            print("Long ${location.longitude}");
            _shopModel.lat = location.latitude;
            _shopModel.long = location.longitude;
          });

          _shopModel.locationName = await AppServices.getLocation(_shopModel.lat, _shopModel.long);

          AppServices.mapAnimateMove(_shopModel.mapController, LatLng(_shopModel.lat, _shopModel.long), 15.0, this);

          AppServices.markPin(_shopModel.marker, _shopModel.lat, _shopModel.long);
          setState((){});
          
        } else {
          await Components.dialog(context, Text("Please enable your location service"), Text("Message"));
        }
      });
      
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${Permission.location.status}"))
      );
    }

    // Close Loadding
    Navigator.pop(context);
  }

  void onTapTabBar(int index){
    print("Shop change index $index");
    _shopModel.tabController.addListener(() {
      setState((){});
    });
  }

  @override
  void initState() {
    print("Hello init");
    _shopProvider.listProductCreateShop = [];

    _shopModel.init();
    _shopModel.tabController = TabController(vsync: this, length: 3);
    
    super.initState();
    
  }

  @override
  void dispose() {
    _shopModel.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    _shopProvider = Provider.of<ShopProvider>(context);

    // Use Product Provder Here to get All Product Images
    _productProvider = Provider.of<ProductsProvider>(context);

    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: ReuseAppBar.getTitle(
          _lang.translate('listing'),
          context,
          _lang.translate('all_seller'),
          _lang.translate('pending'),
          _lang.translate('complete'),
          _shopModel.tabController,
          shopProvider: _shopProvider,
          upLoadedProduct: upLoadedProduct,
          enableAddIcon: true
        ), //lang.translate('Products')x
        body: Stack(
          children: [
            
            _shopProvider.shopCheck == 'create'
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
                          _shopProvider.shopCheck = 'creating';
                          print("After set ${_shopProvider.allOwnerProduct}");
                        });
                      },
                    )
                  ],
                ),
              )
            ) 
            // Check User Press Create Shop
            : _shopProvider.shopCheck == 'creating'
              ? BodyScaffold(
                // height: MediaQuery.of(context).size.height,
                physics: BouncingScrollPhysics(),
                child: CreateShop(
                  shopModel: _shopModel,
                  shopProvider: _shopProvider,
                  uploadedProduct: upLoadedProduct
                )
              ) 
              // Check Shop Already Create And Display Shop
              : Body(
                shopModel: _shopModel, 
                shopProvider: _shopProvider, 
                productProvider: _productProvider, 
                uploadRemainUrlImage: uploadRemainUrlImage, 
                onTapTabBar: onTapTabBar,
                deleteProduct: deleteProduct,
                triggerLocation: triggerLocation
              ),

                
              
            // Check User Not Yet Create Shop And Show Create Shop Screen
            if ( _shopProvider.shopCheck == '')
            Container(
              color: AppServices.hexaCodeToColor(AppColors.bgColor),
              child: Center(
                child: MyCard(
                  pTop: 20, pRight: 20, pLeft: 20, pBottom: 20,
                  hexaColor: AppColors.white,
                  width: 80,
                  height: 80,
                  alignChild: Alignment.center,
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppServices.hexaCodeToColor(AppColors.primary)))
                ) 
              )
            )
          ],
        )
      )
    );
  }
}
