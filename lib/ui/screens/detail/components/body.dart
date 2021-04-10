// import 'package:badges/badges.dart';
import 'package:albazaar_app/core/components/widget_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:albazaar_app/core/components/card_c.dart';
import 'package:albazaar_app/ui/screens/detail/seller_information.dart';
import 'interact_view.dart';

class Body extends StatefulWidget {

  final Product product;
  final List<String> listImage;

  Body({this.product, this.listImage});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final double padding = 20;
  final List<Product> listProducts = [];
  bool dropDown = false;
  String display;
  int selected = 0;

  List<int> listAmount;
  int selectedAmount;

  TextEditingController _controller = TextEditingController();

  void relatedProducts(){
    listProducts.add(widget.product);
    listProducts.add(widget.product);
    listProducts.add(widget.product);
    listProducts.add(widget.product);
    listProducts.add(widget.product);
  }

  @override
  initState(){
    display = widget.product.thumbnail;
    listAmount = [1, 3, 5, 10];
    selectedAmount = -1;
    relatedProducts();
    super.initState();
  }
  
  @override
  dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {//ModalRoute.of(context).settings.arguments;
    // final widget.product = Provider.of<widget.ProductsProvider>(
    //   context,
    // ).findById(widget.product.id);

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
                  toolbarHeight: 70,
                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  floating: true,
                  pinned: true,
                  primary: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Hero(
                          tag: "${widget.product.id}",
                          child: SizedBox(
                            child: Consumer<ProductsProvider>(
                              builder: (context, value, child) => Carousel(
                                autoplay: false,
                                dotSpacing: 15.0,
                                dotColor: Colors.transparent,
                                dotBgColor: Colors.transparent,
                                dotIncreasedColor: Colors.transparent,
                                indicatorBgPadding: 10.0,
                                borderRadius: true,
                                animationCurve: Curves.decelerate,
                                // moveIndicatorFromBottom: 200.0,
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
                                            builder: (context) => InteractView(display),
                                          ),
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: display,
                                        placeholder: (context, str){
                                          return Image.asset('assets/loading.gif');
                                        },
                                      ),
                                      // child: FadeInImage(
                                      //     fit: BoxFit.cover,
                                      //     image: NetworkImage(
                                      //       value.url.isNotEmpty
                                      //           ? value.url[index]
                                      //           : widget.product.thumbnail,
                                      //     ),
                                      //     placeholder:
                                      //         AssetImage('assets/loading.gif')),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          left: (MediaQuery.of(context).size.width/2) - (25.0 * widget.listImage.length),
                          bottom: 20,
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.listImage.length,
                              itemBuilder: (context, i){
                                return ListWidgetBuilder.imageRowBuilder(
                                  context: context, 
                                  image: widget.listImage[i],
                                  selected: selected,
                                  index: i,
                                  onPressed: (){
                                    setState((){
                                      display = widget.listImage[i];
                                      selected = i;
                                    });
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => InteractView(/*value.url[index]*/widget.listImage[i]),
                                    //   ),
                                    // );
                                  }
                                );
                              }
                            )
                          )
                          // Row(
                          //   children: [,

                          //     GestureDetector(
                          //       onTap: () => Navigator.pop(context),
                          //       child: MyCard(
                          //         hexaColor: "#FFFFFF",
                          //         mRight: 10,
                          //         // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
                          //         width: 40, height: 40,
                          //         image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image: CachedNetworkImageProvider(widget.product.thumbnail)
                          //         ), 
                          //       ),
                          //     ),

                          //     GestureDetector(
                          //       onTap: () => Navigator.pop(context),
                          //       child: MyCard(
                          //         hexaColor: "#FFFFFF",
                          //         mRight: 10,
                          //         // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
                          //         width: 40, height: 40,
                          //         image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image: CachedNetworkImageProvider(widget.product.thumbnail)
                          //         ), 
                          //       ),
                          //     )
                          //   ],
                          // )
                        )
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: AppServices.hexaCodeToColor(AppColors.bgColor),
                child: Container(
                  // margin: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      MyPadding(
                        pTop: 17,
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Row(
                          children: [
                            Image.asset('assets/symbols/riel_symbol.png', width: 13.52, height: 22),
                            MyText(
                              left: 8,
                              textAlign: TextAlign.left,
                              text: "${widget.product.price} /Kg",
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            Expanded(child: Container()),

                            Consumer<FavoriteProvider>(
                              builder: (context, value, widgets){
                                return GestureDetector(
                                  onTap: (){
                                    setState((){

                                      // Not Yet Favorite and Click Add
                                      if (widget.product.isFav) {
                                        widget.product.isFav = false;
                                        value.removeFav(widget.product);
                                      }
                                      // Favorited and Click Remove
                                      else {
                                        widget.product.isFav = true;
                                        value.addFav(widget.product);
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset(AppConfig.iconPath+ ((widget.product.isFav) ? 'full_heart.svg': 'heart.svg'), width: 25, height: 23, color: AppServices.hexaCodeToColor(AppColors.secondary),)
                                );
                              },
                            )
                          ],
                        )
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            widget.product.name,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Row(
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
                              text: "(13) Sold",
                              fontSize: 12,
                              color: "#000000",
                            ),

                            Expanded(
                              child: Container(),
                            ),


                            GestureDetector(
                              onTap: () async {
                                final result = await MyBottomSheet().measurementOptions(context: context);
                                print("MY scale $result");
                              },
                              child: MyText(text: "Choose scale"),
                            )
                          ],
                        ),
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 50,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: listAmount.length,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                return GestureDetector(
                                  onTap: (){
                                    setState((){
                                      selectedAmount = index;
                                      widget.product.orderQty = listAmount[index];
                                    });
                                  },
                                  child: MyCard(
                                    hexaColor: "#FFFFFF",
                                    mRight: 10,
                                    boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(selectedAmount == index && selectedAmount != -1 ? AppColors.primary : AppColors.white)),
                                    width: 40, height: 40,
                                    child: MyText(
                                      fontSize: 12,
                                      text: "${listAmount[index]}Kg"
                                    ), 
                                  )
                                  );
                              })
                            ),
                            Expanded(child: Container()),

                            Consumer<ProductsProvider>(
                              builder: (context, value, child) {
                                if (widget.product.orderQty == null) widget.product.orderQty = 0;
                                return BtnQty(
                                  '${widget.product.orderQty ?? '0'}',
                                  () {
                                    value.addOrderQty(widget.product);
                                  },
                                  () {
                                    value.minusOrderQty(widget.product);
                                  },
                                  (){
                                    setState(() {
                                      if (widget.product.orderQty != 0){
                                        selectedAmount = -1;
                                      }
                                    });
                                  },
                                  tapText: () async {
                                    await Components.dialog(
                                      context, 
                                      MyPadding(
                                        child: TextFormField(
                                          controller: _controller,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(TextField.noMaxLength),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                        )
                                      ),
                                      Text("Input your quantity"),
                                      action: TextButton(
                                        child: MyText(text: "Submit", color: AppColors.primary),
                                        onPressed: () {
                                          Navigator.pop(context, _controller.text);
                                        }
                                      )
                                    );

                                    if (_controller.text.isNotEmpty) setState((){widget.product.orderQty = int.parse(_controller.text);});
                                  },
                                );
                              }
                            ),
                          ],
                        )
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Divider(
                          height: 1,
                          color: AppServices.hexaCodeToColor(AppColors.black),
                        )
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            //Shipping Amount
                            Row(
                              children: [
                                MyText(
                                  text: "Shipping: Riel",
                                  fontWeight: FontWeight.bold,
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Image.asset('assets/symbols/riel_symbol.png', width: 13.52, height: 15),
                                ),

                                MyText(
                                  text: "1000",
                                  fontWeight: FontWeight.bold,
                                ),

                                Expanded(child: Container()),

                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),

                            MyText(
                              top: padding,
                              textAlign: TextAlign.left,
                              text: "To Phnom Penh via SW Logistic Standard Shipping"
                            )
                          ],
                        ),
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Divider(
                          height: 1,
                          color: AppServices.hexaCodeToColor(AppColors.black),
                        )
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Row(
                          children: [
                            MyText(
                              pRight: 10,
                              text: 'About',
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                              fontSize: 20,
                            ),

                            MyText(text: "/", pRight: 10),

                            MyText(
                              text: 'Review (250)',
                              color: "#C4C4C4",
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            )
                          ],
                        ),
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: MyText(
                          textAlign: TextAlign.left,
                          text: widget.product.description ?? '',
                          fontSize: 16,
                        )
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Divider(
                          height: 1,
                          color: AppServices.hexaCodeToColor(AppColors.black),
                        )
                      ),
                      // ChangeNotifierProvider.value(
                      //   value: widget.product,
                      //   child: SellerInfo(),
                      // ),

                      Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyPadding(
                                pLeft: padding, pRight: padding,
                                pBottom: padding,
                                child: MyText(
                                  pRight: 10,
                                  text: 'Shop information',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),

                              // Seller
                              MyPadding(
                                pLeft: padding, pRight: padding,
                                pBottom: padding,
                                child: Row(
                                  children: [

                                    //Profile
                                    MyCard(
                                      hexaColor: AppColors.secondary,
                                      mRight: 10,
                                      // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
                                      width: 45, height: 42,
                                      align: Alignment.centerLeft,
                                      child: SvgPicture.asset('assets/avatar_user.svg', width: 25, height: 25),
                                    ),

                                    // Name & About
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          pRight: 10,
                                          text: 'Koompi',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),

                                        MyText(
                                          text: 'Phnom penh (Steng mean chey)',
                                          fontSize: 12,
                                        )
                                      ],
                                    ),

                                    Expanded(child: Container(),),

                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              )
                            ],
                          ),

                          // Tap To Pop Up Shop Information
                          GestureDetector(
                            onTap: () async {
                              await dialogblurBgDeco(context, SellerInformation());
                              // Navigator.push(
                              //   context, 
                              //   // MaterialPageRoute(builder: (context) => SellerInformation())
                              //   transitionRoute(SellerInformation())
                              // );
                            },
                            child: Container(width: MediaQuery.of(context).size.width, height: 100, color: Colors.transparent)
                          )
                        ]
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Divider(
                          height: 1,
                          color: AppServices.hexaCodeToColor(AppColors.black),
                        )
                      ),

                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: MyText(
                          text: AppLocalizeService.of(context).translate('related_product'),
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                        )
                      ),

                      // Related
                      MyPadding(
                        pLeft: 0, pRight: 0,
                        pBottom: padding,
                        child: SizedBox(
                          height: 240,
                          child: RelatedProduct(
                            category: widget.product.categoryName,
                            currentProductId: widget.product.id
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ), 

          Positioned(
            left: 20, top: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: MyCard(
                hexaColor: AppColors.bgColor,
                width: 40, height: 40,
                alignChild: Alignment.center,
                child: SvgPicture.asset('assets/icons/back.svg', width: 15, height: 25),
              ),
            )
          ),

          Positioned(
            right: 20, top: 20,
            child: Consumer<CartProvider>(
              builder: (context, value, widgets){
                return GestureDetector(
                  onTap: () {
                    value.addCart(widget.product.id, widget.product.thumbnail, widget.product.name, widget.product.price, widget.product.orderQty);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: MyText(text: 'Added ${widget.product.name} into cart', color: AppColors.white, textAlign: TextAlign.left,))
                    );
                  },
                  child: MyCard(
                    width: 40, height: 40,
                    hexaColor: AppColors.bgColor,
                    alignChild: Alignment.center,
                    child: SvgPicture.asset('assets/icons/cart.svg', width: 25, height: 25),
                  )
                );
              },
            )
          ),
        ],
      )
    );
  }
}
