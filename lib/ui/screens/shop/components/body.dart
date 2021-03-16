import 'package:albazaar_app/core/components/text_btn.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/card_c.dart';
import 'package:albazaar_app/core/providers/seller_provider.dart';
import 'package:albazaar_app/ui/screens/shop/components/my_dropdown.dart';
import 'package:albazaar_app/ui/screens/seller_confirmation/seller_confrmation.dart';

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
        MyPadding(
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
                      child: Image.asset('assets/shop_cover_image.jpg',fit: BoxFit.contain)
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
                    child: MyPadding(
                      pBottom: pd10, pLeft: pd10, pRight: pd10, pTop: pd10,
                      child: Image.asset('assets/koompi_logo.png'),
                    )
                  ),
                ),   

                // Edit Logo
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails detail) async {
                      await Navigator.push(
                        context, 
                        popUpRoute(
                          MyDropDownCustom.profileDropDownBtn(context: context, x: detail.globalPosition.dx, y: detail.globalPosition.dy,), sigmaX: 0.0, sigmaY: 0.0
                        )
                      );
                    },
                    child: MyPadding(
                      pRight: 8,
                      pTop: 8,
                      pBottom: 8,
                      pLeft: 8,
                      child: SvgPicture.asset('assets/icons/edit.svg', width: 20, height: 20)
                    ),
                  ),
                )    
              ],
            )
          ),
        ),

        // Location
        GestureDetector(
          child: MyPadding(
            pBottom: pd10, pRight: pd10+2, pLeft: pd10+2, pTop: pd10,
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.secondary)),
                MyText(left: pd10, text: "Set Address", fontWeight: FontWeight.w600, color: AppColors.secondary,),
              ],
            ),
          ),
        ),

        MyPadding(
          pLeft: pd10+2, pRight: pd10+2,
          pBottom: pd20,
          child: MyCard(
            height: 136,
            width: MediaQuery.of(context).size.width,
            // child: ,
          )
        ),

        // Button
        MyPadding(
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
              
              Expanded(
                child: MyText(
                  left: 10,
                  text: "Sold"
                )
              ),

              // SvgPicture.asset('assets/icons/plus.svg', height: 18, width: 18, color: AppServices.hexaCodeToColor(AppColors.secondary)),
              
            ],
          ),
        ),

        Container(
          height: 200,
          constraints: BoxConstraints(
            minHeight: 230,
            maxHeight: 300
          ),
          child:  ListView.builder(
          itemCount: 10,
          itemBuilder: (context, int index){
            return Container(
              height: 150,
              padding: EdgeInsets.only(left: pd10+2, right: pd10+2, bottom: pd10+2),
              child: MyCard(
                child: Row(
                  children: [

                    MyCard(
                      hexaColor: AppColors.secondary,
                      height: double.infinity,
                      width: 146,
                      bTopRight: 0, bBottomRight: 0,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(product.thumbnail)
                      ),
                    ),

                    Flexible(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          MyPadding(
                            pLeft: pd10+5, pRight: pd10,
                            pBottom: pd10,
                            pTop: pd10,
                            child: Row(                    
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  textAlign: TextAlign.left,
                                  text: "${product.name}",
                                  fontSize:20,
                                  fontWeight: FontWeight.bold,
                                  color: "#000000",
                                ),
                                Expanded(child: Container()),
                                GestureDetector(
                                  onTapDown: (TapDownDetails detail) async {
                                    // var x = getBox.localToGlobal(detail.globalPosition.dx);
                                    print(detail.globalPosition);
                                    // print("Box ${getBox.size}");
                                    final result = await Navigator.push(
                                      context, 
                                      popUpRoute(
                                        MyDropDownCustom.productEdit(context: context,x: detail.globalPosition.dx, y: detail.globalPosition.dy,), sigmaX: 0.0, sigmaY: 0.0
                                      )
                                    );
                                    print(result);
                                    if (result == 'edit'){
                                      await Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditProduct()));
                                    }
                                    else  if (result == "delete"){
                                      await Components.dialog(
                                        context, 
                                        MyText(text: "Are you sure to delete item?", pLeft: pd10, pRight: pd10,), 
                                        null, action: 
                                        FlatButton(
                                          onPressed: (){}, 
                                          child: Text("Yes")
                                        )
                                      );
                                    }

                                  },
                                  onTap: () async {
                                  },
                                  child: SvgPicture.asset('assets/icons/edit.svg', width: 23, height: 23),
                                )
                              ],
                            )
                          ),

                          MyPadding(
                            pLeft: pd10+5, pRight: pd10+5,
                            pBottom: pd10,
                            child: MyText(
                              width: MediaQuery.of(context).size.width,
                              textAlign: TextAlign.left,
                              text: "${product.description}",
                              fontSize: 12,
                              color: "#000000",
                              overflow: TextOverflow.ellipsis,
                              maxLine: 1,
                            )
                          ),

                          MyPadding(
                            pLeft: pd10+5, pRight: pd10+5,
                            pBottom: pd10,
                            child: Row(
                              children: [
                                Image.asset('assets/symbols/riel_symbol.png', width: 9, height: 15),
                                MyText(
                                  left: 6,
                                  textAlign: TextAlign.left,
                                  text: "${product.price} /Kg",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                )
                              ],
                            )
                          ),

                          MyPadding(
                            pLeft: pd10+5, pRight: pd10+5,
                            pBottom: pd10,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 7),
                                  child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 7),
                                  child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 7),
                                  child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 7),
                                  child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 7),
                                  child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                                ),
                                Expanded(
                                  child: Container(),
                                ),

                                MyText(
                                  textAlign: TextAlign.left,
                                  text: "(15 sold)",
                                  fontSize: 12,
                                  color: "#000000",
                                )
                              ],
                            ),
                          )
                          
                        ],
                      ),
                    )
                  ],
                )
              )
            );
          }
        )
        )
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
                                            imageUrl: '${value.oItems[index].thumbnail}',
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
                            'assets/undraw_loving_it.svg',
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
                            'assets/undraw_loving_it.svg',
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
                            'assets/undraw_loving_it.svg',
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
