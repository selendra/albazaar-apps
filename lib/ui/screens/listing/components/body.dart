import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
import 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_confrmation.dart';

class Body extends StatefulWidget {
  final TabController _controller;
  final SellerProvider sellerProvider;
  Body(this._controller, {this.sellerProvider});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // PostRequest _postRequest = PostRequest();

  //Backend _backend = Backend();

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
          Container(
            child: productsProvider.oItems.isNotEmpty
                ? ListView.builder(
                    itemCount: productsProvider.oItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(kDefaultRadius),
                        ),
                        child: ListTile(
                          title: Text(productsProvider.oItems[index].name),
                          subtitle: Text(
                            productsProvider.oItems[index].description,
                            maxLines: 1,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                productsProvider.oItems[index].thumbnail),
                          ),
                          onTap: () {},
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
          Container(
            child: widget.sellerProvider.allBuyerOrder.isNotEmpty
                ? ListView.builder(
                    itemCount: productsProvider.orItems.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            RouteAnimation(
                              enterPage: SellerConfirm(
                                productOrder:
                                    widget.sellerProvider.allBuyerOrder[index],
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
                                      '${widget.sellerProvider.allBuyerOrder[index].thumbnail}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: ListTile(
                                        title: Text(
                                          widget.sellerProvider
                                              .allBuyerOrder[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        isThreeLine: true,
                                        subtitle: Text(
                                          'Qty: ${widget.sellerProvider.allBuyerOrder[index].qauantity}',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 20,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: ListTile(
                                        subtitle: Text(
                                          'Price: ${widget.sellerProvider.allBuyerOrder[index].price}៛ ',
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
          Container(
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
                            Navigator.of(context).pushNamed(DetailView,
                                arguments: productsProvider.isSold[index].id);
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
                    // child: Image.network(
                    //   'https://i.pinimg.com/originals/81/c4/fc/81c4fc9a4c06cf57abf23606689f7426.jpg',
                    //   width: 300,
                    //   height: 300,
                    // ),
                  ),
          ),
        ],
      ),
    );
  }
}
