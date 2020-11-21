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
  @override
  Widget build(BuildContext context) {
    return _buildTapBarView();
  }

  Widget _buildTapBarView() {
    var _lang = AppLocalizeService.of(context);
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    return Container(
      width: double.infinity,
      child: TabBarView(
        controller: widget._controller,
        children: <Widget>[
          Container(
            child: productsProvider.orItems.isNotEmpty
                ? ListView.builder(
                    itemCount: productsProvider.orItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(kDefaultRadius),
                        ),
                        child: ListTile(
                          title:
                              Text('${productsProvider.orItems[index].total}៛'),
                          subtitle: Text(
                            productsProvider.orItems[index].shippingAddress,
                            maxLines: 1,
                          ),
                          trailing: Text(
                              '${productsProvider.orItems[index].qauantity}'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                productsProvider.oItems[index].thumbnail),
                          ),
                          onTap: () {
                            // Navigator.of(context).pushNamed(DetailView,
                            //     arguments: productsProvider.orItems[index].id);
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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _lang.translate('complete'),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _lang.translate('pending'),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
