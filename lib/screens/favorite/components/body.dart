import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/products.dart';
import 'package:selendra_marketplace_app/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: myFav.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(kDefaultRadius),
              ),
              child: ListTile(
                title: Text(myFav[index].title),
                subtitle: Text(
                  myFav[index].description,
                  maxLines: 1,
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(myFav[index].image),
                ),
                trailing: IconButton(icon: Icon(Icons.delete),color: Colors.red,onPressed: (){
                  setState(() {
                    myFav.removeAt(index);
                  });
                },),
                onTap: () {
                  print(myFav[index].title);
                },
              ),
            );
          }),
    );
  }
}
