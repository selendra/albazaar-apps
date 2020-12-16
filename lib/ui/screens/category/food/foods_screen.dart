import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'search_by_categories.dart';

class FoodsScreen extends StatefulWidget {
  final String _image;
  final String _categoryName;
  FoodsScreen(this._image, this._categoryName);
  @override
  _FoodsScreenState createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen>
    with SingleTickerProviderStateMixin {
  List<Product> productsData;

  @override
  void initState() {
    productsData = Provider.of<ProductsProvider>(context, listen: false)
        .filterProductByCategories(widget._categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          widget._image,
          height: 30,
          width: 30,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kDefaultColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: kDefaultColor,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchByCategories(
                  searchProduct: productsData,
                ),
              );
            },
          )
        ],
      ),
      body: productsData.isEmpty
          ? Center(
              child: SvgPicture.asset(
                'images/undraw_loving_it.svg',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            )
          : Container(
              child: ProductList(productsData),
              // child: Container(),
            ), //_buildTapBarView(),
    );
  }
}
