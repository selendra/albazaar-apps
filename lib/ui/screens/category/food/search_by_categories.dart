import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class SearchByCategories extends SearchDelegate {
  final List<Product> searchProduct;
  SearchByCategories({@required this.searchProduct});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> searchProducts = query.isEmpty
        ? []
        : searchProduct
            .where(
              (element) => element.name.toLowerCase().startsWith(
                    query.toLowerCase(),
                  ),
            )
            .toList();

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: searchProducts.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 1,
            child: ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(
                  '/detail',
                  arguments: searchProducts[index].id,
                );
                Provider.of<ProductsProvider>(context, listen: false)
                    .findImgById(searchProducts[index].id);
              },
              title: Text(searchProduct[index].name),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(searchProducts[index].thumbnail),
              ),
              subtitle: Text(
                '${searchProducts[index].price}៛',
              ),
            ),
          );
        },
      ),
    );
  }
}
