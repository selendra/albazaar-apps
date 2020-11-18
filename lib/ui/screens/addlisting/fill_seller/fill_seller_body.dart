import 'package:selendra_marketplace_app/all_export.dart';

class FillSellerBody extends StatelessWidget {
  final AddProduct addProduct;
  final Function onChanged;

  FillSellerBody({this.addProduct, this.onChanged});

  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Form(
      // key: _formKeySeller,
      child: Container(
        margin: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            ReuseTextField(
              controller: addProduct.sellerNumber,
              labelText: _lang.translate('phone_hint'),
              maxLine: 1,
              textInputAction: TextInputAction.done,
              inputType: TextInputType.number,
              validator: (value) => value.isEmpty
                  ? _lang.translate('phone_number_is_empty')
                  : null,
              onChanged: onChanged,
              // onSaved: (value) => _phoneNumber = value,
            ),

            SizedBox(
              height: 10,
            ),
            ReuseTextField(
              controller: addProduct.address,
              labelText: _lang.translate('street_address'),
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
                    labelText: _lang.translate('district'),
                    onChanged: onChanged,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  child: ReuseTextField(
                    controller: addProduct.city,
                    labelText: _lang.translate('city_province'),
                    textInputAction: TextInputAction.done,
                    onChanged: onChanged,
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
                    _lang.translate('submit'),
                    !addProduct.enable2
                        ? null
                        : () {
                            value.addItem(
                                addProduct.title.text,
                                double.parse(addProduct.price.text),
                                addProduct.description.text,
                                addProduct.sellerName.text,
                                addProduct.sellerNumber.text);
                            Navigator.pop(context, true);
                            // checkValidate();
                            // if (checkValidate()) {
                            //   value.addItem(_title, double.parse(_price), _description,
                            //       _contactName, _phoneNumber);
                            // }
                          },
                    context),
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
                    child: Text(_lang.translate('policy')),
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
      ),
    );
  }
}
