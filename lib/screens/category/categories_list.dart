import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:selendra_marketplace_app/models/categories.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/screens/category/realestate/real_estate.dart';
import 'package:selendra_marketplace_app/screens/category/realestate/real_estate_categories.dart';


class CategoriesListScreen extends StatefulWidget {

  final List<Categories> allCategories ;
  CategoriesListScreen(this.allCategories);

  @override
  _CategoriesListScreenState createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {

  String stringFromResult;

   routB(context) async{
    final resultC = await  Navigator.push<String>(context, MaterialPageRoute(builder: (context)=>RealEstateCategories()));
    Navigator.pop(context,resultC);
    print(resultC);

  }

  void itemTap(int index,context){
    print('$index');
    switch (index){
      case 0:
        routB(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'All Categories',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.close,color: kDefualtColor,),onPressed: (){
          Navigator.pop(context,false);
        },),
      ),
      body: _buildListVertical(context),
    );
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

  Widget _buildListVertical(context){
    return Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.allCategories.length,
            itemBuilder: (context,index){
              return ListTile(
                onTap: (){itemTap(index, context);},
                title: Text(widget.allCategories[index].title),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(widget.allCategories[index].image),
                ),
              );
            }
        )
    );
  }
}
