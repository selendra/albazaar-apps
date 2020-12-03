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
  Widget build(BuildContext context) {
    return _buildTapBarView();
  }

  Widget _buildTapBarView() {
    var _lang = AppLocalizeService.of(context);
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    final sellerProvider = Provider.of<SellerProvider>(context);
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
            child: Container(
              child: sellerProvider.allBuyerOrder.isNotEmpty
                  ? ListView.builder(
                      itemCount: sellerProvider.allBuyerOrder.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              RouteAnimation(
                                enterPage: SellerConfirm(
                                  productOrder:
                                      sellerProvider.allBuyerOrder[index],
                                ),
                              ),
                            );
                            print(sellerProvider
                                .allBuyerOrder[index].orderStatus);
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
                                        '${sellerProvider.allBuyerOrder[index].thumbnail}',
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
                                            sellerProvider
                                                .allBuyerOrder[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          isThreeLine: true,
                                          subtitle: Text(
                                            _lang.translate('quantity') +
                                                ': ${sellerProvider.allBuyerOrder[index].qauantity}',
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
                                            _lang.translate('price') +
                                                ': ${sellerProvider.allBuyerOrder[index].price}៛ ',
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

          // Sold
          RefreshIndicator(
            onRefresh: _refresh,
            child: Container(
              child: productsProvider.oItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: productsProvider.isSold.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(kDefaultRadius),
                          ),
                          child: ListTile(
                            title: Text(productsProvider.isSold[index].name),
                            subtitle: Text(
                              productsProvider.isSold[index].description,
                              maxLines: 1,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  productsProvider.isSold[index].thumbnail),
                            ),
                            onTap: () {
                              // Navigator.of(context).push(
                              //   RouteAnimation(
                              //     enterPage: SellerConfirm(
                              //       productOrder:
                              //           sellerProvider.allBuyerOrder[index],
                              //     ),
                              //   ),
                              // );
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
        ],
      ),
    );
  }
}
