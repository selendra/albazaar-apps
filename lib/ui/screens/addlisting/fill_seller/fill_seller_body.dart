import 'package:selendra_marketplace_app/all_export.dart';

class FillSellerBody extends StatelessWidget{

  final AddProduct addProduct;

  FillSellerBody({
    this.addProduct
  });

  Widget build(BuildContext context) {
    return Form(
      // key: _formKeySeller,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 18, right: 18),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ReuseTextField(
                  controller: addProduct.price,
                  labelText: AppLocalizeService.of(context).translate('price'),
                  maxLine: 1,
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (value) => value.isEmpty
                      ? AppLocalizeService.of(context).translate('price_is_empty')
                      : null,
                  // onSaved: (newValue) => addProduct.price.text = newValue,
                ),
                SizedBox(
                  height: 10,
                ),
                ReuseTextField(
                  controller: addProduct.phoneNumber,
                    labelText: AppLocalizeService.of(context).translate('phone_hint'),
                    maxLine: 1,
                    textInputAction: TextInputAction.done,
                    validator: (value) => value.isEmpty
                        ? AppLocalizeService.of(context).translate('phone_number_is_empty')
                        : null,
                    // onSaved: (value) => _phoneNumber = value,
                  ),
                SizedBox(
                  height: 10,
                ),
                ReuseTextField(
                  controller: addProduct.address,
                  labelText: AppLocalizeService.of(context).translate('street_address'),
                  // onSaved: (newValue) => _address = newValue,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: ReuseTextField(
                        controller: addProduct.district,
                        labelText: AppLocalizeService.of(context).translate('district'),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: ReuseTextField(
                        controller: addProduct.city,
                        labelText: AppLocalizeService.of(context).translate('city_province'),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],
                ),
                //_pickLocation(),
                SizedBox(
                  height: 40,
                ),
                Consumer<ProductsProvider>(
                  builder: (context, value, child) => Container(
                    child: ReuseButton.getItem(
                        AppLocalizeService.of(context).translate('submit'), () {
                      // checkValidate();
                      // if (checkValidate()) {
                      //   value.addItem(_title, double.parse(_price), _description,
                      //       _contactName, _phoneNumber);
                      // }
                    }, context),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        child: Text(AppLocalizeService.of(context).translate('policy')),
                        onPressed: () {
                          print('Rule & Policy');
                        },
                      ),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  
}

