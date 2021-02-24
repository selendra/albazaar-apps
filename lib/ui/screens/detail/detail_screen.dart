import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/ui/screens/detail/components/body.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'components/bottom_navigation_detail.dart';

class DetailScreen extends StatefulWidget {

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    // final Product productId = ModalRoute.of(context).settings.arguments;
    Product product = Product(
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
    // final loadedProduct = Provider.of<ProductsProvider>(context).findById(productId.id);
    return Scaffold(
      body: Body(),
      bottomNavigationBar: BottomNavigationDetail(product),
    );
  }
}
