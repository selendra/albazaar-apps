import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/components/card_c.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
import 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_confrmation.dart';

class Body extends StatefulWidget {
  final TabController _controller;

  Body(this._controller);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //ProductsProvider productsProvider;
  //SellerProvider sellerProvider;

  Product product = Product(
    description: 'នេះគឺជាដំណើរជីវិតរបស់ក្មេងស្រីម្នាក់ក្នុងចំណោមក្មេងស្រីជាច្រើនផ្សេងទៀតដែលចាប់កំណើតឡើងនៅទីជនបទ។ នាងចេះមានក្តីស្រមៃតាំងពីតូច ហើយក្ដីស្រមៃនោះបានជំរុញឱ្យនាងខិតខំតតាំងនឹងភាពលំបាកក្នុងជីវិត។ ពេលវេលានៃកុមារភាពរបស់នាងក្លាយជាពេលវេលាដែលត្រូវតតាំងប្រឹងរស់ដូចមនុស្សធំពេញវ័យ វាខុសពីក្មេងដទៃផ្សេងទៀតជាច្រើនដែលអាចស្គាល់ពីរសជាតិជីវិតដ៏កក់ក្ដៅក្នុងរង្វង់ដ',
    shippingService: "SW Logistic",
    address: null,
    name: "កាពីទែនជីវិត ភាគ1",
    categoryName: "Others",
    thumbnail: "https://selendra.s3-ap-southeast-1.amazonaws.com/1bf46702-f69e-4fad-840b-89e0ae9a8edc",
    phonenumber: null,
    weight: "b8fd8a60-242c-405d-8a62-1ae2880094a7",
    id: "be630b54-f67b-4b89-aed2-c3a997a9a105",
    paymentId: "3802b352-4b1e-4ec3-a24c-c1e042d3fadd",
    price: 7,
    shippingFee: 1.99,
    createdAt: "2021-02-18T02:31:54Z",
    seller: Seller.fromJson({
      "type": "record",
      "value": "(,)"
    }),
    isSold: false
  );

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // Header
        PaddingScaffold(
          pTop: pd10+2,
          pLeft: pd10+2, pRight: pd10+2,
          pBottom: pd10+pd10,
          child: MyCard(
            // height: 382.0,
            child: Stack(
              children: [
                Column(
                  children: [

                    Container(
                      padding: EdgeInsets.only(top: 20),
                      height: 228,
                      child: Image.asset('images/shop_cover_image.jpg',fit: BoxFit.contain)
                    ),

                    MyCard(
                      bTopLeft: 0, bTopRight: 0,
                      hexaColor: AppColors.secondary,
                      child: Container(
                        padding: EdgeInsets.only(left: pd20, right: pd20, top: pd20+15, bottom: pd20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  MyText(
                                    text: "About",
                                    color: AppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),

                                  Expanded(child: Container(),),
                                  
                                  SvgPicture.asset('images/icons/edit.svg', width: 20, height: 20, color: Colors.white),
                                ],
                              )
                            ),

                            MyText(
                              top: pd10,
                              textAlign: TextAlign.left,
                              color: AppColors.white,
                              text: "Hello ! My name’s Daveat. I’m come from phnom penh and sell crops like broccoli, etc.",
                              fontSize: 16,
                            )
                          ],
                        )
                      ),
                    )    
                  ]   
                ),

                // Profile Logo
                Positioned(
                  top: (382/2.3),
                  left: 20,
                  child: MyCard(
                    height: 80, width: 80,
                    hexaColor: AppColors.black,
                    child: PaddingScaffold(
                      pBottom: pd10, pLeft: pd10, pRight: pd10, pTop: pd10,
                      child: Image.asset('images/koompi_logo.png'),
                    )
                  ),
                ),   

                // Edit Logo
                Positioned(
                  top: 8,
                  right: 8,
                  child: SvgPicture.asset('images/icons/edit.svg', width: 20, height: 20),
                )    
              ],
            )
          ),
        ),

        // Location
        GestureDetector(
          child: PaddingScaffold(
            pBottom: pd10, pRight: pd10+2, pLeft: pd10+2, pTop: pd10,
            child: Row(
              children: [
                SvgPicture.asset('images/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.secondary)),
                MyText(left: pd10, text: "Set Address", fontWeight: FontWeight.w600, color: AppColors.secondary,),
              ],
            ),
          ),
        ),

        PaddingScaffold(
          pLeft: pd10+2, pRight: pd10+2,
          pBottom: pd20,
          child: MyCard(
            height: 136,
            width: MediaQuery.of(context).size.width,
            // child: ,
          )
        ),

        // Button
        PaddingScaffold(
          pLeft: pd10+2, pRight: pd10+2,
          pBottom: pd20,
          child: Row(
            children: [

              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppServices.hexaCodeToColor(AppColors.secondary),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: FlatButton(
                  color: Colors.transparent,
                  onPressed: (){},
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      MyText(
                        pLeft: 10,
                        fontSize: 16.0,
                        text: "Search",
                        color: AppColors.white,
                      )
                    ],
                  ),
                )
              ),

              Expanded(
                child: MyText(
                  text: "All",
                  color: AppColors.secondary,
                )
              ),
              
              Expanded(
                child: MyText(
                  text: "Pending"
                )
              ),
              
              Flexible(
                child: MyText(
                  left: 10,
                  text: "Sold"
                )
              ),
            ],
          ),
        ),

        // Products Listing
        PaddingScaffold(
          pLeft: pd10+2, pRight: pd10+12,
          child: MyCard(
            child: Row(
              children: [
                // MyCard(
                //   height: 122,
                //   child: PaddingScaffold(
                //     pLeft: 16, pRight: 16, pTop: 16, pBottom: 16,
                //     // child: ,
                //   )
                // ),
                Flexible(
                  child: MyCard(
                  bBottomLeft: 0, bBottomRight: 0,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(product.thumbnail) //CachedNetworkImageProvider(listProduct[index].thumbnail)
                    )
                  // Hero(
                  //   // tag: "${listProduct[index].id}",
                  //   child: ,
                  //   )
                  )
                ),

                // MyCard(
                //   align: Alignment.centerLeft,
                //   bTopLeft: 0, bTopRight: 0,
                //   // mBottom: cPadding, mTop: cPadding, mLeft: cPadding, mRight: cPadding,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [

                //       Padding(
                //         padding: EdgeInsets.only(bottom: 5),
                //         child: Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Expanded(
                //               child: MyText(
                //                 textAlign: TextAlign.left,
                //                 text: "${product.name}",
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.bold,
                //                 color: "#000000",
                //               )
                //             ),
                            
                //             MyText(
                //               text: "(0 sold)",
                //               fontSize: 12,
                //               color: "#000000",
                //             )
                //           ],
                //         )
                //       ),

                //       Padding(
                //         padding: EdgeInsets.only(bottom: 5),
                //         child: MyText(
                //           textAlign: TextAlign.left,
                //           text: "${product.description}",
                //           fontSize: 16,
                //           color: "#000000",
                //           overflow: TextOverflow.ellipsis,
                //           maxLine: 1,
                //         )
                //       ),

                //       Padding(
                //         padding: EdgeInsets.only(bottom: 5),
                //         child: Row(
                //           children: [
                //             Image.asset('images/symbols/riel_symbol.png', width: 9, height: 15),
                //             MyText(
                //               textAlign: TextAlign.left,
                //               text: "${product.price} /Kg",
                //               fontSize: 16,
                //               fontWeight: FontWeight.bold,
                //               color: AppColors.primary,
                //             )
                //           ],
                //         )
                //       ),

                //       Row(
                //         children: [
                //           Padding(
                //             padding: EdgeInsets.only(right: 7),
                //             child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(right: 7),
                //             child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(right: 7),
                //             child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(right: 7),
                //             child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                //           ),
                //           Padding(
                //             padding: EdgeInsets.only(right: 7),
                //             child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                //           ),
                //           MyText(
                //             textAlign: TextAlign.left,
                //             text: "(15)",
                //             fontSize: 10,
                //             color: "#000000",
                //           )
                //         ],
                //       )
                      
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ],
    );
    //_buildTapBarView();
  }

  Widget _buildTapBarView() {
    var _lang = AppLocalizeService.of(context);

    // final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      child: TabBarView(
        controller: widget._controller,
        children: <Widget>[
          // All
          RefreshIndicator(
            onRefresh: _refresh,
            child: Consumer<ProductsProvider>(
              builder: (context, value, child) {
                return Container(
                  child: value.oItems.isNotEmpty
                      ? ListView.builder(
                          itemCount: value.oItems.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, DetailView,
                                    arguments: value.oItems[index].id);
                                Provider.of<ProductsProvider>(context,
                                        listen: false)
                                    .findImgById(value.oItems[index].id);
                              },
                              child: Card(
                                elevation: 0,
                                shape: kDefaultShape,
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            kDefaultRadius),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[300],
                                                spreadRadius: 5.0,
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${value.oItems[index].thumbnail}',
                                            fit: BoxFit.cover,
                                          ),
                                          // child: Image.network(
                                          //   ,
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: ListTile(
                                              title: Text(
                                                value.oItems[index].name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // isThreeLine: true,
                                              // subtitle: Text(
                                              //   _lang.translate('quantity') +
                                              //       ': ${value.oItems[index].qauantity}',
                                              // ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: ListTile(
                                              subtitle: Text(
                                                _lang.translate('price') +
                                                    ': ${value.oItems[index].price}៛ ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kDefaultColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: SvgPicture.asset(
                            'images/undraw_loving_it.svg',
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                        ),
                );
              },
            ),
          ),

          // Pending
          RefreshIndicator(
            onRefresh: _refreshSellerList,
            child: Consumer<SellerProvider>(
              builder: (context, value, child) {
                return Container(
                  child: value.buyerPendingList.isNotEmpty
                      ? ListView.builder(
                          itemCount: value.buyerPendingList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, SellerInfoView,
                                    arguments:
                                        value.buyerPendingList[index].id);
                              },
                              child: Card(
                                elevation: 0,
                                shape: kDefaultShape,
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            kDefaultRadius),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[300],
                                                spreadRadius: 5.0,
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: value
                                                .buyerPendingList[index]
                                                .thumbnail,
                                            fit: BoxFit.cover,
                                          ),
                                          // child: Image.network(
                                          //   '${value.buyerPendingList[index].thumbnail}',
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: ListTile(
                                              title: Text(
                                                value.buyerPendingList[index]
                                                    .name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              isThreeLine: true,
                                              subtitle: Text(
                                                _lang.translate('quantity') +
                                                    ': ${value.buyerPendingList[index].qauantity}',
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: ListTile(
                                              subtitle: Text(
                                                _lang.translate('price') +
                                                    ': ${value.buyerPendingList[index].price}៛ ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kDefaultColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: SvgPicture.asset(
                            'images/undraw_loving_it.svg',
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                        ),
                );
              },
            ),
          ),

          // Sold
          RefreshIndicator(
            onRefresh: _refresh,
            child: Consumer<SellerProvider>(
              builder: (context, value, child) {
                return Container(
                  child: value.buyerCompleteList.isNotEmpty
                      ? ListView.builder(
                          itemCount: value.buyerCompleteList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, SellerInfoView,
                                    arguments:
                                        value.buyerCompleteList[index].id);
                              },
                              child: Card(
                                elevation: 0,
                                shape: kDefaultShape,
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            kDefaultRadius),
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[300],
                                                spreadRadius: 5.0,
                                                blurRadius: 5.0,
                                              ),
                                            ],
                                          ),
                                          child: Image.network(
                                            '${value.buyerCompleteList[index].thumbnail}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: ListTile(
                                              title: Text(
                                                value.buyerCompleteList[index]
                                                    .name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              isThreeLine: true,
                                              subtitle: Text(
                                                _lang.translate('quantity') +
                                                    ': ${value.buyerCompleteList[index].qauantity}',
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: ListTile(
                                              subtitle: Text(
                                                _lang.translate('price') +
                                                    ': ${value.buyerCompleteList[index].price}៛ ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kDefaultColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: SvgPicture.asset(
                            'images/undraw_loving_it.svg',
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
