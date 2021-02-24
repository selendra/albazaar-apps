// import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:selendra_marketplace_app/core/components/card_c.dart';
import 'interact_view.dart';

class Body extends StatelessWidget {

  final double padding = 20;final List<Product> listProducts = List<Product>();

  final Product products = Product(
    description: 'នេះគឺជាដំណើរជីវិតរបស់ក្មេងស្រីម្នាក់ក្នុងចំណោមក្មេងស្រីជាច្រើនផ្សេងទៀតដែលចាប់កំណើតឡើងនៅទីជនបទ។ នាងចេះមានក្តីស្រមៃតាំងពីតូច ហើយក្ដីស្រមៃនោះបានជំរុញឱ្យនាងខិតខំតតាំងនឹងភាពលំបាកក្នុងជីវិត។ ពេលវេលានៃកុមារភាពរបស់នាងក្លាយជាពេលវេលាដែលត្រូវតតាំងប្រឹងរស់ដូចមនុស្សធំពេញវ័យ វាខុសពីក្មេងដទៃផ្សេងទៀតជាច្រើនដែលអាចស្គាល់ពីរសជាតិជីវិតដ៏កក់ក្ដៅក្នុងរង្វង់ដ',
    shippingService: "SW Logistic",
    address: null,
    name: "កាពីទែនជីវិត ភាគ1",
    categoryName: "Others",
    thumbnail: "https://selendra.s3-ap-southeast-1.amazonaws.com/1bf46702-f69e-4fad-840b-89e0ae9a8edc",
    phonenumber: null,
    weight: "b8fd8a60-242c-405d-8a62-1ae2880094a7",
    id: "be630b54-f67b-4b89-aed2-c3a997a9a105",
    paymentId: "3802b352-4b1e-4ec3-a24c-c1e042d3fadd",
    price: 7,
    shippingFee: 1.99,
    createdAt: "2021-02-18T02:31:54Z",
    seller: Seller.fromJson({
      "type": "record",
      "value": "(,)"
    }),
    isSold: false
  );

  Body(){
    fillData();
  }

  void fillData(){
    listProducts.add(products);
    listProducts.add(products);
    listProducts.add(products);
    listProducts.add(products);
    listProducts.add(products);
  }
  
  @override
  Widget build(BuildContext context) {
    final Product product = Product(
      description: 'នេះគឺជាដំណើរជីវិតរបស់ក្មេងស្រីម្នាក់ក្នុងចំណោមក្មេងស្រីជាច្រើនផ្សេងទៀតដែលចាប់កំណើតឡើងនៅទីជនបទ។ នាងចេះមានក្តីស្រមៃតាំងពីតូច ហើយក្ដីស្រមៃនោះបានជំរុញឱ្យនាងខិតខំតតាំងនឹងភាពលំបាកក្នុងជីវិត។ ពេលវេលានៃកុមារភាពរបស់នាងក្លាយជាពេលវេលាដែលត្រូវតតាំងប្រឹងរស់ដូចមនុស្សធំពេញវ័យ វាខុសពីក្មេងដទៃផ្សេងទៀតជាច្រើនដែលអាចស្គាល់ពីរសជាតិជីវិតដ៏កក់ក្ដៅក្នុងរង្វង់ដ',
      shippingService: "SW Logistic",
      address: null,
      name: "កាពីទែនជីវិត ភាគ1",
      categoryName: "Others",
      thumbnail: "https://selendra.s3-ap-southeast-1.amazonaws.com/1bf46702-f69e-4fad-840b-89e0ae9a8edc",
      phonenumber: null,
      weight: "b8fd8a60-242c-405d-8a62-1ae2880094a7",
      id: "be630b54-f67b-4b89-aed2-c3a997a9a105",
      paymentId: "3802b352-4b1e-4ec3-a24c-c1e042d3fadd",
      price: 7,
      shippingFee: 1.99,
      createdAt: "2021-02-18T02:31:54Z",
      seller: Seller.fromJson({
        "type": "record",
        "value": "(,)"
      }),
      isSold: false
    );//ModalRoute.of(context).settings.arguments;
    // final product = Provider.of<ProductsProvider>(
    //   context,
    // ).findById(product.id);

    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
                        height: 200,
                        child: RelatedProduct()
                      ),
          // NestedScrollView(
          //   headerSliverBuilder: (context, innerBoxIsScrolled) {
          //     return <Widget>[
          //       SliverAppBar(
          //         elevation: 0,
          //         iconTheme: IconThemeData(
          //           color: kDefaultColor,
          //         ),
          //         leading: Container(),
          //         // CircleShapeBtn(
          //         //     () => , Icons.arrow_back),
          //         // actions: [
          //         //   ,
          //         // ],
          //         expandedHeight: MediaQuery.of(context).size.height * 0.5,
          //         floating: true,
          //         pinned: true,
          //         primary: true,
          //         flexibleSpace: FlexibleSpaceBar(
          //           background: Stack(
          //             children: [
          //               Hero(
          //                 tag: "${product.id}",
          //                 child: SizedBox(
          //                   child: Consumer<ProductsProvider>(
          //                     builder: (context, value, child) => Carousel(
          //                       autoplay: false,
          //                       dotSpacing: 15.0,
          //                       dotColor: Colors.transparent,
          //                       dotBgColor: Colors.transparent,
          //                       dotIncreasedColor: Colors.transparent,
          //                       indicatorBgPadding: 10.0,
          //                       borderRadius: true,
          //                       animationCurve: Curves.decelerate,
          //                       moveIndicatorFromBottom: 200.0,
          //                       noRadiusForIndicator: true,
          //                       boxFit: BoxFit.cover,
          //                       images: List.generate(
          //                         value.url.isEmpty ? 1 : value.url.length,
          //                         (index) {
          //                           return GestureDetector(
          //                             onTap: () {
          //                               Navigator.push(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                   builder: (context) =>
          //                                       InteractView(value.url[index]),
          //                                 ),
          //                               );
          //                             },
          //                             child: CachedNetworkImage(
          //                               fit: BoxFit.cover,
          //                               imageUrl: product.thumbnail,
          //                             ),
          //                             // child: FadeInImage(
          //                             //     fit: BoxFit.cover,
          //                             //     image: NetworkImage(
          //                             //       value.url.isNotEmpty
          //                             //           ? value.url[index]
          //                             //           : product.thumbnail,
          //                             //     ),
          //                             //     placeholder:
          //                             //         AssetImage('images/loading.gif')),
          //                           );
          //                         },
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),

          //               Positioned(
          //                 left: (MediaQuery.of(context).size.width/2) - (25.0 * 3.0),
          //                 bottom: 20,
          //                 child: Row(
          //                   children: [
          //                     GestureDetector(
          //                       onTap: () => Navigator.pop(context),
          //                       child: MyCard(
          //                         hexaColor: "#FFFFFF",
          //                         mRight: 10,
          //                         boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
          //                         width: 40, height: 40,
          //                         image: DecorationImage(
          //                           fit: BoxFit.cover,
          //                           image: CachedNetworkImageProvider(product.thumbnail)
          //                         ), 
          //                       ),
          //                     ),

          //                     GestureDetector(
          //                       onTap: () => Navigator.pop(context),
          //                       child: MyCard(
          //                         hexaColor: "#FFFFFF",
          //                         mRight: 10,
          //                         // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
          //                         width: 40, height: 40,
          //                         image: DecorationImage(
          //                           fit: BoxFit.cover,
          //                           image: CachedNetworkImageProvider(product.thumbnail)
          //                         ), 
          //                       ),
          //                     ),

          //                     GestureDetector(
          //                       onTap: () => Navigator.pop(context),
          //                       child: MyCard(
          //                         hexaColor: "#FFFFFF",
          //                         mRight: 10,
          //                         // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
          //                         width: 40, height: 40,
          //                         image: DecorationImage(
          //                           fit: BoxFit.cover,
          //                           image: CachedNetworkImageProvider(product.thumbnail)
          //                         ), 
          //                       ),
          //                     )
          //                   ],
          //                 )
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ];
          //   },
          //   body: SizedBox(
                      //   height: 200,
                      //   child: RelatedProduct()
                      // ),
          //   SingleChildScrollView(
          //     scrollDirection: Axis.vertical,
          //     child: Container(
          //       color: AppServices.hexaCodeToColor(AppColors.bgColor),
          //       child: Container(
          //         // margin: const EdgeInsets.all(10.0),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisSize: MainAxisSize.min,
          //           children: <Widget>[
          //             PaddingScaffold(
          //               pTop: 17,
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: Row(
          //                 children: [
          //                   Image.asset('images/symbols/riel_symbol.png', width: 13.52, height: 22),
          //                   MyText(
          //                     left: 8,
          //                     textAlign: TextAlign.left,
          //                     text: "${product.price} /Kg",
          //                     fontSize: 25,
          //                     fontWeight: FontWeight.bold,
          //                     color: AppColors.primary,
          //                   ),
          //                   Expanded(child: Container()),
          //                   SvgPicture.asset('images/icons/heart.svg', width: 25, height: 23, color: AppServices.hexaCodeToColor(AppColors.secondary),)
          //                 ],
          //               )
          //             ),

          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: Container(
          //                 width: MediaQuery.of(context).size.width / 2,
          //                 child: Text(
          //                   product.name,
          //                   style: TextStyle(
          //                     fontSize: 25,
          //                     fontWeight: FontWeight.w700,
          //                   ),
          //                 ),
          //               ),
          //             ),

          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: Row(
          //                 children: [
          //                   Padding(
          //                     padding: EdgeInsets.only(right: 7),
          //                     child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.only(right: 7),
          //                     child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.only(right: 7),
          //                     child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.only(right: 7),
          //                     child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.only(right: 7),
          //                     child: SvgPicture.asset('images/icons/rate_star.svg', height: 13, width: 13)
          //                   ),
          //                   MyText(
          //                     textAlign: TextAlign.left,
          //                     text: "(13) Sold",
          //                     fontSize: 12,
          //                     color: "#000000",
          //                   )
          //                 ],
          //               ),
          //             ),

          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: Row(
          //                 children: [
          //                   MyCard(
          //                     hexaColor: "#FFFFFF",
          //                     mRight: 10,
          //                     boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
          //                     width: 40, height: 40,
          //                     child: MyText(
          //                       fontSize: 12,
          //                       text: "1Kg"
          //                     ), 
          //                   ),
          //                   MyCard(
          //                     hexaColor: "#FFFFFF",
          //                     mRight: 10,
          //                     // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
          //                     width: 40, height: 40,
          //                     child: MyText(
          //                       fontSize: 12,
          //                       text: "3Kg"
          //                     ), 
          //                   ),
          //                   MyCard(
          //                     hexaColor: "#FFFFFF",
          //                     mRight: 10,
          //                     // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
          //                     width: 40, height: 40,
          //                     child: MyText(
          //                       fontSize: 12,
          //                       text: "5Kg"
          //                     ), 
          //                   ),
          //                   MyCard(
          //                     hexaColor: "#FFFFFF",
          //                     mRight: 10,
          //                     // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
          //                     width: 40, height: 40,
          //                     child: MyText(
          //                       fontSize: 12,
          //                       text: "10Kg"
          //                     ), 
          //                   ),
          //                   Expanded(
          //                     child: Container()
          //                   ),

          //                   Consumer<ProductsProvider>(
          //                     builder: (context, value, child) => BtnQty(
          //                       '${product.orderQty ?? '0'}',
          //                       () {
          //                         value.addOrderQty(product);
          //                       },
          //                       () {
          //                         value.minusOrderQty(product);
          //                       },
          //                     ),
          //                   ),
          //                   // Text(
          //                   //   product.price.toString() +
          //                   //       '៛ /' +
          //                   //       AppLocalizeService.of(context)
          //                   //           .translate('kilogram'),
          //                   //   style: TextStyle(
          //                   //     fontWeight: FontWeight.w700,
          //                   //     fontSize: 23,
          //                   //     color: kDefaultColor,
          //                   //   ),
          //                   // )
          //                 ],
          //               )
          //             ),
          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: Divider(
          //                 height: 1,
          //                 color: AppServices.hexaCodeToColor(AppColors.txtBtn),
          //               )
          //             ),

          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: Row(
          //                 children: [
          //                   MyText(
          //                     pRight: 10,
          //                     text: 'About',
          //                     fontWeight: FontWeight.w600,
          //                     color: AppColors.primary,
          //                     fontSize: 20,
          //                   ),

          //                   MyText(text: "/", pRight: 10),

          //                   MyText(
          //                     text: 'Review (250)',
          //                     color: "#C4C4C4",
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 20,
          //                   )
          //                 ],
          //               ),
          //             ),

          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: MyText(
          //                 textAlign: TextAlign.left,
          //                 text: product.description,
          //                 fontSize: 16,
          //               )
          //             ),

          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: Divider(
          //                 height: 1,
          //                 color: AppServices.hexaCodeToColor(AppColors.txtBtn),
          //               )
          //             ),
          //             // ChangeNotifierProvider.value(
          //             //   value: product,
          //             //   child: SellerInfo(),
          //             // ),

          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: MyText(
          //                 pRight: 10,
          //                 text: 'Seller',
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 20,
          //               ),
          //             ),

          //             // Seller
          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: GestureDetector(
          //                 child: Row(
          //                   children: [

          //                     //Profile
          //                     MyCard(
          //                       hexaColor: AppColors.secondary,
          //                       mRight: 10,
          //                       // boxBorder: Border.all(width: 2, color: AppServices.hexaCodeToColor(AppColors.primary)),
          //                       width: 45, height: 42,
          //                       align: Alignment.centerLeft,
          //                       child: SvgPicture.asset('images/avatar_user.svg', width: 25, height: 25),
          //                     ),

          //                     // Name & About
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         MyText(
          //                           pRight: 10,
          //                           text: 'Daveat Corn',
          //                           fontWeight: FontWeight.w600,
          //                           fontSize: 16,
          //                         ),

          //                         MyText(
          //                           text: 'Phnom penh (Steng mean chey)',
          //                           fontSize: 12,
          //                         )
          //                       ],
          //                     )
          //                   ],
          //                 ),
          //               )
          //             ),

          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: Divider(
          //                 height: 1,
          //                 color: AppServices.hexaCodeToColor(AppColors.txtBtn),
          //               )
          //             ),

          //             PaddingScaffold(
          //               pLeft: padding, pRight: padding,
          //               pBottom: padding,
          //               child: MyText(
          //                 text: AppLocalizeService.of(context).translate('related_product'),
          //                 fontSize: 23,
          //                 fontWeight: FontWeight.w900,
          //               )
          //             ),

          //             // Related
          //             SizedBox(
          //               height: 200,
          //               child: RelatedProduct()
          //             )
          //             // Expanded(
          //             //   child: Row(
          //             //     mainAxisSize: MainAxisSize.min,
          //             //     children: 
          //             //     [
          //             //     ]
          //             //   )
          //             //   // PaddingScaffold(
          //             //   //   pLeft: padding, pRight: padding,
          //             //   //   pBottom: padding,
          //             //   //   child: 
          //             //   // )
          //             // ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ), 


          Positioned(
            left: 25, top: 25,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset('images/icons/back.svg', width: 15, height: 25),
            )
          ),

          Positioned(
            right: 25, top: 25,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset('images/icons/cart.svg', width: 25, height: 25),
            )
          ),
        ],
      )
    );
  }
}
