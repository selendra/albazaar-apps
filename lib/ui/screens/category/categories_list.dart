import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class CategoriesListScreen extends StatefulWidget {
  final List<Categories> allCategories;
  CategoriesListScreen(this.allCategories);

  @override
  _CategoriesListScreenState createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  String stringFromResult;

  routB(context) async {
    final resultC = await Navigator.push<String>(context, MaterialPageRoute(builder: (context) => FoodCategories()));
    Navigator.pop(context, resultC );
  }

  void itemTap(int index, context) {
    switch (index) {
      case 0:
        routB(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(_lang.translate('categories'), context),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'All Categories',
      //     style: TextStyle(
      //       color: Colors.blue,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 18,
      //     ),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(icon: Icon(Icons.close,color: kDefaultColor,),onPressed: (){
      //     Navigator.pop(context);
      //   },),
      // ),
      body: _buildListVertical(context),
    );
  }

  Widget _buildListVertical(context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.allCategories.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {
                    itemTap(index, context);
                  },
                  title: Text(widget.allCategories[index].title),
                  leading: Image.asset(
                    widget.allCategories[index].img,
                    height: 30,
                    width: 30,
                  ));
            }));
  }
}
