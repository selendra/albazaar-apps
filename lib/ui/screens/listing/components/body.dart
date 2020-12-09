import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
import 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_confrmation.dart';

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

  Future<Null> _refreshSellerList() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      sellerProvider = Provider.of<SellerProvider>(context, listen: false);
      sellerProvider.fetchBuyerOrder();
    });
  }

  @override
  void initState() {
    Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct();
    Provider.of<SellerProvider>(context, listen: false).fetchBuyerOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTapBarView();
  }

  Widget _buildTapBarView() {
    var _lang = AppLocalizeService.of(context);
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    final sellerProvider = Provider.of<SellerProvider>(context, listen: false);
    return Container(
      width: double.infinity,
      child: TabBarView(
        controller: widget._controller,
        children: <Widget>[
          // All
          RefreshIndicator(
            onRefresh: _refresh,
            child: Container(
              child: productsProvider.oItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: productsProvider.oItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              kDefaultRadius,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              productsProvider.oItems[index].name,
                            ),
                            subtitle: Text(
                              productsProvider.oItems[index].description,
                              maxLines: 1,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                productsProvider.oItems[index].thumbnail,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, DetailView,
                                  arguments: productsProvider.oItems[index].id);
                              Provider.of<ProductsProvider>(context)
                                  .findImgById(
                                      productsProvider.oItems[index].id);
                            },
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

          // Pending
          RefreshIndicator(
            onRefresh: _refreshSellerList,
            child: FutureBuilder(
              initialData: sellerProvider.buyerPendingList,
              builder: (context, snapshot) => Container(
                child: sellerProvider.buyerPendingList.isNotEmpty
                    ? ListView.builder(
                        itemCount: sellerProvider.buyerPendingList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                RouteAnimation(
                                  enterPage: SellerConfirm(
                                    productOrder:
                                        sellerProvider.buyerPendingList[index],
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
                                          '${sellerProvider.buyerPendingList[index].thumbnail}',
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
                                              sellerProvider
                                                  .buyerPendingList[index].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            isThreeLine: true,
                                            subtitle: Text(
                                              _lang.translate('quantity') +
                                                  ': ${sellerProvider.buyerPendingList[index].qauantity}',
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
                                                  ': ${sellerProvider.buyerPendingList[index].price}៛ ',
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
          ),

          // Sold
          RefreshIndicator(
              onRefresh: _refresh,
              child: Container(
                child: sellerProvider.buyerCompleteList.isNotEmpty
                    ? ListView.builder(
                        itemCount: sellerProvider.buyerPendingList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                RouteAnimation(
                                  enterPage: SellerConfirm(
                                    productOrder:
                                        sellerProvider.buyerCompleteList[index],
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
                                          '${sellerProvider.buyerCompleteList[index].thumbnail}',
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
                                              sellerProvider
                                                  .buyerPendingList[index].name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            isThreeLine: true,
                                            subtitle: Text(
                                              _lang.translate('quantity') +
                                                  ': ${sellerProvider.buyerCompleteList[index].qauantity}',
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
                                                  ': ${sellerProvider.buyerCompleteList[index].price}៛ ',
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
              )),
        ],
      ),
    );
  }
}
