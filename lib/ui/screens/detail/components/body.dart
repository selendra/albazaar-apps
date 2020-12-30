import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'interact_view.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedData = Provider.of<ProductsProvider>(
      context,
    ).findById(productId);

    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: kDefaultColor,
              ),
              leading: CircleShapeBtn(
                  () => Navigator.pop(context), Icons.arrow_back),
              actions: [
                Consumer<CartProvider>(
                  builder: (context, value, child) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: value.items.length == 0
                          ? IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: kDefaultColor,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, CartView);
                              })
                          : Badge(
                              position: BadgePosition.topEnd(top: 0, end: 3),
                              animationDuration: Duration(milliseconds: 300),
                              animationType: BadgeAnimationType.scale,
                              badgeContent: Text(
                                value.items.length.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: kDefaultColor,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, CartView);
                                  }),
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
                    child: Consumer<ProductsProvider>(
                      builder: (context, value, child) => Carousel(
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
                          value.url.isEmpty ? 1 : value.url.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        InteractView(value.url[index]),
                                  ),
                                );
                              },
                              child: FadeInImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    value.url.isNotEmpty
                                        ? value.url[index]
                                        : loadedData.thumbnail,
                                  ),
                                  placeholder:
                                      AssetImage('images/loading.gif')),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      loadedData.name,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
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
                        loadedData.price.toString() +
                            '៛ /' +
                            AppLocalizeService.of(context)
                                .translate('kilogram'),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                          //color: kDefaultColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    loadedData.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ChangeNotifierProvider.value(
                    value: loadedData,
                    child: SellerInfo(),
                  ),
                  SizedBox(
                    height: 30.0,
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
