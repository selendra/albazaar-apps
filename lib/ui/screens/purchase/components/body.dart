import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  final TabController _controller;
  Body(this._controller);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ProductsProvider productsProvider;
  SellerProvider sellerProvider;

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      productsProvider = Provider.of<ProductsProvider>(context, listen: false);
      productsProvider.fetchListingProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildTapBarView();
  }

  Widget _buildTapBarView() {
    // var _lang = AppLocalizeService.of(context);
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    return Container(
      width: double.infinity,
      child: TabBarView(
        controller: widget._controller,
        children: <Widget>[
          //all
          RefreshIndicator(
            onRefresh: _refresh,
            child: Container(
              child: productsProvider.allOrderItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: productsProvider.allOrderItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              RouteAnimation(
                                enterPage: OrderDetail(
                                  productOrder:
                                      productsProvider.allOrderItems[index],
                                ),
                              ), //productsProvider.orItems[index]))
                            );
                          },
                          child: Card(
                            elevation: 0,
                            shape: kDefaultShape,
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(kDefaultRadius),
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
                                        productsProvider
                                            .allOrderItems[index].thumbnail,
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListTile(
                                          title: Text(
                                            productsProvider
                                                .allOrderItems[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          isThreeLine: true,
                                          subtitle: Text(
                                            'Qty: ${productsProvider.allOrderItems[index].qauantity}',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListTile(
                                          subtitle: Text(
                                            'Price: ${productsProvider.allOrderItems[index].price}៛ ',
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
                      })
                  : Center(
                      child: SvgPicture.asset(
                        'images/undraw_loving_it.svg',
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
            ),
          ),

          //pending
          RefreshIndicator(
            onRefresh: _refresh,
            child: Container(
              child: productsProvider.orItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: productsProvider.orItems.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              RouteAnimation(
                                enterPage: OrderDetail(
                                  productOrder: productsProvider.orItems[index],
                                ),
                              ), //productsProvider.orItems[index]))
                            );
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
                                    borderRadius:
                                        BorderRadius.circular(kDefaultRadius),
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
                                        productsProvider
                                            .orItems[index].thumbnail,
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListTile(
                                          title: Text(
                                            productsProvider
                                                .orItems[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          isThreeLine: true,
                                          subtitle: Text(
                                            'Qty: ${productsProvider.orItems[index].qauantity}',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListTile(
                                          subtitle: Text(
                                            'Price: ${productsProvider.orItems[index].price}៛ ',
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
                      })
                  : Center(
                      child: SvgPicture.asset(
                        'images/undraw_loving_it.svg',
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
            ),
          ),
          //complete
          RefreshIndicator(
            onRefresh: _refresh,
            child: Container(
              child: productsProvider.completeProduct.isNotEmpty
                  ? ListView.builder(
                      itemCount: productsProvider.completeProduct.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              RouteAnimation(
                                enterPage: OrderDetail(
                                  productOrder:
                                      productsProvider.completeProduct[index],
                                ),
                              ), //productsProvider.orItems[index]))
                            );
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
                                    borderRadius:
                                        BorderRadius.circular(kDefaultRadius),
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
                                        productsProvider
                                            .completeProduct[index].thumbnail,
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListTile(
                                          title: Text(
                                            productsProvider
                                                .completeProduct[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          isThreeLine: true,
                                          subtitle: Text(
                                            'Qty: ${productsProvider.completeProduct[index].qauantity}',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListTile(
                                          subtitle: Text(
                                            'Price: ${productsProvider.completeProduct[index].price}៛ ',
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
            ),
          ),
        ],
      ),
    );
  }
}
