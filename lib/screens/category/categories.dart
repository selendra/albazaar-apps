import 'package:selendra_marketplace_app/screens/category/realestate/real_estate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:selendra_marketplace_app/models/categories.dart';

class CategoriesScreen extends StatelessWidget {

  final List<Categories> allCategories ;
  CategoriesScreen(this.allCategories);


  void itemTap(int index,context){
    print('$index');
    switch (index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RealEstate()));
        break;
    }
  }

  Widget itemCategory(Function onTap, String logo,String title){
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 50,
          width: 60,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Image(image: AssetImage(logo),),
              SizedBox(height: 5,),
              Text(title,style: TextStyle(fontSize: 12),)
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        itemBuilder: (context,index){
          return itemCategory((){itemTap(index, context);}, allCategories[index].image, allCategories[index].title);
        }
      )
    );
  }


}
