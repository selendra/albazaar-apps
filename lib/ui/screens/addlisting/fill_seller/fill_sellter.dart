import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/addlisting/fill_seller/fill_seller_body.dart';

class FillSeller extends StatefulWidget {

  final AddProduct addProduct;

  FillSeller({
    this.addProduct
  });

  @override
  _FillSellerState createState() => _FillSellerState();
}

class _FillSellerState extends State<FillSeller> {
  

  bool checkValidate() {
    // setState(() {
      // if (_formKeyDetail.currentState.validate() &&
      //     _formKeySeller.currentState.validate()) {
      //   _formKeyDetail.currentState.save();
      //   _formKeySeller.currentState.save();

        // print(_title);
        // print(_price);
        // print(_description);
        // print(_contactName);
        // print(_phoneNumber);
        // print(_categories);
        // print(_address);

        /*products.add(Product(
            id: 20,i
            title: _title,
            price: int.parse(_price),
            description: _description,
            image: "images/new-house.jpg",
            color: Color(0xFF3D82AE)));*/

      //   Navigator.pop(context);
      //   return true;
      // }
    // });
    // return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Seller information',//AppLocalizeService.of(context).translate(''),
          style: TextStyle(
            color: kDefaultColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kDefaultColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FillSellerBody(addProduct: widget.addProduct,),
    );
  }
}