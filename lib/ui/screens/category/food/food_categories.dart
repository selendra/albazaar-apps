import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class FoodCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _lang.translate('categories'),
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: kDefaultColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: foodCategories.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.pop(context, foodCategories[index]);
              },
              title: Text(foodCategories[index]),
              trailing: Icon(
                Icons.arrow_forward_ios,
              ),
            );
          }),
    );
  }
}
