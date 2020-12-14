import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/screens/addlisting/fill_seller/fill_seller_body.dart';

class FillSeller extends StatefulWidget {
  final AddProduct addProduct;

  final UserProvider userProvider;

  FillSeller({this.addProduct, this.userProvider});

  @override
  _FillSellerState createState() => _FillSellerState();
}

class _FillSellerState extends State<FillSeller> {
  @override
  initState() {
    super.initState();
    fillUser();
    // widget.addProduct.imageUrlList.add("https://selendra.s3-ap-southeast-1.amazonaws.com/c455f0b4-e1f3-4c3d-a623-ba49c5df00ad");
    // widget.addProduct.imageUrlList.add("https://selendra.s3-ap-southeast-1.amazonaws.com/34459a86-e3c7-4c2e-9d96-6d3938aeb81b");
    // widget.addProduct.imageUrlList.add("https://selendra.s3-ap-southeast-1.amazonaws.com/34459a86-e3c7-4c2e-9d96-6d3938aeb81b");
    // widget.addProduct.productId = "e21d01cb-456e-4cea-a926-c1b7de107ada";
    // print(widget.addProduct.imageUrlList[0]);
  }

  void fillUser(){
    widget.addProduct.sellerName.text = widget.userProvider.mUser.firstName ?? '';
    widget.addProduct.sellerName.text += " ${widget.userProvider.mUser.midName}" ?? '';
    widget.addProduct.sellerName.text += " ${widget.userProvider.mUser.lastName}" ?? '';
    widget.addProduct.sellerNumber.text = "${widget.userProvider.mUser.phonenumber}" ?? '';
  }

  @override
  dispose() {
    widget.addProduct.clearSellerField();
    super.dispose();
  }

  // bool checkValidate() {
  //   // setState(() {
  //   // if (_formKeyDetail.currentState.validate() &&
  //   //     _formKeySeller.currentState.validate()) {
  //   //   _formKeyDetail.currentState.save();
  //   //   _formKeySeller.currentState.save();

  //   // print(_title);
  //   // print(_price);
  //   // print(_description);
  //   // print(_contactName);
  //   // print(_phoneNumber);
  //   // print(_categories);
  //   // print(_address);

  //   /*products.add(Product(
  //           id: 20,i
  //           title: _title,
  //           price: int.parse(_price),
  //           description: _description,
  //           image: "images/new-house.jpg",
  //           color: Color(0xFF3D82AE)));*/

  //   //   Navigator.pop(context);
  //   //   return true;
  //   // }
  //   // });
  //   // return false;
  // }

  void onChanged(String value) {

    if (widget.addProduct.sellerName.text.isNotEmpty &&
        widget.addProduct.sellerNumber.text.isNotEmpty &&
        widget.addProduct.address.text.isNotEmpty &&
        widget.addProduct.district.text.isNotEmpty &&
        widget.addProduct.city.text.isNotEmpty &&
        widget.addProduct.hintShipping != "Shipping Services")
      enableButton(true);
    else if (widget.addProduct.enable2) enableButton(false);
  }

  void enableButton(bool enable) {
    setState(() {
      widget.addProduct.enable2 = enable;
    });
  }

  void onChangedDD(String value) {
    setState(() {
      for(int i = 0; i < widget.addProduct.shippingList.length; i++){
        if (value == widget.addProduct.shippingList[i]['shipping_service']){
          widget.addProduct.shipping = widget.addProduct.shippingList[i]['id'];
          break;
        }
      }
      widget.addProduct.hintShipping = value;
      onChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(AppLocalizeService.of(context).translate('seller_information'), context),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: FillSellerBody(
              addProduct: widget.addProduct,
              onChangedDD: onChangedDD,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
