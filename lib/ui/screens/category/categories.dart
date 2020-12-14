import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Categories> allCategories;
  CategoriesScreen(this.allCategories);

  void itemTap(int index, context, String image, String categoriesName) {
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodsScreen(image, categoriesName)));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodsScreen(image, categoriesName)));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodsScreen(image, categoriesName)));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodsScreen(image, categoriesName)));
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodsScreen(image, categoriesName)));
        break;
      case 5:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodsScreen(image, categoriesName)));
        break;
    }
  }

  Widget itemCategory(Function onTap, String img, {String title}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        alignment: Alignment.center,
        child: Image.asset(
          img,
          height: 30,
          width: 40,
        ),
        // Column(
        //   children: <Widget>[
        //     Image.asset(logo,height: 40,width: 40,),
        //     SizedBox(height: 5,),
        //     // Text(title,style: TextStyle(fontSize: 12),)
        //   ],
        // )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        //margin: EdgeInsets.symmetric(vertical: 5.0),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: allCategories.length,
            itemBuilder: (context, index) {
              return itemCategory(() {
                itemTap(
                  index,
                  context,
                  allCategories[index].img,
                  allCategories[index].title,
                );
              }, allCategories[index].img);
            }));
  }
}
