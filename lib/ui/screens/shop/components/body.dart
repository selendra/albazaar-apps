import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/ui/screens/home/components/header.dart';
import 'package:albazaar_app/ui/screens/shop/components/all_product_owner.dart';
import 'package:albazaar_app/ui/screens/shop/components/shop_header.dart';
import 'package:albazaar_app/ui/screens/shop/components/shop_sliver_header.dart';
import 'package:albazaar_app/ui/screens/shop/components/shop_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/card_c.dart';
import 'package:albazaar_app/core/providers/seller_provider.dart';
import 'package:albazaar_app/ui/screens/shop/components/my_dropdown.dart';

class Body extends StatefulWidget {
  
  final ShopProvider shopProvider;

  final TabController _controller;

  final ProductsProvider productProvider;
  
  final Function uploadRemainUrlImage;

  final Function deleteProduct;

  Body(this._controller, {this.shopProvider, this.productProvider, this.uploadRemainUrlImage, this.deleteProduct});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin{
  //ProductsProvider productsProvider;
  //SellerProvider sellerProvider;
  bool enableDelete = false;

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct();
    });
  }

  Future<Null> _refreshSellerList() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
    });
  }

  void onChanged(String value, String currentProduct, Function mySetState){
    print("My current $currentProduct");
    print("Input $value");
    // validateProductDelete(value, currentProduct);
    mySetState((){
      // This Function From Shop.dart
      if (value == currentProduct){
        // setState((){
        // });
          enableDelete = true;
      } else {
        setState((){
          enableDelete = false;
        });
      }
      print(enableDelete);
    });
  }

  void validateProductDelete(String value, String currentProduct){
  }

  @override
  void initState() {
    _tabController =  TabController(length: 3, vsync: this);

    super.initState();
  }

  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, value){
            return ShopSliverHeader().sliverHeader(
              context: context,
              tabController: _tabController,
              onTapTab: (int index){

              },
            );
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: AllProductOwner(enableDelete: enableDelete, listProductOwner: widget.shopProvider.allOwnerProduct, uploadRemainUrlImage: widget.uploadRemainUrlImage, deleteProduct: widget.deleteProduct, onChanged: onChanged,))//Expanded(child: )
            ],
          )
        ),


        if (widget.shopProvider.allOwnerProduct == null || widget.shopProvider.allOwnerProduct.length == 0) 
        Container(
          color: Colors.black.withOpacity(0.3),
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
    );

  //   Column(
  //     children: [

  //       // Header
  //       ShopHeader(),

  //       // Location
  //       GestureDetector(
  //         onTap: () async{
  //           // await Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditProduct()));
  //         },
  //         child: MyPadding(
  //           pBottom: pd10, pRight: pd10+2, pLeft: pd10+2, pTop: pd10,
  //           child: Row(
  //             children: [
  //               SvgPicture.asset('assets/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.secondary)),
  //               MyText(left: pd10, text: "Set Address", fontWeight: FontWeight.w600, color: AppColors.secondary,),
  //             ],
  //           ),
  //         ),
  //       ),

  //       MyPadding(
  //         pLeft: pd10+2, pRight: pd10+2,
  //         pBottom: pd20,
  //         child: MyCard(
  //           boxShadow: [
  //             boxShadow()
  //           ],
  //           height: 136,
  //           width: MediaQuery.of(context).size.width,
  //           image: DecorationImage(
  //             fit: BoxFit.cover,
  //             image: AssetImage(
  //               'assets/map.png'
  //             )
  //           ),
  //         )
  //       ),

  //       // Button
  //       ShopTabbar(),

  //       widget.shopProvider.allOwnerProduct == null || widget.shopProvider.allOwnerProduct.length == 0 ? Center(
  //         child: CircularProgressIndicator(),
  //       ) 
  //       : AllProductOwner(enableDelete: enableDelete, listProductOwner: widget.shopProvider.allOwnerProduct, uploadRemainUrlImage: widget.uploadRemainUrlImage, deleteProduct: widget.deleteProduct, onChanged: onChanged,)//Expanded(child: )
  //     ],
  //   );
  //   //_buildTapBarView();
  // }

  // Widget _buildTapBarView() {
  //   var _lang = AppLocalizeService.of(context);

  //   // final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
  //   return Container(
  //     width: double.infinity,
  //     child: TabBarView(
  //       controller: widget._controller,
  //       children: <Widget>[

  //         // All
  //         RefreshIndicator(
  //           onRefresh: _refresh,
  //           child: Consumer<ProductsProvider>(
  //             builder: (context, value, child) {
  //               return Container(
  //                 child: value.oItems.isNotEmpty
  //                   ? ListView.builder(
  //                     itemCount: value.oItems.length,
  //                     itemBuilder: (context, index) {
  //                       return InkWell(
  //                         onTap: () {
  //                           Navigator.pushNamed(context, DetailView, arguments: value.oItems[index].id);
  //                           Provider.of<ProductsProvider>(context, listen: false).findImgById(value.oItems[index].id);
  //                         },
  //                         child: Card(
  //                           elevation: 0,
  //                           shape: kDefaultShape,
  //                           child: Container(
  //                             height: 100,
  //                             width: MediaQuery.of(context).size.width,
  //                             margin: const EdgeInsets.all(10.0),
  //                             child: Row(
  //                               children: [
  //                                 ClipRRect(
  //                                   borderRadius: BorderRadius.circular(
  //                                       kDefaultRadius),
  //                                   child: Container(
  //                                     width: 100,
  //                                     height: 100,
  //                                     decoration: BoxDecoration(
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                           color: Colors.grey[300],
  //                                           spreadRadius: 5.0,
  //                                           blurRadius: 5.0,
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     child: CachedNetworkImage(
  //                                       imageUrl: '${value.oItems[index].thumbnail}',
  //                                       fit: BoxFit.cover,
  //                                     ),
  //                                     // child: Image.network(
  //                                     //   ,
  //                                     //   fit: BoxFit.cover,
  //                                     // ),
  //                                   ),
  //                                 ),
  //                                 Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Container(
  //                                       height: 20,
  //                                       width: MediaQuery.of(context)
  //                                               .size
  //                                               .width /
  //                                           2,
  //                                       child: ListTile(
  //                                         title: Text(
  //                                           value.oItems[index].name,
  //                                           style: TextStyle(
  //                                               fontWeight:
  //                                                   FontWeight.bold),
  //                                         ),
  //                                         // isThreeLine: true,
  //                                         // subtitle: Text(
  //                                         //   _lang.translate('quantity') +
  //                                         //       ': ${value.oItems[index].qauantity}',
  //                                         // ),
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 10,
  //                                     ),
  //                                     Container(
  //                                       height: 20,
  //                                       width: MediaQuery.of(context)
  //                                               .size
  //                                               .width /
  //                                           2,
  //                                       child: ListTile(
  //                                         subtitle: Text(
  //                                           _lang.translate('price') +
  //                                               ': ${value.oItems[index].price}៛ ',
  //                                           style: TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                             color: kDefaultColor,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   )
  //                 : Center(
  //                     child: SvgPicture.asset(
  //                       'assets/undraw_loving_it.svg',
  //                       height: MediaQuery.of(context).size.height * 0.3,
  //                       width: MediaQuery.of(context).size.width * 0.3,
  //                     ),
  //                   ),
  //               );
  //             },
  //           ),
  //         ),

  //         // Pending
  //         RefreshIndicator(
  //           onRefresh: _refreshSellerList,
  //           child: Consumer<SellerProvider>(
  //             builder: (context, value, child) {
  //               return Container(
  //                 child: value.buyerPendingList.isNotEmpty
  //                     ? ListView.builder(
  //                         itemCount: value.buyerPendingList.length,
  //                         itemBuilder: (context, index) {
  //                           return InkWell(
  //                             onTap: () {
  //                               Navigator.pushNamed(context, SellerInfoView,
  //                                   arguments:
  //                                       value.buyerPendingList[index].id);
  //                             },
  //                             child: Card(
  //                               elevation: 0,
  //                               shape: kDefaultShape,
  //                               child: Container(
  //                                 height: 100,
  //                                 width: MediaQuery.of(context).size.width,
  //                                 margin: const EdgeInsets.all(10.0),
  //                                 child: Row(
  //                                   children: [
  //                                     ClipRRect(
  //                                       borderRadius: BorderRadius.circular(
  //                                           kDefaultRadius),
  //                                       child: Container(
  //                                         width: 100,
  //                                         height: 100,
  //                                         decoration: BoxDecoration(
  //                                           boxShadow: [
  //                                             BoxShadow(
  //                                               color: Colors.grey[300],
  //                                               spreadRadius: 5.0,
  //                                               blurRadius: 5.0,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         child: CachedNetworkImage(
  //                                           imageUrl: value
  //                                               .buyerPendingList[index]
  //                                               .thumbnail,
  //                                           fit: BoxFit.cover,
  //                                         ),
  //                                         // child: Image.network(
  //                                         //   '${value.buyerPendingList[index].thumbnail}',
  //                                         //   fit: BoxFit.cover,
  //                                         // ),
  //                                       ),
  //                                     ),
  //                                     Column(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       children: [
  //                                         Container(
  //                                           height: 20,
  //                                           width: MediaQuery.of(context)
  //                                                   .size
  //                                                   .width /
  //                                               2,
  //                                           child: ListTile(
  //                                             title: Text(
  //                                               value.buyerPendingList[index]
  //                                                   .name,
  //                                               style: TextStyle(
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             ),
  //                                             isThreeLine: true,
  //                                             subtitle: Text(
  //                                               _lang.translate('quantity') +
  //                                                   ': ${value.buyerPendingList[index].qauantity}',
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         SizedBox(
  //                                           height: 10,
  //                                         ),
  //                                         Container(
  //                                           height: 20,
  //                                           width: MediaQuery.of(context)
  //                                                   .size
  //                                                   .width /
  //                                               2,
  //                                           child: ListTile(
  //                                             subtitle: Text(
  //                                               _lang.translate('price') +
  //                                                   ': ${value.buyerPendingList[index].price}៛ ',
  //                                               style: TextStyle(
  //                                                 fontWeight: FontWeight.bold,
  //                                                 color: kDefaultColor,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       )
  //                     : Center(
  //                         child: SvgPicture.asset(
  //                           'assets/undraw_loving_it.svg',
  //                           height: MediaQuery.of(context).size.height * 0.3,
  //                           width: MediaQuery.of(context).size.width * 0.3,
  //                         ),
  //                       ),
  //               );
  //             },
  //           ),
  //         ),

  //         // Sold
  //         RefreshIndicator(
  //           onRefresh: _refresh,
  //           child: Consumer<SellerProvider>(
  //             builder: (context, value, child) {
  //               return Container(
  //                 child: value.buyerCompleteList.isNotEmpty
  //                     ? ListView.builder(
  //                         itemCount: value.buyerCompleteList.length,
  //                         itemBuilder: (context, index) {
  //                           return InkWell(
  //                             onTap: () {
  //                               Navigator.pushNamed(context, SellerInfoView,
  //                                   arguments:
  //                                       value.buyerCompleteList[index].id);
  //                             },
  //                             child: Card(
  //                               elevation: 0,
  //                               shape: kDefaultShape,
  //                               child: Container(
  //                                 height: 100,
  //                                 width: MediaQuery.of(context).size.width,
  //                                 margin: const EdgeInsets.all(10.0),
  //                                 child: Row(
  //                                   children: [
  //                                     ClipRRect(
  //                                       borderRadius: BorderRadius.circular(
  //                                           kDefaultRadius),
  //                                       child: Container(
  //                                         width: 100,
  //                                         height: 100,
  //                                         decoration: BoxDecoration(
  //                                           boxShadow: [
  //                                             BoxShadow(
  //                                               color: Colors.grey[300],
  //                                               spreadRadius: 5.0,
  //                                               blurRadius: 5.0,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         child: Image.network(
  //                                           '${value.buyerCompleteList[index].thumbnail}',
  //                                           fit: BoxFit.cover,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                     Column(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       children: [
  //                                         Container(
  //                                           height: 20,
  //                                           width: MediaQuery.of(context)
  //                                                   .size
  //                                                   .width /
  //                                               2,
  //                                           child: ListTile(
  //                                             title: Text(
  //                                               value.buyerCompleteList[index]
  //                                                   .name,
  //                                               style: TextStyle(
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             ),
  //                                             isThreeLine: true,
  //                                             subtitle: Text(
  //                                               _lang.translate('quantity') +
  //                                                   ': ${value.buyerCompleteList[index].qauantity}',
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         SizedBox(
  //                                           height: 10,
  //                                         ),
  //                                         Container(
  //                                           height: 20,
  //                                           width: MediaQuery.of(context)
  //                                                   .size
  //                                                   .width /
  //                                               2,
  //                                           child: ListTile(
  //                                             subtitle: Text(
  //                                               _lang.translate('price') +
  //                                                   ': ${value.buyerCompleteList[index].price}៛ ',
  //                                               style: TextStyle(
  //                                                 fontWeight: FontWeight.bold,
  //                                                 color: kDefaultColor,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       )
  //                     : Center(
  //                         child: SvgPicture.asset(
  //                           'assets/undraw_loving_it.svg',
  //                           height: MediaQuery.of(context).size.height * 0.3,
  //                           width: MediaQuery.of(context).size.width * 0.3,
  //                         ),
  //                       ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  }
}
