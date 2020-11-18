import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class RelatedProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final _products = productsData.items;
    return Column(
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
    );
  }
}
