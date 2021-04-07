import 'package:albazaar_app/core/providers/guest_acc_p.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class Body extends StatelessWidget {

  final TabController tabController;
  final Function onTapTab;
  final Function refresh;

  Body({
    this.tabController,
    this.onTapTab,
    this.refresh
  });
  
  final double cPadding = 10;
  final double padding = 16;
  
  ProductsProvider productsProvider;
  
  @override
  Widget build(BuildContext context) {
    productsProvider = Provider.of<ProductsProvider>(context);
    List<Product> listProduct = Provider.of<GuestAccProvider>(context).getProducts;
    Provider.of<CategoriesModel>(context).init();
    return RefreshIndicator(
      onRefresh: refresh,
      child: listProduct == null ? Center(
        child: CircularProgressIndicator(),
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
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: padding,
                    mainAxisSpacing: padding,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: listProduct == null ? 0 : listProduct.length,
                  itemBuilder: (context, index) => MyPadding(
                      pLeft: 0, pRight: 0,
                      pBottom: listProduct.length -1 == index || listProduct.length - 2 == index ? 16 : 0, 
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(product: listProduct[index])));
                        },
                        child: MyCard(
                          align: Alignment.centerLeft,
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
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
