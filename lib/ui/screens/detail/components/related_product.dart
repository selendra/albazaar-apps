import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:albazaar_app/core/components/card_c.dart';

class RelatedProduct extends StatelessWidget {

  final List<Product> listProducts = List<Product>();

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

  RelatedProduct(){
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
    print(listProducts.length);
    final productsData = Provider.of<ProductsProvider>(context);
    final _products = productsData.items;
    return ListView.builder(
      // physics: Axis.horizontal,
      scrollDirection: Axis.horizontal,
      itemCount: listProducts.length,//_products.length,
      shrinkWrap: true,
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   crossAxisSpacing: 10,
      //   childAspectRatio: 0.75,
      // ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            if (index == 0) ReuseItemCard(
              product: listProducts[index],
              mLeft: 19,
            ),

            if (index > 0)  ReuseItemCard(
              product: listProducts[index],
              mLeft: 0,
            ),

            Positioned(
              left: (index == 0) ? 19 : 0 , top: 0,
              child: MyCard(
                bTopRight: 0,
                bBottomLeft: 0,
                hexaColor: AppColors.secondary,
                width: 50, height: 45,
                child: Center(
                  child: SvgPicture.asset('assets/icons/cart.svg', color: Colors.white, height: 24, width: 24),
                ),
              ),
            )
          ],
        );
      }
      // ChangeNotifierProvider.value(
      //   value: listProducts[index],
      //   child: ReuseItemCard(
      //     product: listProducts[index],
      //   ),
      // ),
    );
    // Column(
    //   children: [
    //     Flexible(
    //       child: 
    //     ),
    //     // Container(
    //     //   height: 140,
    //     //   child: ListView.builder(
    //     //     shrinkWrap: true,
    //     //     physics: ClampingScrollPhysics(),
    //     //     scrollDirection: Axis.horizontal,
    //     //     itemCount: _products.length,
    //     //     itemBuilder: (context, index) {
    //     //       return ChangeNotifierProvider.value(
    //     //         value: _products[index],
    //     //         child: ReuseItemCard(),
    //     //       );
    //     //     },
    //     //   ),
    //     // ),
    //   ],
    // );
  }
}
