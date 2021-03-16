import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:albazaar_app/core/components/card_c.dart';

class ReuseItemCard extends StatefulWidget {

  //Margin Left for only first item
  final double mLeft;
  final Product product; 

  ReuseItemCard({this.product, this.mLeft});

  @override
  _ReuseItemCardState createState() => _ReuseItemCardState();
}

class _ReuseItemCardState extends State<ReuseItemCard> {

  final double padding = 16;
  final double pBottom = 20;
  final double cPadding = 10;

  @override
  initState(){
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).pushNamed('/detail', arguments: widget.product.id);
      },
      child: MyCard(
        mRight: 19,
        mLeft: widget.mLeft,
        width: 185,//MediaQuery.of(context).size.width,
        align: Alignment.centerLeft,
        child: Container(
          // height: 235,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // Flexible(
              //   child: 
                // FadeInImage(
                //         fit: BoxFit.contain,
                //         height: double.infinity,
                //         width: double.infinity,
                //         image: NetworkImage(widget.product.thumbnail),
                //         placeholder: AssetImage('assets/loading.gif'),
                //       )
                // MyCard(
                //   // height: 141,
                //   width: double.infinity,
                //   hexaColor: AppColors.cardTitleBG,
                //   bBottomLeft: 0,
                //   bBottomRight: 0,
                //   align: Alignment.topCenter,
                //   child: Stack(
                //     children: [
                //       // Center(
                //       //   child: SvgPicture.asset('assets/avatar_user.svg'),
                //       // ),
                //       FadeInImage(
                //         fit: BoxFit.contain,
                //         height: double.infinity,
                //         width: double.infinity,
                //         image: NetworkImage(widget.product.thumbnail),
                //         placeholder: AssetImage('assets/loading.gif'),
                //       ),
                //       Positioned(
                //         right: 10, top: 10,
                //         child: GestureDetector(
                //           child: SvgPicture.asset('assets/icons/heart.svg'),
                //         ),
                //       )
                //     ],
                //   ),
                // )
              // ),
              Flexible(
                child: MyCard(
                  bBottomLeft: 0, bBottomRight: 0,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(widget.product.thumbnail)
                  ),
                )
              ),

              MyCard(
                align: Alignment.centerLeft,
                bTopLeft: 0, bTopRight: 0,
                mBottom: cPadding, mTop: cPadding, mLeft: cPadding, mRight: cPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: MyText(
                              textAlign: TextAlign.left,
                              text: "${widget.product.name}",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: "#000000",
                            )
                          ),
                          
                          MyText(
                            text: "(0 sold)",
                            fontSize: 12,
                            color: "#000000",
                          )
                        ],
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: MyText(
                        textAlign: TextAlign.left,
                        text: "${widget.product.description}",
                        fontSize: 16,
                        color: "#000000",
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Image.asset('assets/symbols/riel_symbol.png', width: 9, height: 15),
                          MyText(
                            textAlign: TextAlign.left,
                            text: "${widget.product.price} /Kg",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          )
                        ],
                      )
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 7),
                          child: SvgPicture.asset('assets/icons/rate_star.svg', height: 13, width: 13)
                        ),
                        MyText(
                          textAlign: TextAlign.left,
                          text: "(15)",
                          fontSize: 10,
                          color: "#000000",
                        )
                      ],
                    )
                    
                  ],
                ),
              )
            ],
          )
        ),
      )
      
      // Container(
      //   margin: EdgeInsets.symmetric(vertical: 5.0),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(kDefaultRadius * 2),
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       ClipRRect(
      //         borderRadius: BorderRadius.circular(kDefaultRadius),
      //         child: Container(
      //           width: double.infinity,
      //           height: MediaQuery.of(context).size.width * 0.4,
      //           decoration: BoxDecoration(
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Colors.white,
      //                 spreadRadius: 5.0,
      //                 blurRadius: 5.0,
      //               )
      //             ],
      //           ),
      //           child:CachedNetworkImage(imageUrl: product.thumbnail,fit: BoxFit.cover,) //Image.network(product.thumbnail, fit: BoxFit.cover),
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      //         child: Text(
      //           product.name,
      //           overflow: TextOverflow.ellipsis,
      //           style: TextStyle(
      //               // color: Colors.black,
      //               fontSize: 14.0,
      //               fontWeight: FontWeight.w600),
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 5),
      //         child: Text(
      //           "${product.price}៛",
      //           style: TextStyle(
      //               fontWeight: FontWeight.bold, color: kDefaultColor),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
