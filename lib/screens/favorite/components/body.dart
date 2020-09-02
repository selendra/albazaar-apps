import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/models/products.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: myFav.isNotEmpty
          ? ListView.builder(
              itemCount: myFav.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: DimissibleBackground(),
                  onDismissed: (direction) {
                    setState(() {
                      myFav.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Favorite Removed")));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                      onTap: () {
                        print(myFav[index].title);
                      },
                    ),
                  ),
                );
              })
          : Center(
              child: Image.network(
                'https://i.pinimg.com/originals/81/c4/fc/81c4fc9a4c06cf57abf23606689f7426.jpg',
                width: 300,
                height: 300,
              ),
            ),
    );
  }
}
