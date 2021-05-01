import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';

class Checkout extends StatefulWidget {
  final String action;
  Checkout({this.action});
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  TextEditingController _address = TextEditingController();

  // String _address = 'Shipping Information';

  // setVal(String val) {
  //   setState(() {
  //     _address = val;
  //   });
  // }

  void validate(context) async {
    print(_address.text);
    if (_address.text.isEmpty) {
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: ,
      //   duration: Duration(milliseconds: 3000),
      // ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: MyText(text: 'You need to fill in your address.', color: AppColors.white, textAlign: TextAlign.left,))
      );
    } else {
      Components.dialogLoading(context: context);
      try {
        if (widget.action == 'buy_now') {
          final buyNow = Provider.of<CartProvider>(context, listen: false).isBuyNow;
          if (buyNow != null) {
            Provider.of<ProductsProvider>(context, listen: false).addOrder(
              buyNow.id,
              buyNow.qty.toString(),
              _address.text,
            );
          }
        } else {
          final cartProduct = Provider.of<CartProvider>(context, listen: false).items;
          for (int i = 0; i < cartProduct.length; i++) {
            Provider.of<ProductsProvider>(context, listen: false).addOrder(
              cartProduct.values.toList()[i].id,
              cartProduct.values.toList()[i].qty.toString(),
              _address.text,
            );
          }
        }
        Provider.of<ProductsProvider>(context, listen: false).fetchListingProduct();
      } catch (e) {
        
      } 
      finally {
        Navigator.pop(context);
        await ReuseAlertDialog().customDialog(context, 'Your order has been placed successfully!', () {
          Provider.of<CartProvider>(navigationKey.currentState.overlay.context, listen: false).clear();
          Navigator.pop(context);
        });

        Navigator.pop(navigationKey.currentState.overlay.context);
      }
    }
  }
  
  Future<void> triggerLocation() async {

    Components.dialogLoading(context: context);

    await Permission.location.request().then((value) {
      print(value);
    });
    
    if (await Permission.location.status.isGranted){
      await Geolocator().isLocationServiceEnabled().then((value) async {
        if (value){
          await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((currentLocate) async {
            _address.text = await AppServices.getLocation(currentLocate.latitude, currentLocate.longitude);
          });
          setState((){});
        } else {
          await Components.dialog(context, Text("Please enable your location service"), Text("Message"));
        }
      });
      
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${Permission.location.status}"))
      );
    }

    // Close Loadding
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final _lang = AppLocalizeService.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: ReuseSimpleAppBar.getItem(AppLocalizeService.of(context).translate('check_out'), context),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // TotalPriceCard(
              //   action: widget.action,
              // ),
              // //ShippingInformation(),
              // SizedBox(
              //   height: 20,
              // ),
              ProductDisplay(
                action: widget.action,
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    MyText(
                      textAlign: TextAlign.left,
                      text: "Shipping Address",
                      color: AppColors.primary,
                      bottom: 12,
                    ),

                    Consumer<UserProvider>(
                      builder: (context, value, child) => Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: MyInputField(
                                labelText: "Your address",
                                controller: _address,
                                focusNode: FocusScopeNode(),
                                validateField: (String values){
                                },
                                onChanged: (String values){
                                  print(values);
                                  value.mUser.address = values;
                                },
                                onSubmit: (String value){

                                },
                              )
                            ),

                            GestureDetector(
                              onTap: () async {
                                await triggerLocation();
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 12, right: 6),
                                child: SvgPicture.asset("${AppConfig.iconPath}check_in.svg", width: 30, height: 30, color: AppServices.hexaCodeToColor(AppColors.primary))
                              ),
                            )
                          ],
                        )
                        // Form(
                        //   key: _formKey,
                        //   child: ReuseTextField(
                        //     hintText: 'Address',
                        //     initialValue: value.mUser.address == null
                        //         ? ''
                        //         : value.mUser.address,
                        //     validator: (value) => value.isEmpty
                        //         ? 'Address cannot be empty'
                        //         : null,
                        //     onSaved: (newValue) => _address = newValue,
                        //   ),
                        // ),
                      ),
                    )
                  ],
                )
              ),
              
              SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ReuseButton.getItem(
                  _lang.translate('confirm'), 
                  () {
                    validate(context);
                  }, 
                  context,
                  width: 200
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
