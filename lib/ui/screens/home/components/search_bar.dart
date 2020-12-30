import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
//import 'package:provider/provider.dart';

String _query;

class SearchBar extends StatelessWidget {
  final _searchKey = GlobalKey<FormFieldState<String>>();
  @override
  Widget build(BuildContext context) {
    //final productData = Provider.of<ProductsProvider>(context);
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: ReuseSearchField(
              fieldKey: _searchKey,
              labelText:
                  AppLocalizeService.of(context).translate('search_hint'),
              iconData: Icons.language,
              onFieldSubmitted: (value) {
                _query = value;
                //productData.searchProducts(_query);
              },
            ),
          ),
          Container(child: DropDownButtons()),
        ],
      ),
    );
  }
}
