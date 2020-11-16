import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'sell_info.dart';
import 'related_product.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as int;
    final loadedData = Provider.of<ProductsProvider>(
      context,
    ).findById(productId);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              // backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: kDefaultColor,
              ),
              leading: CircleShapeBtn(
                  () => Navigator.pop(context), Icons.arrow_back),
              actions: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, CartView);
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        color: kDefaultColor,
                      ),
                    ),
                  ),
                ),
              ],
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              floating: true,
              pinned: true,
              primary: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: "$productId",
                  child: SizedBox(
                    child: Carousel(
                      autoplay: false,
                      dotSpacing: 15.0,
                      dotColor: Colors.grey,
                      dotBgColor: Colors.transparent,
                      dotIncreasedColor: kDefaultColor,
                      indicatorBgPadding: 10.0,
                      borderRadius: true,
                      animationCurve: Curves.decelerate,
                      moveIndicatorFromBottom: 180.0,
                      noRadiusForIndicator: true,
                      boxFit: BoxFit.cover,
                      images: List.generate(
                        8,
                        (index) {
                          return Image.network(
                            loadedData.image,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    loadedData.title,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //_btnQtyRow(),
                      Consumer<ProductsProvider>(
                        builder: (context, value, child) => BtnQty(
                          '${loadedData.orderQty}',
                          () {
                            value.addOrderQty(loadedData);
                          },
                          () {
                            value.minusOrderQty(loadedData);
                          },
                        ),
                      ),
                      Text(
                        '\$' + loadedData.price.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 23,
                          color: kDefaultColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                      elevation: 0,
                      child: Container(
                          height: 200,
                          width: double.infinity,
                          margin: EdgeInsets.all(10.0),
                          child: Text(loadedData.description))),
                  SizedBox(
                    height: 10.0,
                  ),
                  ChangeNotifierProvider.value(
                    value: loadedData,
                    child: SellerInfo(),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RelatedProduct(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
