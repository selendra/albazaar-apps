import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                      title: Text(_fav[index].name),
                      subtitle: Text(
                        _fav[index].description,
                        maxLines: 1,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            CachedNetworkImageProvider(_fav[index].thumbnail),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(DetailView, arguments: _fav[index].id);
                      },
                    ),
                  ),
                );
              })
          : Center(
              child: SvgPicture.asset(
                'images/undraw_loving_it.svg',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              // child: Image.network(
              //   'https://i.pinimg.com/originals/81/c4/fc/81c4fc9a4c06cf57abf23606689f7426.jpg',
              //   width: 300,
              //   height: 300,
              // ),
            ),
    );
  }
}
