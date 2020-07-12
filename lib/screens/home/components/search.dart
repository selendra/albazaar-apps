import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/products.dart';

class SearchProducts extends SearchDelegate{
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query ='';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
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

    final searchProducts = query.isEmpty
        ? []
        : products
        .where((element) =>
        element.title
        .toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
        itemCount: searchProducts.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text(searchProducts[index].title),
            leading: Image.asset(searchProducts[index].image),
            subtitle: Text(searchProducts[index].price.toString()),
          );
        }
    );
  }

}