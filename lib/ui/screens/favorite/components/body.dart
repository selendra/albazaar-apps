import 'package:flutter/material.dart';

import 'package:selendra_marketplace_app/all_export.dart';

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
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text("Favorite Removed"),
                    //   ),
                    // );
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Favorite Removed")));
                  },
                  child: _favoriteItemCard(
                    _fav[index].thumbnail,
                    _fav[index].name,
                    _fav[index].description,
                    _fav[index].price,
                    _fav[index].id,
                  ),
                  // child: Container(
                  //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(kDefaultRadius),
                  //   ),
                  //   child: ListTile(
                  //     title: Text(_fav[index].name),
                  //     subtitle: Text(
                  //       _fav[index].description,
                  //       maxLines: 1,
                  //     ),
                  //     leading: CircleAvatar(
                  //       backgroundColor: Colors.white,
                  //       backgroundImage: NetworkImage(_fav[index].thumbnail),
                  //     ),
                  //     onTap: () {
                  //       Navigator.of(context)
                  //           .pushNamed(DetailView, arguments: _fav[index].id);
                  //     },
                  //   ),
                  // ),
                );
              })
          : Center(
              child: Image.network(
                'images/undraw_loving_it.svg',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              // child: SvgPicture.asset(
              //   'images/undraw_loving_it.svg',
              //   height: MediaQuery.of(context).size.height * 0.3,
              //   width: MediaQuery.of(context).size.width * 0.3,
              // ),
              // child: Image.network(
              //   'https://i.pinimg.com/originals/81/c4/fc/81c4fc9a4c06cf57abf23606689f7426.jpg',
              //   width: 300,
              //   height: 300,
              // ),
            ),
    );
  }

  Widget _favoriteItemCard(String url, String name, String description,
      String price, String productId) {
    var _lang = AppLocalizeService.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(kDefaultRadius),
      onTap: () {
        Navigator.pushNamed(context, DetailView, arguments: productId);
      },
      child: Card(
        shape: kDefaultShape,
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(kDefaultRadius),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        spreadRadius: 5.0,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 200,
                    child: ListTile(
                      title: Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold).copyWith(
                          wordSpacing: 0,
                        ),
                      ),
                      subtitle: Text(
                        description,
                        style: TextStyle(fontWeight: FontWeight.bold).copyWith(
                          wordSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 20,
                    width: 200,
                    child: ListTile(
                      subtitle: Text(
                        _lang.translate('price') + ': $price៛ ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kDefaultColor,
                        ).copyWith(wordSpacing: 0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).showCursorOnHover.hoverAnimation;
  }
}
