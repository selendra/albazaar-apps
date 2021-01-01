import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/item_card_desktop.dart';

class RelatedProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final _products = productsData.items;
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizeService.of(context).translate('related_product'),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: GridView.builder(
              physics: ScrollPhysics(),
              itemCount: _products.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: _products[index],
                child: Card(
                  shape: kDefaultShape,
                  child: Responsive.isDesktop(context)
                      ? ItemCardDesktop()
                      : ItemCard(),
                ),
              ),
            ),
          ),
          // Container(
          //   height: 140,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     physics: ClampingScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: _products.length,
          //     itemBuilder: (context, index) {
          //       return ChangeNotifierProvider.value(
          //         value: _products[index],
          //         child: ReuseItemCard(),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
