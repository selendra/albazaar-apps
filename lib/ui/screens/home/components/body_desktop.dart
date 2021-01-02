import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class BodyDesktop extends StatefulWidget {
  @override
  _BodyDesktopState createState() => _BodyDesktopState();
}

class _BodyDesktopState extends State<BodyDesktop> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   if (_scrollController.hasClients) {
    //     _scrollController.animateTo(
    //       _scrollController.position.maxScrollExtent,
    //       curve: Curves.easeOut,
    //       duration: const Duration(milliseconds: 200),
    //     );
    //   }
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsProvider>(context).items;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return product.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: Row(
              children: [
                Flexible(flex: 2, child: Container()),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: Responsive.isDesktop(context) && screenWidth <= 1000
                        ? 800
                        : 1000,
                    child: Container(
                      child: Column(
                        children: [
                          CategoriesScreen(category),
                          ProductList(product),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(flex: 2, child: Container()),
              ],
            ),
          );
  }
}
