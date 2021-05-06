import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/ui/screens/shop/components/tabBar/all_product_owner.dart';
import 'package:albazaar_app/ui/screens/shop/components/shop_header.dart';
import 'package:albazaar_app/ui/screens/shop/components/shop_tabbar.dart';
import 'package:albazaar_app/ui/screens/shop/components/tabBar/pending.dart';
import 'package:albazaar_app/ui/screens/shop/components/tabBar/sold.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class ShopSliverHeader{

  final double cPadding = 10;
  final double padding = 16;
  
  List<Widget> sliverHeader({
    ShopModel shopModel,
    bool enableDelete,
    ShopProvider shopProvider,
    ProductsProvider productProvider,
    BuildContext context,
    TabController tabController,
    Function onTapTabBar,

    // From Body.dart
    Function refresh,
    Function refreshSellerList,

    Function uploadRemainUrlImage,
    Function deleteProduct,
    Function onChanged,
    Function triggerLocation,
    Function editHeader,
  }){
    return [
      // Header
      SliverPersistentHeader(
        pinned: false,
        delegate: MySliverAppBarDelegate(
          minHeight: 400,
          maxHeight: 400,
          child: ShopHeader(
            shopModel: shopModel,
            editHeader: editHeader,
          )
        )
      ),

      // Location
      SliverPersistentHeader(
        pinned: false,
        delegate: MySliverAppBarDelegate(
          minHeight: 50.0,
          maxHeight: 50.0,
          child: GestureDetector(
            onTap: () async{
              // Components.dialogLoading(context: context);
              final response = await MyBottomSheet().locationOptions(context: context);
              if (response != null){
                if (response == 0){
                  await Navigator.push(context, MaterialPageRoute(builder: (context) =>  MapScreen())).then((value) {
                    print(value);
                  });
                } else if (response == 1){
                  await triggerLocation();
                }
              }
              print("My reponse location $response");
            },
            child: MyPadding(
              pBottom: pd10, pRight: pd10+2, pLeft: pd10+2, pTop: pd10,
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/plus.svg', width: 18, height: 18, color: AppServices.hexaCodeToColor(AppColors.secondary)),
                  MyText(left: pd10, text: "Set Address", fontWeight: FontWeight.w600, color: AppColors.secondary,),
                ],
              ),
            ),
          ),
        ),
      ),

      SliverPersistentHeader(
        pinned: false,
        delegate: MySliverAppBarDelegate(
          minHeight: 250,
          maxHeight: 250,
          child: MyPadding(
            pLeft: pd10+2, pRight: pd10+2,
            child: MyCard(
              boxShadow: [
                boxShadow()
              ],
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: FlutterMap(
                      mapController: shopModel.mapController,
                      options: MapOptions(
                        center: shopModel.lat != null && shopModel.long != null
                        ? LatLng(shopModel.lat, shopModel.long)
                        : LatLng(12.509, 105.634),
                        zoom: 13.0,
                        screenSize: MediaQuery.of(context).size,
                        interactive: false,
                        slideOnBoundaries: true,
                        maxZoom: kDefaultMaxZoom,
                        minZoom: kDefaultMinZoom,
                      ),
                      layers: [
                        TileLayerOptions(
                          tileFadeInStart: 0.1,
                          maxZoom: kDefaultMaxZoom,
                          keepBuffer: 100,
                          urlTemplate: osmMapTemplate,
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayerOptions(
                          markers: shopModel.marker.markers,
                        ),
                      ],
                    )
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                      color: AppServices.hexaCodeToColor(AppColors.secondary),
                    ),
                    padding: EdgeInsets.only(left: pd10+2),
                    height: 70,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(text: "Location:", color: AppColors.white, textAlign: TextAlign.left, fontWeight: FontWeight.bold, fontSize: 20, bottom: 5,),
                        MyText(text: "${shopModel.locationName}", fontSize: 16, color: AppColors.white, textAlign: TextAlign.left,),
                      ],
                    ),
                  )
                ]
              )
            )
          ),
        ),
      ),

      // Button
      SliverPersistentHeader(
        pinned: true,
        delegate: MySliverAppBarDelegate(
          minHeight: 90,
          maxHeight: 90,
          child: Container(
            color: AppServices.hexaCodeToColor(AppColors.bgColor),
            child: ShopTabbar(
              tabController: shopModel.tabController,

              // From Shop.dart
              onTapTabBar: onTapTabBar,
            )
          ),
        )
      ),
      
      // Button
      SliverPersistentHeader(
        pinned: true,
        delegate: MySliverAppBarDelegate(
          minHeight: MediaQuery.of(context).size.height,
          maxHeight: MediaQuery.of(context).size.height,
          child: Column(
            children: [

              Expanded(
                child: TabBarView(
                controller: shopModel.tabController,
                children: [

                  AllProductOwner(enableDelete: enableDelete, productProvider: productProvider, listProductOwner: shopProvider.allOwnerProduct, uploadRemainUrlImage: uploadRemainUrlImage, deleteProduct: deleteProduct, onChanged: onChanged,),

                  MyPadding(
                    pLeft: 12, pRight: 12,
                    child: Pending(
                      refresh: refreshSellerList,
                    ),
                  ),

                  MyPadding(
                    pLeft: 12, pRight: 12,
                    child: Sold(
                      refresh: refreshSellerList,
                    ),
                  )
                ]
              ),
              ),
              
              // For Empty Size From Bottom
              SizedBox(
                height: 185,
                child: Container(),
              )
            ]
          )
        )
      )
    ];
  }
}