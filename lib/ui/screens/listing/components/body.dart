import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
import 'package:selendra_marketplace_app/ui/component.dart';
import 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_confrmation.dart';

class Body extends StatefulWidget {
  final TabController _controller;
  final SellerProvider sellerProvider;
  Body(this._controller, {this.sellerProvider});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  Widget build(BuildContext context) {
    return _buildTapBarView();
  }

  Widget _buildTapBarView() {
    // var _lang = AppLocalizeService.of(context);
    final ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    return Container(
      width: double.infinity,
      child: TabBarView(
        controller: widget._controller,
        children: <Widget>[
          Container(
            child: 
            // productsProvider.oItems.isNotEmpty
            // ? ListView.builder(
            //   itemCount: productsProvider.oItems.length,
            //   itemBuilder: (context, index) {
            //     return Container(
            //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(kDefaultRadius),
            //       ),
            //       child: ListTile(
            //         title: Text(productsProvider.oItems[index].name),
            //         subtitle: Text(
            //           productsProvider.oItems[index].description,
            //           maxLines: 1,
            //         ),
            //         leading: CircleAvatar(
            //           backgroundColor: Colors.white,
            //           backgroundImage: NetworkImage(
            //             productsProvider.oItems[index].thumbnail
            //           ),
            //         ),
            //         onTap: () {
            //           Navigator.of(context).pushNamed(DetailView, arguments: productsProvider.oItems[index].id);
            //         },
            //       ),
            //     );
            //   }
            // )
            // : 
            Center(
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
          Container(
            child: 
            widget.sellerProvider.allBuyerOrder.isNotEmpty
            ? ListView.builder(
              itemCount: widget.sellerProvider.allBuyerOrder.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                  child: ListTile(
                    title: Text(widget.sellerProvider.allBuyerOrder[index].name),
                    trailing: Text(
                      widget.sellerProvider.allBuyerOrder[index].total.toString(),
                      maxLines: 1,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          widget.sellerProvider.allBuyerOrder[index].thumbnail),
                    ),
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>  SellerConfirm(productOrder: widget.sellerProvider.allBuyerOrder[index])
                      ));
                      // Navigator.of(context).pushNamed(DetailView,
                      //     arguments:
                      //         widget.sellerProvider.allBuyerOrder[index].id);
                    },
                  ),
                );
              }
            )
            : 
            Center(
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
          Container(
            child: 
            // productsProvider.oItems.isNotEmpty
            // ? ListView.builder(
            //   itemCount: productsProvider.isSold.length,
            //   itemBuilder: (context, index) {
            //     return Container(
            //       margin:
            //           EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(kDefaultRadius),
            //       ),
            //       child: ListTile(
            //         title: Text(productsProvider.isSold[index].name),
            //         subtitle: Text(
            //           productsProvider.isSold[index].description,
            //           maxLines: 1,
            //         ),
            //         leading: CircleAvatar(
            //           backgroundColor: Colors.white,
            //           backgroundImage: NetworkImage(
            //               productsProvider.isSold[index].thumbnail),
            //         ),
            //         onTap: () {
            //           Navigator.of(context).pushNamed(DetailView,
            //               arguments: productsProvider.isSold[index].id);
            //         },
            //       ),
            //     );
            //   }
            // )
            // : 
            Center(
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
