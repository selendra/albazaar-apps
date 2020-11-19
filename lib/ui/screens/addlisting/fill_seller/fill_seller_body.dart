import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/providers/add_product_provider.dart';

class FillSellerBody extends StatelessWidget{

  final AddProduct addProduct;
  final Function onChanged;

  FillSellerBody({
    this.addProduct,
    this.onChanged
  });
  
  Widget build(BuildContext context) {
    var data = Provider.of<AddProductProvider>(context);
    print(data.addProduct.shippingServics);
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
              controller: addProduct.sellerName,
              labelText: AppLocalizeService.of(context).translate('name'),
              maxLine: 1,
              textInputAction: TextInputAction.next,
              inputType: TextInputType.text,
              validator: (value) => value.isEmpty
              ? AppLocalizeService.of(context).translate('contact_name_is_empty')
              : null,
              onChanged: onChanged,
              // onSaved: (value) => _phoneNumber = value,
            ),

            SizedBox(
              height: 10,
            ),
            ReuseTextField(
              controller: addProduct.sellerNumber,
              labelText: AppLocalizeService.of(context).translate('phone_hint'),
              maxLine: 1,
              textInputAction: TextInputAction.done,
              inputType: TextInputType.number,
              validator: (value) => value.isEmpty
              ? AppLocalizeService.of(context).translate('phone_number_is_empty')
              : null,
              onChanged: onChanged,
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
                    labelText: AppLocalizeService.of(context).translate('city_province'),
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
                  AppLocalizeService.of(context).translate('submit'), 
                  !addProduct.enable2 ? null : () {
                    value.addItem(addProduct);
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
      ),
    );
  }
}

