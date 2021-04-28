// import 'package:badges/badges.dart';
import 'package:albazaar_app/core/components/widget_builder.dart';
import 'package:albazaar_app/ui/screens/detail/components/comment_user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:albazaar_app/core/components/card_c.dart';
import 'package:albazaar_app/ui/screens/detail/seller_information.dart';
import 'interact_view.dart';
import 'package:readmore/readmore.dart';

class Body extends StatefulWidget {

  final Product product;
  final List<String> listImage;
  final CartProvider cartProvider;
  final List<Product> productByCategory;

  Body({this.product, this.listImage, this.cartProvider, this.productByCategory});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final double padding = 20;
  final List<Product> listProducts = [];
  bool dropDown = false;
  String display;
  int selected = 0;

  String scale = 'Scale';

  // List Of Amount 1, 3, 5, 10
  List<int> listAmount;

  // For Handle Selected On List Row Selected Amount VS Increase and Input
  int selectedAmount;
  
  bool about = true;

  TextEditingController _controller = TextEditingController();

  void relatedProducts(){
    for(var p in widget.productByCategory){
      if (p.id == widget.product.id){
        widget.productByCategory.remove(p);
        break;
      }
    }
  }

  void onChangeTotal(){
    // Caculate and Display Total
    widget.cartProvider.totalPrice = 0;
    widget.cartProvider.caculateAmount(widget.product.price, widget.product.orderQty);

    widget.cartProvider.updateNotifier();
  }

  void onChangeImage(int i){
    setState((){
      display = widget.listImage[i];
      selected = i;
    });
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
    
    // Initailize total with product detail price
    if (widget.cartProvider != null) widget.cartProvider.caculateAmount(widget.product.price, widget.product.orderQty);

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
                                onImageChange: (i,j){
                                  onChangeImage(j);
                                },
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
                            width: 50,
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
                                    onChangeImage(i);
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

                      Row(
                        children: [
                          MyPadding(
                            pTop: 16,
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

                          Expanded(
                            child: Container()
                          ),

                          MyPadding(
                            pTop: 16,
                            pLeft: padding, pRight: padding,
                            pBottom: padding,
                            child: Row(
                              children: [
                                SvgPicture.asset('${AppConfig.symbolPath}riel.svg', width: 13.52, height: 22),
                                MyText(
                                  left: 8,
                                  textAlign: TextAlign.left,
                                  text: "${widget.product.price}",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ],
                            )
                          )
                        ]
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Container()
                          ),

                          MyPadding(
                            pLeft: padding, pRight: padding,
                            pBottom: padding,
                            child: Row(
                              children: [

                                GestureDetector(
                                  onTap: () async {
                                    final result = await MyBottomSheet().measurementOptions(context: context);
                                    print(result);
                                    setState(() {
                                      scale = result['weight_option'];
                                    });
                                  },
                                  child: MyText(text: scale, fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 25,),
                                )
                              ],
                            ),
                          )
                        ],
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
                                      // Assign orderQty with List Row Selection
                                      widget.product.orderQty = listAmount[index];

                                      // Caculate and Display Total
                                      onChangeTotal();
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
                              builder: (context, pValue, child) {
                                if (widget.product.orderQty == null) widget.product.orderQty = 0;
                                return BtnQty(
                                  '${widget.product.orderQty ?? '0'}',
                                  () {
                                    // Caculate and Display Total
                                    onChangeTotal();

                                    pValue.addOrderQty(widget.product);
                                  },
                                  () {
                                    // Caculate and Display Total
                                    onChangeTotal();

                                    pValue.minusOrderQty(widget.product);
                                  },
                                  tapText: () async {
                                    // Aisgn Controller value with current Qty
                                    _controller.text = widget.product.orderQty.toString();
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
                                          selectedAmount = -1;
                                          Navigator.pop(context, _controller.text);
                                        }
                                      )
                                    );

                                    if (_controller.text.isNotEmpty) {
                                      setState((){widget.product.orderQty = int.parse(_controller.text);});
                                      
                                      // Caculate and Display Total
                                      onChangeTotal();
                                    }
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
                                  child: SvgPicture.asset('${AppConfig.symbolPath}riel.svg', width: 13.52, height: 15),
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
                            GestureDetector(
                              onTap: (){
                                if (about == false){
                                  setState((){
                                    about = true;
                                  });
                                }
                              },
                              child: MyText(
                                pRight: 10,
                                text: 'About',
                                fontWeight: FontWeight.w600,
                                color: about ? AppColors.primary : AppColors.unSelected,
                                fontSize: 20,
                              ),
                            ),

                            MyText(text: "/", pRight: 10),

                            GestureDetector(
                              onTap: (){
                                if (about = true){
                                  setState((){
                                    about = false;
                                  });
                                }
                              },
                              child: MyText(
                                text: 'Review (250)',
                                color: !about ? AppColors.primary : AppColors.unSelected,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),

                      about ? MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: ReadMoreText(
                          widget.product.description,
                          trimLines: 5,
                          colorClickableText: AppServices.hexaCodeToColor(AppColors.black),
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          style: TextStyle(fontSize: 18, color: AppServices.hexaCodeToColor(AppColors.black)),
                          lessStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppServices.hexaCodeToColor(AppColors.black)),
                          moreStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppServices.hexaCodeToColor(AppColors.black)),
                        )
                      ) 
                      : 
                      MyPadding(
                        pLeft: padding, pRight: padding,
                        pBottom: padding,
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: CommentUser(),
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
                hexaColor: AppColors.primary,
                width: 40, height: 40,
                alignChild: Alignment.center,
                child: SvgPicture.asset('assets/icons/back.svg', color: AppServices.hexaCodeToColor(AppColors.white), width: 15, height: 25),
              ),
            )
          ),

          Positioned(
            right: 20, top: 20,
            child: Row(
              children: [

                Container(
                  margin: EdgeInsets.only(right: 12),
                  child: Consumer<CartProvider>(
                    builder: (context, value, widgets){
                      return GestureDetector(
                        onTap: () async {
                          print(value);
                          // if (value.ite == (widget.product.id) {
                          //   value.addCart(widget.product.id, widget.product.thumbnail, widget.product.name, widget.product.price, widget.product.orderQty);
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: MyText(text: 'Added ${widget.product.name} into cart', color: AppColors.white, textAlign: TextAlign.left,))
                          //   );
                          // } else {
                          //   await Components.dialog(context, Text("This item already add", textAlign: TextAlign.center), Text("Message"));
                          // }
                        },
                        child: MyCard(
                          width: 40, height: 40,
                          hexaColor: AppColors.primary,
                          alignChild: Alignment.center,
                          child: SvgPicture.asset('assets/icons/cart.svg', color: AppServices.hexaCodeToColor(AppColors.white), width: 25, height: 25),
                        )
                      );
                    },
                  )
                ),

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
                      child: MyCard(
                        hexaColor: AppColors.primary,
                        width: 40, height: 40,
                        alignChild: Alignment.center,
                        child: SvgPicture.asset(AppConfig.iconPath+ ((widget.product.isFav) ? 'full_heart.svg': 'heart.svg'), width: 25, height: 23, color: AppServices.hexaCodeToColor(AppColors.white),)
                        // SvgPicture.asset('assets/icons/heart.svg', color: AppServices.hexaCodeToColor(AppColors.white), width: 15, height: 25),
                      )
                    );
                  },
                )
              ],
            )
          ),
        ],
      )
    );
  }
}
