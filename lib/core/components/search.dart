import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/countries.dart';
import 'package:albazaar_app/core/providers/guest_acc_p.dart';
import 'package:albazaar_app/core/services/auth/find_service.dart';

import 'package:flutter/material.dart';

class CountrySearch extends SearchDelegate<String>{

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
    final suggestionList = query.isEmpty ? recentCode : countries.where((element) => element['name'].startsWith(query)).toList();
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

class ProductSearch extends SearchDelegate<String>{

  final recentCode =[];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
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

    List<Product> listProduct = Provider.of<GuestAccProvider>(context).getProducts;
    final suggestionList = query.isEmpty ? recentCode : listProduct.where((element) => element.name.startsWith(query)).toList();

    return MyPadding(
      pTop:16,
      pLeft: 16, pRight: 16,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: suggestionList.length,
        itemBuilder: (context,index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: (){
            Navigator.of(context).pushNamed(
              '/detail',
              arguments: suggestionList[index].id,
            );
          },
          // leading: MyText(text: suggestionList[index]['flag']),
          title: MyCard(
            pLeft: 0, pRight: 0,
            pBottom: 0,
            align: Alignment.centerLeft,
            child: Container(
              // height: 235,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Flexible(
                    child: Hero(
                      tag: "${suggestionList[index].id}",
                      child: MyCard(
                        bBottomLeft: 0, bBottomRight: 0,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(suggestionList[index].thumbnail) //CachedNetworkImageProvider(listProduct[index].thumbnail)
                        ),
                      )
                    )
                  ),

                  MyCard(
                    align: Alignment.centerLeft,
                    bTopLeft: 0, bTopRight: 0,
                    mBottom: 10, mTop: 10, mLeft: 10, mRight: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MyText(
                                  textAlign: TextAlign.left,
                                  text: "${suggestionList[index].name}",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: "#000000",
                                )
                              ),
                              
                              MyText(
                                text: "(0 sold)",
                                fontSize: 12,
                                color: "#000000",
                              )
                            ],
                          )
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: MyText(
                            textAlign: TextAlign.left,
                            text: "${suggestionList[index].description}",
                            fontSize: 16,
                            color: "#000000",
                            overflow: TextOverflow.ellipsis,
                            maxLine: 1,
                          )
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              SvgPicture.asset('${AppConfig.symbolPath}/riel.svg', width: 9, height: 15),
                              MyText(
                                textAlign: TextAlign.left,
                                text: "${suggestionList[index].price}" + FindingServices().findScaleById(suggestionList[index].weight, Provider.of<AddProductProvider>(context, listen: false).addProduct.weightList),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                pLeft: 5,
                              )
                            ],
                          )
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            MyText(
                              textAlign: TextAlign.left,
                              text: "(15)",
                              fontSize: 10,
                              color: "#000000",
                            )
                          ],
                        )
                        
                      ],
                    ),
                  )
                ],
              )
            )
          )
        );
      })
    );
  }

}