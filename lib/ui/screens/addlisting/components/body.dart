import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:selendra_marketplace_app/core/providers/add_product_provider.dart';
import 'package:selendra_marketplace_app/ui/screens/addlisting/fill_seller/fill_sellter.dart';
import 'image_list.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  AddProduct _addProduct = AddProduct();

  String _error = 'No Error Dectected';

  // BuildContext context;
  void routeA() async {
    String resultOfC = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriesListScreen(category))
    );
    onChanged(resultOfC);
    setState(() {
      _addProduct.categories.text = resultOfC;
    });
  }

  void onChanged(String value) {
    if (
      _addProduct.images.length != 0 &&
      _addProduct.name.text.isNotEmpty &&
      _addProduct.categories.text.isNotEmpty &&
      _addProduct.price.text.isNotEmpty
    ) enableButton(true);
    else if (_addProduct.enable1) enableButton(false);
  }

  void enableButton(bool enable) {
    setState(() {
      _addProduct.enable1 = enable;
    });
  }

  void toSeller() async {
    var response = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FillSeller(addProduct: _addProduct))
    );
    if (response) Navigator.pop(context);
    // setState(() {
    //   if (_addProduct.formKeyDetail.currentState.validate() &&
    //       _addProduct.formKeySeller.currentState.validate()) {
    //     _addProduct.formKeyDetail.currentState.save();
    //     _addProduct.formKeySeller.currentState.save();

    //     // print(_title);
    //     // print(_price);
    //     // print(_description);
    //     // print(_contactName);
    //     // print(_phoneNumber);
    //     // print(_categories);
    //     // print(_address);

    //     /*products.add(Product(
    //         id: 20,i
    //         title: _title,
    //         price: int.parse(_price),
    //         description: _description,
    //         image: "images/new-house.jpg",
    //         color: Color(0xFF3D82AE)));*/

    //     Navigator.pop(context);
    //     return true;
    //   }
    // });
    // return false;
  }

  Widget buildGridView(Function loadAssets) {
    // return GestureDetector(
    //   onTap: loadAssets,
    //   child: Container(
    //     height: 200,
    //     width: double.infinity,
    //     margin: EdgeInsets.only(top: 10.0),
    //     decoration: BoxDecoration(
    //       border: Border.all(color: kDefaultColor),
    //       borderRadius: BorderRadius.circular(kDefaultRadius),
    //     ),
    //     child: images.length > 0 ? ImageList(images) : SvgPicture.asset('images/icons/add_image.svg')
    //   ),
    // );
    Provider.of<AddProductProvider>(context);
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: kDefaultColor),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(_addProduct.images.length, (index) {
          Asset asset = _addProduct.images[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageList(_addProduct.images),
                  ),
                );
              },
              child: Stack(
                children: [
                  AssetThumb(
                    quality: 100,
                    asset: asset,
                    width: 300,
                    height: 300,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _addProduct.images.remove(asset);
                        });
                      },
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: false,
        selectedAssets: _addProduct.images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: '#${kDefaultColor.value.toRadixString(16)}',
          actionBarTitle: "Selendra App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _addProduct.images = resultList;
      _error = error;
      print(_error);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // final data = Provider.of<UserProvider>(context);

    // _addProduct.sellerName.text = data.
    Provider.of<AddProductProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              _postDetail(),
              SizedBox(
                height: 40,
              ),
              // Consumer<ProductsProvider>(
              //   builder: (context, value, child) => Container(
              //     // margin: EdgeInsets.only(right: 16, left: 16),
              //     child: ReuseButton.getItem(
              //         AppLocalizeService.of(context).translate('Next'), () {
              //       toSeller();
              //       if (toSeller()) {
              //         value.addItem(_addProduct.title.text, double.parse(_addProduct.price.text), _addProduct.description.text,
              //             _addProduct.contactName.text, _addProduct.phoneNumber.text);
              //       }
              //     }, context),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(right: 18, left: 18),
                child: ReuseButton.getItem(
                  'Next', //AppLocalizeService.of(context).translate('Next'),
                  // !_addProduct.enable1
                  // ? null
                  // : 
                  () {
                    toSeller();
                    // if (toSeller()) {
                    //   value.addItem(_addProduct.title.text, double.parse(_addProduct.price.text), _addProduct.description.text,
                    //       _addProduct.contactName.text, _addProduct.phoneNumber.text);
                    // }
                  },
                  context
                ),
              ),
              // _sellerDetail(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _postDetail() {
    return Form(
      key: _addProduct.formKeyDetail,
      child: Container(
        margin: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: <Widget>[
            
            SizedBox(
              height: 10,
            ),
            ReuseButton.getItem(
              AppLocalizeService.of(context).translate('pick_image'),
              loadAssets,
              context
            ),
            
            _addProduct.images.isNotEmpty
            ? buildGridView(loadAssets)
            : Container(
              height: 0,
            ),

            SizedBox(
              height: 10,
            ),
            _productNameField(),

            SizedBox(
              height: 10,
            ),
            _myCategories(),

            SizedBox(
              height: 10,
            ),
            _descriptionField(),

            SizedBox(
              height: 10,
            ),
            _priceField(),
          ],
        ),
      ),
    );
  }

  Widget _sellerDetail() {
    return Form(
      key: _addProduct.formKeySeller,
      child: Container(
        margin: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            _productNameField(),
            SizedBox(
              height: 10,
            ),
            _phoneNumberField(),
            SizedBox(
              height: 10,
            ),
            _streetAddress(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _district(),
                SizedBox(
                  width: 10.0,
                ),
                _cityName(),
              ],
            ),
            //_pickLocation(),
          ],
        ),
      ),
    );
  }

  Widget _priceField() {
    return ReuseTextField(
      controller: _addProduct.price,
      labelText: AppLocalizeService.of(context).translate('price'),
      maxLine: 1,
      inputType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('price_is_empty')
          : null,
      onChanged: onChanged,
      // onSaved: (newValue) => _addProduct.price. = newValue,
    );
  }

  Widget _descriptionField() {
    return ReuseTextField(
      controller: _addProduct.description,
      maxLine: 3,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      labelText: AppLocalizeService.of(context).translate('description'),
      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('description_is_empty')
          : null,
      // onSaved: (value) => _description = value,
    );
  }

  Widget _myCategories() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: kDefaultColor, width: 1),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: ListTile(
        title: _addProduct.categories.text.isEmpty
        ? Text(
          AppLocalizeService.of(context).translate('categories'),
        )
        : Text(_addProduct.categories.text),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: kDefaultColor,
        ),
        onTap: () {
          routeA();
        },
      ),
    );
  }

  Widget _productNameField() {
    return ReuseTextField(
      controller: _addProduct.sellerName,
      labelText: AppLocalizeService.of(context).translate('product_name'),
      maxLine: 1,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty
      ? AppLocalizeService.of(context).translate('contact_name_is_empty')
      : null,
      onChanged: onChanged
      // onSaved: (value) => _contactName = value,
    );
  }

  Widget _phoneNumberField() {
    return ReuseTextField(
        controller: _addProduct.sellerNumber,
        labelText: AppLocalizeService.of(context).translate('phone_hint'),
        maxLine: 1,
        textInputAction: TextInputAction.done,
        validator: (value) => value.isEmpty
            ? AppLocalizeService.of(context).translate('phone_number_is_empty')
            : null,
        onChanged: onChanged
        // onSaved: (value) => _phoneNumber = value,
        );
  }

  Widget _streetAddress() {
    return ReuseTextField(
      controller: _addProduct.address,
      labelText: AppLocalizeService.of(context).translate('street_address'),
      // onSaved: (newValue) => _address = newValue,
    );
  }

  Widget _district() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      child: ReuseTextField(
        textInputAction: TextInputAction.done,
        labelText: AppLocalizeService.of(context).translate('district'),
      ),
    );
  }

  Widget _cityName() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      child: ReuseTextField(
        labelText: AppLocalizeService.of(context).translate('city_province'),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
