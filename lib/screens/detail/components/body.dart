import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'sell_info.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as int;
    final loadedData =
        Provider.of<ProductsProvider>(context).findById(productId);
    final productsData = Provider.of<ProductsProvider>(context);
    final _products = productsData.items;
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: kDefaultColor,
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            floating: true,
            pinned: true,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: "${loadedData.id}",
                child: Image.asset(
                  loadedData.image,
                  fit: BoxFit.fill,
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
                      builder: (context, value, child) =>
                          BtnQty('${loadedData.orderQty}', () {
                        value.addOrderQty(loadedData);
                      }, () {
                        value.minusOrderQty(loadedData);
                      }),
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
                Text(
                  'Related Product',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 140,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: _products[index],
                        child: ReuseItemCard(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
