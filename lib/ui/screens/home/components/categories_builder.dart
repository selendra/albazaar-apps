import 'package:albazaar_app/all_export.dart';

class CategoriesBuider extends StatefulWidget {

  final String category;
  final Function onTapCategoy;
  final Function popAnmation;

  CategoriesBuider({this.onTapCategoy, this.category, this.popAnmation});

  @override
  _CategoriesBuiderState createState() => _CategoriesBuiderState();
}

class _CategoriesBuiderState extends State<CategoriesBuider> {
  
  ProductsProvider productsProvider;
  
  final double cPadding = 10;

  final double padding = 16;

  @override
  Widget build(BuildContext context) {
    productsProvider = Provider.of<ProductsProvider>(context);
    List<Product> listProduct = Provider.of<GuestAccProvider>(context).getProducts;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Vegetables'),
      // ),
      body: Column(
        children: [

          GestureDetector(
            onTap: (){
              widget.popAnmation();
            },
            child:  Container(
              color: AppServices.hexaCodeToColor(AppColors.bgColor),
              child: MyPadding(
                pLeft: 16, pRight: 16,
                pBottom: 20,
                child: Row(
                  children: [
                    MyPadding(
                      pLeft: 0, pRight: 10,
                      child: SvgPicture.asset(AppConfig.iconPath+'back.svg')
                    ),

                    MyText(
                      text: widget.category,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 22,
                    )
                  ],
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
  }
}