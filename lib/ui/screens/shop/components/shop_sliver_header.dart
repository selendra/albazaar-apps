import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/ui/screens/shop/components/all_product_owner.dart';
import 'package:albazaar_app/ui/screens/shop/components/shop_header.dart';
import 'package:albazaar_app/ui/screens/shop/components/shop_tabbar.dart';
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
    Function onTapTab,
    Function refresh,
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
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image: AssetImage(
              //     'assets/map.png'
              //   )
              // ),
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
                    // bTopLeft: 0, bTopRight: 0,
                    // hexaColor: AppColors.secondary,
                    height: 70,
                    color: AppServices.hexaCodeToColor(AppColors.secondary),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        MyText(text: "Location:", color: AppColors.white, textAlign: TextAlign.left, fontWeight: FontWeight.bold, fontSize: 20,),
                        MyText(text: "${shopModel.locationName}", fontSize: 16, color: AppColors.white, textAlign: TextAlign.left,),
                      ],
                    ),
                  )
                ]
              )
              // Column(
              //   children: [
              //     FlutterMap(
              //       mapController: MapController(), //shopModel.mapController,
              //       options: MapOptions(
              //         center: LatLng(12.509, 105.634),
              //         // shopModel.lat != null && shopModel.long != null
              //         // ? LatLng(shopModel.lat, shopModel.long)
              //         // : LatLng(12.509, 105.634),
              //         zoom: 13.0,
              //         screenSize: MediaQuery.of(context).size,
              //         slideOnBoundaries: true,
              //         maxZoom: kDefaultMaxZoom,
              //         minZoom: kDefaultMinZoom,
              //       ),
              //       layers: [
              //         TileLayerOptions(
              //           tileFadeInStart: 0.1,
              //           maxZoom: kDefaultMaxZoom,
              //           keepBuffer: 100,
              //           urlTemplate: osmMapTemplate,
              //           subdomains: ['a', 'b', 'c'],
              //         ),
              //         MarkerLayerOptions(
              //           markers: shopModel.marker.markers,
              //         ),
              //       ],
              //     ),

              //     // MyCard(
              //     //   bTopLeft: 0, bTopRight: 0,
              //     //   hexaColor: AppColors.secondary,
              //     //   child: Column(
              //     //     children: [
              //     //       Text("Location: Steng Mean Chey, Phnom Penh"),
              //     //     ],
              //     //   ),
              //     // )
              //   ],
              // ),
            )
          ),
      //     minHeight: 50,
      //     maxHeight: 50,
      //     child: Container(
      //       color: AppServices.hexaCodeToColor(AppColors.bgColor),
      //       child: MyPadding(
      //         pLeft: padding, pRight: padding,
      //         child: Align(
      //           alignment: Alignment.topLeft,
      //           child: MyText(
      //             text: "All Products",
      //             fontWeight: FontWeight.w600,
      //             fontSize: 20.0,
      //           )
      //         )
      //       )
      //     )
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
            child: ShopTabbar()
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
              Expanded(child: AllProductOwner(enableDelete: enableDelete, productProvider: productProvider, listProductOwner: shopProvider.allOwnerProduct, uploadRemainUrlImage: uploadRemainUrlImage, deleteProduct: deleteProduct, onChanged: onChanged,)),
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