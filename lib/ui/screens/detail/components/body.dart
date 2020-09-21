import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'sell_info.dart';
import 'related_product.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as int;
    final loadedData = Provider.of<ProductsProvider>(
      context,
    ).findById(productId);
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: kDefaultColor,
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            floating: true,
            pinned: true,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "${loadedData.id}",
                child: SizedBox(
                    child: CarouselSlider(
                  options: CarouselOptions(height: 400.0),
                  items: [1, 2, 3, 4].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(loadedData.image,
                              width: double.infinity, fit: BoxFit.cover),
                        );
                      },
                    );
                  }).toList(),
                ) /*Image.asset(
                    loadedData.image,
                    fit: BoxFit.fitHeight,
                  ),*/
                    ),
              ),
            ),
          ),
        ];
      },
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Colors.grey[100],
        ),
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
    );
  }
}
