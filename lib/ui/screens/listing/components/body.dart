import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';

class Body extends StatefulWidget {
  final TabController _controller;

  Body(this._controller);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //ProductsProvider productsProvider;
  //SellerProvider sellerProvider;

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
    return _buildTapBarView();
  }

  Widget _buildTapBarView() {
    var _lang = AppLocalizeService.of(context);

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
                return Responsive(
                  mobile: Container(
                    child: value.oItems.isNotEmpty
                        ? ListView.builder(
                            itemCount: value.oItems.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(kDefaultRadius)),
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
                                            child: Image.network(
                                              '${value.oItems[index].thumbnail}',
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
                                                  value.oItems[index].name,
                                                  style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)
                                                      .copyWith(
                                                    wordSpacing: 0,
                                                  ),
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
                                                      ': ${value.oItems[index].price}៛ ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kDefaultColor,
                                                  ).copyWith(wordSpacing: 0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ).showCursorOnHover.hoverAnimation;
                            },
                          )
                        : Center(
                            child: SvgPicture.asset(
                              'images/undraw_loving_it.svg',
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                          ),
                  ),
                  desktop: ReuseDesktop(
                    widget: Container(
                      child: value.oItems.isNotEmpty
                          ? ListView.builder(
                              itemCount: value.oItems.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(kDefaultRadius)),
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
                                      width: double.infinity,
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
                                                '${value.oItems[index].thumbnail}',
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
                                                width: 200,
                                                child: ListTile(
                                                  title: Text(
                                                    value.oItems[index].name,
                                                    style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold)
                                                        .copyWith(
                                                      wordSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 200,
                                                child: ListTile(
                                                  subtitle: Text(
                                                    _lang.translate('price') +
                                                        ': ${value.oItems[index].price}៛ ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kDefaultColor,
                                                    ).copyWith(wordSpacing: 0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ).showCursorOnHover.hoverAnimation;
                              },
                            )
                          : Center(
                              child: SvgPicture.asset(
                                'images/undraw_loving_it.svg',
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
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
                return Responsive(
                  mobile: Container(
                    child: value.buyerPendingList.isNotEmpty
                        ? ListView.builder(
                            itemCount: value.buyerPendingList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(kDefaultRadius)),
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
                                            child: Image.network(
                                              '${value.buyerPendingList[index].thumbnail}',
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
                                                  value.buyerPendingList[index]
                                                      .name,
                                                  style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)
                                                      .copyWith(wordSpacing: 0),
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
                                                  ).copyWith(wordSpacing: 0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ).showCursorOnHover.hoverAnimation,
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
                  ),
                  desktop: ReuseDesktop(
                    widget: Container(
                      child: value.buyerPendingList.isNotEmpty
                          ? ListView.builder(
                              itemCount: value.buyerPendingList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(kDefaultRadius)),
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
                                              child: Image.network(
                                                '${value.buyerPendingList[index].thumbnail}',
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
                                                width: 200,
                                                child: ListTile(
                                                  title: Text(
                                                    value
                                                        .buyerPendingList[index]
                                                        .name,
                                                    style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold)
                                                        .copyWith(
                                                            wordSpacing: 0),
                                                  ),
                                                  isThreeLine: true,
                                                  subtitle: Text(
                                                    _lang.translate(
                                                            'quantity') +
                                                        ': ${value.buyerPendingList[index].qauantity}',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 20,
                                                width: 200,
                                                child: ListTile(
                                                  subtitle: Text(
                                                    _lang.translate('price') +
                                                        ': ${value.buyerPendingList[index].price}៛ ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kDefaultColor,
                                                    ).copyWith(wordSpacing: 0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).showCursorOnHover.hoverAnimation,
                                );
                              },
                            )
                          : Center(
                              child: SvgPicture.asset(
                                'images/undraw_loving_it.svg',
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
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
                return Responsive(
                  mobile: Container(
                    child: value.buyerCompleteList.isNotEmpty
                        ? ListView.builder(
                            itemCount: value.buyerCompleteList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(kDefaultRadius)),
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
                                ).showCursorOnHover.hoverAnimation,
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
                  ),
                  desktop: ReuseDesktop(
                    widget: Container(
                      child: value.buyerCompleteList.isNotEmpty
                          ? ListView.builder(
                              itemCount: value.buyerCompleteList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(kDefaultRadius)),
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
                                                width: 200,
                                                child: ListTile(
                                                  title: Text(
                                                    value
                                                        .buyerCompleteList[
                                                            index]
                                                        .name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ).copyWith(
                                                      wordSpacing: 0,
                                                    ),
                                                  ),
                                                  isThreeLine: true,
                                                  subtitle: Text(
                                                    _lang.translate(
                                                            'quantity') +
                                                        ': ${value.buyerCompleteList[index].qauantity}',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 20,
                                                width: 200,
                                                child: ListTile(
                                                  subtitle: Text(
                                                    _lang.translate('price') +
                                                        ': ${value.buyerCompleteList[index].price}៛ ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kDefaultColor,
                                                    ).copyWith(wordSpacing: 0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).showCursorOnHover.hoverAnimation,
                                );
                              },
                            )
                          : Center(
                              child: SvgPicture.asset(
                                'images/undraw_loving_it.svg',
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
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
