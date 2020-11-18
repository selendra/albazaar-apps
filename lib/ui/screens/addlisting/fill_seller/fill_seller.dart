import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/addlisting/fill_seller/fill_seller_body.dart';

class FillSeller extends StatefulWidget {
  final AddProduct addProduct;

  FillSeller({this.addProduct});

  @override
  _FillSellerState createState() => _FillSellerState();
}

class _FillSellerState extends State<FillSeller> {
  //bool checkValidate() {
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
  //}

  void onChanged(String value) {
    if (widget.addProduct.sellerNumber.text.isNotEmpty &&
        widget.addProduct.address.text.isNotEmpty &&
        widget.addProduct.district.text.isNotEmpty &&
        widget.addProduct.city.text.isNotEmpty)
      enableButton(true);
    else if (widget.addProduct.enable2) enableButton(false);
  }

  void enableButton(bool enable) {
    setState(() {
      widget.addProduct.enable2 = enable;
    });
  }

  void submit() {
    /*products.add(Product(
    //         id: 20,i
    //         title: _title,
    //         price: int.parse(_price),
    //         description: _description,
    //         image: "images/new-house.jpg",
    //         color: Color(0xFF3D82AE)));*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('seller_information'),
          context),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: FillSellerBody(
              addProduct: widget.addProduct,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
