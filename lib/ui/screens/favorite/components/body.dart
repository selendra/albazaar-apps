import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final favData = Provider.of<FavoriteProvider>(context);
    final _fav = favData.items;
    return Container(
      child: _fav.isNotEmpty
          ? ListView.builder(
              itemCount: _fav.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: DimissibleBackground(),
                  onDismissed: (direction) {
                    favData.removeFav(_fav[index]);
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
                      title: Text(_fav[index].title),
                      subtitle: Text(
                        _fav[index].description,
                        maxLines: 1,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(_fav[index].image),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('/detail', arguments: _fav[index].id);
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
