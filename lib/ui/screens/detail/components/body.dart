import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:selendra_marketplace_app/core/components/card_c.dart';
import 'interact_view.dart';

class Body extends StatelessWidget {

  final double padding = 20;
  
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    // final product = Provider.of<ProductsProvider>(
    //   context,
    // ).findById(product.id);

    return SafeArea(
      child: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 0,
                  iconTheme: IconThemeData(
                    color: kDefaultColor,
                  ),
                  leading: Container(),
                  // CircleShapeBtn(
                  //     () => , Icons.arrow_back),
                  // actions: [
                  //   ,
                  // ],
                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  floating: true,
                  pinned: true,
                  primary: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: "${product.id}",
                      child: SizedBox(
                        child: Consumer<ProductsProvider>(
                          builder: (context, value, child) => Carousel(
                            autoplay: false,
                            dotSpacing: 15.0,
                            dotColor: Colors.grey,
                            dotBgColor: Colors.transparent,
                            dotIncreasedColor: kDefaultColor,
                            indicatorBgPadding: 10.0,
                            borderRadius: true,
                            animationCurve: Curves.decelerate,
                            moveIndicatorFromBottom: 180.0,
                            noRadiusForIndicator: true,
                            boxFit: BoxFit.cover,
                            images: List.generate(
                              value.url.isEmpty ? 1 : value.url.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InteractView(value.url[index]),
                                      ),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: product.thumbnail,
                                  ),
                                  // child: FadeInImage(
                                  //     fit: BoxFit.cover,
                                  //     image: NetworkImage(
                                  //       value.url.isNotEmpty
                                  //           ? value.url[index]
                                  //           : product.thumbnail,
                                  //     ),
                                  //     placeholder:
                                  //         AssetImage('images/loading.gif')),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: Colors.white,
                child: Container(
                  // margin: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      PaddingScaffold(
                        pTop: 17,
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Row(
                          children: [
                            Image.asset('images/symbols/riel_symbol.png', width: 13.52, height: 22),
                            MyText(
                              left: 8,
                              textAlign: TextAlign.left,
                              text: "${product.price} /Kg",
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            Expanded(child: Container()),
                            SvgPicture.asset('images/icons/heart.svg', width: 25, height: 23)
                          ],
                        )
                      ),

                      PaddingScaffold(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      PaddingScaffold(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 7),
                              child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
                            ),
                            MyText(
                              textAlign: TextAlign.left,
                              text: "(13) Sold",
                              fontSize: 12,
                              color: "#000000",
                            )
                          ],
                        ),
                      ),

                      PaddingScaffold(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Row(
                          children: [
                            MyCard(
                              mRight: 10,
                              boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
                              width: 40, height: 40,
                              child: MyText(
                                fontSize: 12,
                                text: "1Kg"
                              ), 
                            ),
                            MyCard(
                              mRight: 10,
                              boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
                              width: 40, height: 40,
                              child: MyText(
                                fontSize: 12,
                                text: "3Kg"
                              ), 
                            ),
                            MyCard(
                              mRight: 10,
                              boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
                              width: 40, height: 40,
                              child: MyText(
                                fontSize: 12,
                                text: "5Kg"
                              ), 
                            ),
                            MyCard(
                              mRight: 10,
                              boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
                              width: 40, height: 40,
                              child: MyText(
                                fontSize: 12,
                                text: "10Kg"
                              ), 
                            ),
                            Expanded(
                              child: Container()
                            ),

                            Consumer<ProductsProvider>(
                              builder: (context, value, child) => BtnQty(
                                '${product.orderQty ?? '0'}',
                                () {
                                  value.addOrderQty(product);
                                },
                                () {
                                  value.minusOrderQty(product);
                                },
                              ),
                            ),
                            // Text(
                            //   product.price.toString() +
                            //       '៛ /' +
                            //       AppLocalizeService.of(context)
                            //           .translate('kilogram'),
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w700,
                            //     fontSize: 23,
                            //     color: kDefaultColor,
                            //   ),
                            // )
                          ],
                        )
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     //_btnQtyRow(),
                      //     ,
                      //   ],
                      // ),

                      PaddingScaffold(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Row(
                          children: [
                            MyText(
                              pRight: 10,
                              text: 'About',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),

                            MyText(text: "/", pRight: 10),

                            MyText(
                              text: 'About',
                              color: "#C4C4C4",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            )
                          ],
                        ),
                      ),

                      PaddingScaffold(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: MyText(
                          textAlign: TextAlign.left,
                          text: product.description,
                          fontSize: 16,
                        )
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      // ChangeNotifierProvider.value(
                      //   value: product,
                      //   child: SellerInfo(),
                      // ),
                      SizedBox(
                        height: 30.0,
                      ),
                      RelatedProduct(),
                    ],
                  ),
                ),
              ),
            ),
          ),


          Positioned(
            left: 25, top: 25,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset('images/icons/back.svg', width: 15, height: 25),
            )
          ),
        ],
      )
    );
  }
}
