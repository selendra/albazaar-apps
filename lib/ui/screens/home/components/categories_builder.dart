import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/services/auth/find_service.dart';

class CategoriesBuider extends StatefulWidget {

  final ScrollController scrollController;

  final List<Product> productCategories;
  final String category;
  final Function onTapCategoy;
  final Function popAnmation;

  CategoriesBuider({this.scrollController, this.productCategories, this.onTapCategoy, this.category, this.popAnmation});

  @override
  _CategoriesBuiderState createState() => _CategoriesBuiderState();
}

class _CategoriesBuiderState extends State<CategoriesBuider> {
  
  final double cPadding = 10;

  final double padding = 16;

  @override
  initState(){
    print("My product by category ${widget.productCategories}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
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
                      child: SvgPicture.asset('${AppConfig.iconPath}back.svg')
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
                controller: widget.scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: padding,
                  mainAxisSpacing: padding,
                  childAspectRatio: 0.75,
                ),
                itemCount: widget.productCategories == null ? 0 : widget.productCategories.length,
                itemBuilder: (context, index) {
                  return MyPadding(
                    pLeft: 0, pRight: 0,
                    pBottom: 0,
                    child: GestureDetector(
                      onTap: (){
                        print(widget.productCategories[index].name);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DetailScreen(product: widget.productCategories[index],)
                        ));
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
                                  tag: "${widget.productCategories[index].id}",
                                  child: MyCard(
                                    bBottomLeft: 0, bBottomRight: 0,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(widget.productCategories[index].thumbnail) //CachedNetworkImageProvider(widget.productCategories[index].thumbnail)
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
                                              text: "${widget.productCategories[index].name}",
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
                                        text: "${widget.productCategories[index].description}",
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
                                          SvgPicture.asset('${AppConfig.symbolPath}riel.svg', width: 9, height: 15),
                                          MyText(
                                            textAlign: TextAlign.left,
                                            text: "${widget.productCategories[index].price} / ${FindingServices().findScaleById(widget.productCategories[index].weight, Provider.of<AddProductProvider>(context, listen: false).addProduct.weightList) ?? 'KG'}",
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
                  );
                }
              )
            )

          ),

        ],
      ),
    );
  }
}