import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(
        //   '/detail',
        //   arguments: product.id,
        // );

        // Provider.of<ProductsProvider>(context, listen: false)
        //     .findImgById(product.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kDefaultRadius + 4),
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 2,
          //     color: AppServices.hexaCodeToColor("#000000").withOpacity(0.25),
          //     spreadRadius: 2
          //   )
          // ]
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 5.0,
                          blurRadius: 5.0,
                        )
                      ],
                    ),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: product.thumbnail,
                      )
                    // SvgPicture.asset('images/avatar_user.svg')
                    // Hero(
                    //   tag: "{product.id}",
                    //   child: SvgPicture.asset('images/avatar_user.svg')
                    //   // FadeInImage(
                    //   //   fit: BoxFit.cover,
                    //   //   image: NetworkImage(product.thumbnail),
                    //   //   placeholder: AssetImage('images/loading.gif'),
                    //   // ),
                    // ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(
                    // products is out demo list
                    'product.name',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        // color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "{product.price}៛ /" +
                          AppLocalizeService.of(context).translate('kilogram'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kDefaultColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Align(
                alignment: Alignment.topRight,
                child: Consumer<FavoriteProvider>(
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () {
                        value.isFav(product);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.6),
                        ),
                        child: Icon(
                          product.isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



