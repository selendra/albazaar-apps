import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';
import 'package:webscrollbar/webscrollbar.dart';

class BodyDesktop extends StatefulWidget {
  @override
  _BodyDesktopState createState() => _BodyDesktopState();
}

class _BodyDesktopState extends State<BodyDesktop> {
  ScrollController _scrollController;
  ScrollController _webscroll;

  @override
  void initState() {
    _scrollController = ScrollController();
    _webscroll = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _webscroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsProvider>(context).items;
    var screenWidth = MediaQuery.of(context).size.width;
    return product.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Row(
            children: [
              Flexible(flex: 2, child: Container()),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: Responsive.isDesktop(context) && screenWidth <= 1000
                      ? 800
                      : 1000,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    child: Stack(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              CategoriesScreen(category),
                              ProductList(product),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(flex: 2, child: Container()),
            ],
          );
  }
}
