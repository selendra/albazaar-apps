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
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchListingProduct();
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
    return Container(
      width: double.infinity,
      child: TabBarView(
        controller: widget._controller,
        children: <Widget>[
          //all
          RefreshIndicator(
            onRefresh: _refresh,
            child: Consumer<ProductsProvider>(
              builder: (context, value, child) {
                return Container(
                  child: value.allOrderItems.isNotEmpty
                  ? ListView.builder(
                    itemCount: value.allOrderItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            RouteAnimation(
                              enterPage: OrderDetail(
                                productOrder: value.allOrderItems[index],
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
                                      value
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
                                      width: MediaQuery.of(context)
                                              .size
                                              .width /
                                          2,
                                      child: ListTile(
                                        title: Text(
                                          value.allOrderItems[index].name,
                                          style: TextStyle(
                                              fontWeight:
                                                  FontWeight.bold),
                                        ),
                                        isThreeLine: true,
                                        subtitle: Text(
                                          'Qty: ${value.allOrderItems[index].qauantity}',
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
                                          'Price: ${value.allOrderItems[index].price}៛ ',
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
                );
              },
            ),
          ),

          //pending
          RefreshIndicator(
            onRefresh: _refresh,
            child: Consumer<ProductsProvider>(
              builder: (context, value, child) {
                return Container(
                  child: value.orItems.isNotEmpty
                      ? ListView.builder(
                          itemCount: value.orItems.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  RouteAnimation(
                                    enterPage: OrderDetail(
                                      productOrder: value.orItems[index],
                                    ),
                                  ),
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
                                            value.orItems[index].thumbnail,
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
                                                value.orItems[index].name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              isThreeLine: true,
                                              subtitle: Text(
                                                'Qty: ${value.orItems[index].qauantity}',
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
                                                'Price: ${value.orItems[index].price}៛ ',
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
                );
              },
            ),
          ),
          
          //complete
          RefreshIndicator(
            onRefresh: _refresh,
            child: Consumer<ProductsProvider>(
              builder: (context, value, child) {
                return Container(
                  child: value.completeProduct.isNotEmpty
                      ? ListView.builder(
                          itemCount: value.completeProduct.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  RouteAnimation(
                                    enterPage: OrderDetail(
                                      productOrder:
                                          value.completeProduct[index],
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
                                            value.completeProduct[index]
                                                .thumbnail,
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
                                                value.completeProduct[index]
                                                    .name,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              isThreeLine: true,
                                              subtitle: Text(
                                                'Qty: ${value.completeProduct[index].qauantity}',
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
                                                'Price: ${value.completeProduct[index].price}៛ ',
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
