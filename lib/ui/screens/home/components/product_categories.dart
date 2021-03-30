import 'package:albazaar_app/core/providers/guest_acc_p.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ProductCategories extends StatefulWidget {

  final TabController tabController;

  final Function onTapTab;
  final Function refresh;

  ProductCategories({
    this.tabController,
    this.onTapTab,
    this.refresh
  });

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<ProductCategories> {

  final double cPadding = 10;

  final double padding = 16;

  bool clicked = false;

  List<Map<String, dynamic>> images = [
    {'name': 'Vegetables', 'image': 'assets/categories/vegetable.png'},
    {'name': 'Electronics', 'image': 'assets/categories/koompi.png'},
    {'name': 'Vegetables', 'image': 'assets/categories/book.png'},
  ];

  ProductsProvider productsProvider;

  @override
  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productsProvider = Provider.of<ProductsProvider>(context);
    List<Product> listProduct = Provider.of<GuestAccProvider>(context).getProducts;
    return RefreshIndicator(
      onRefresh: widget.refresh,
      child: clicked == false ?
        ListView.builder(
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              
            },
            child: MyCard(
              colorOpacity: 0.0,
              pLeft: 16, pRight: 16, pBottom: 16,
              height: 171,
                child: Stack(
                  children: [
                    // Image.asset(),
                    MyCard(
                      colorOpacity: 0.0,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          images[index]['image']
                        )
                      ),
                    ),

                    MyCard(
                      width: double.infinity,
                      height: double.infinity,
                      colorOpacity: 0.4,
                      hexaColor: AppColors.lowBlack,
                      alignChild: Alignment.center,
                      child: MyText(
                        text: images[index]['name'],
                        color: AppColors.white
                      ),
                    ),
                  ],
                )
              ),
            );
          }
        )      
        : Column(
          children: [
            Container(
              color: AppServices.hexaCodeToColor(AppColors.bgColor),
              child: MyPadding(
                pLeft: 16, pRight: 16,
                pBottom: 16,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: MyText(
                    text: "All Products",
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  )
                )
              )
            ),

            Expanded(
              child:  MyPadding(
                pLeft: padding, pRight: padding,
                pBottom: padding,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: padding,
                    mainAxisSpacing: padding,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: listProduct == null ? 0 : listProduct.length,
                  itemBuilder: (context, index) => MyPadding(
                      pLeft: 0, pRight: 0,
                      pBottom: 0,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(
                            '/detail',
                            arguments: listProduct[index],
                          );
                        },
                        child: MyCard(
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
                                  //         image: NetworkImage(listProduct[index].thumbnail),
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
                                  //         image: NetworkImage(listProduct[index].thumbnail),
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
                                  child: Hero(
                                    tag: "${listProduct[index].id}",
                                    child: MyCard(
                                      bBottomLeft: 0, bBottomRight: 0,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(listProduct[index].thumbnail) //CachedNetworkImageProvider(listProduct[index].thumbnail)
                                      ),
                                    )
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
                                                text: "${listProduct[index].name}",
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
                                          text: "${listProduct[index].description}",
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
                                              text: "${listProduct[index].price} /Kg",
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                              pLeft: 5,
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
                          )
                        )
                      ),
                  )
                )
              )

            ),

          ],
        ),
    );
      // productsProvider.items.isEmpty
      // ? Center(
      //     child: CircularProgressIndicator(),
      //   )
      // : 
      // Container(
      //   padding: EdgeInsets.only(bottom: 10),
      //   child: Column(
      //     children: <Widget>[

      //       //SearchBar(),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       // CategoriesScreen(category),
      //       ProductList(productsProvider.items),
      //     ],
      //   ),
      // ),
  }
}
