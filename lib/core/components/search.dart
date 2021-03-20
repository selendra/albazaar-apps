import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/countries.dart';

import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String>{

  final recentCode =[];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // return Container(
    //   height: 100.0,
    //   width: 100.0,
    //   child: Card(
    //     color: Colors.red,
    //     shape: StadiumBorder(),
    //     child: Center(
    //       child: Text(query)
    //     )
    //   )
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty?recentCode:countries.where((element) => element['name'].startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context,index) {
      return ListTile(
        onTap: (){
          // showResults(context);
          close(context, suggestionList[index]['dial_code']);
        },
        leading: MyText(text: suggestionList[index]['flag']),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index]['name'].substring(0, query.length),
            style: TextStyle(
              color: AppServices.hexaCodeToColor(AppColors.primary,),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: suggestionList[index]['name'].substring(query.length),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                )
              )
            ]
          ),
        ),
        trailing: MyText(text: suggestionList[index]['dial_code'], textAlign: TextAlign.start,),
      );
    });
  }

}