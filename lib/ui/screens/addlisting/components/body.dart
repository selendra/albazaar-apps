import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'image_list.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKeyDetail = GlobalKey<FormState>();
  final _formKeySeller = GlobalKey<FormState>();

  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  // BuildContext context;

  String _title;
  String _price;
  String _description;
  String _contactName;
  String _phoneNumber;
  String _address;
  String _categories;

  void routeA() async {
    String resultOfC = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoriesListScreen(category)));
    print(resultOfC);
    setState(() {
      _categories = resultOfC ?? "Categories";
    });
  }

  bool checkValidate() {
    setState(() {
      if (_formKeyDetail.currentState.validate() &&
          _formKeySeller.currentState.validate()) {
        _formKeyDetail.currentState.save();
        _formKeySeller.currentState.save();

        print(_title);
        print(_price);
        print(_description);
        print(_contactName);
        print(_phoneNumber);
        print(_categories);
        print(_address);

        /*products.add(Product(
            id: 20,i
            title: _title,
            price: int.parse(_price),
            description: _description,
            image: "images/new-house.jpg",
            color: Color(0xFF3D82AE)));*/
        Navigator.pop(context);
        return true;
      }
    });
    return false;
  }

  Widget buildGridView() {
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: kDefaultColor),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageList(images),
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
                          images.remove(asset);
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
        selectedAssets: images,
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
      images = resultList;
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
              _sellerDetail(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _postDetail() {
    return Form(
      key: _formKeyDetail,
      child: Container(
        margin: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            ReuseButton.getItem('Pick Images', loadAssets, context),
            images.isNotEmpty
                ? buildGridView()
                : Container(
                    height: 0,
                  ),
            SizedBox(
              height: 10,
            ),
            _titleField(),
            SizedBox(
              height: 10,
            ),
            _descriptionField(),
            SizedBox(
              height: 10,
            ),
            _myCategories(),
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
      key: _formKeySeller,
      child: Container(
        margin: EdgeInsets.only(left: 18, right: 18),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            _nameField(),
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
            SizedBox(
              height: 40,
            ),
            Consumer<ProductsProvider>(
              builder: (context, value, child) => Container(
                child: ReuseButton.getItem(
                    AppLocalizeService.of(context).translate('submit'), () {
                  checkValidate();
                  if (checkValidate()) {
                    value.addItem(_title, double.parse(_price), _description,
                        _contactName, _phoneNumber);
                  }
                  /**/
                }, context),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _readPolicy(),
          ],
        ),
      ),
    );
  }

  Widget _priceField() {
    return ReuseTextField(
      labelText: AppLocalizeService.of(context).translate('price'),
      maxLine: 1,
      inputType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('price_is_empty')
          : null,
      onSaved: (newValue) => _price = newValue,
    );
  }

  Widget _descriptionField() {
    return ReuseTextField(
      maxLine: 3,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      labelText: AppLocalizeService.of(context).translate('description'),
      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('description_is_empty')
          : null,
      onSaved: (value) => _description = value,
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
        title: _categories == null
            ? Text(
                AppLocalizeService.of(context).translate('categories'),
              )
            : Text(_categories),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          routeA();
        },
      ),
    );
  }

  Widget _titleField() {
    return ReuseTextField(
      labelText: AppLocalizeService.of(context).translate('title'),
      maxLine: 1,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('title_is_empty')
          : null,
      onSaved: (value) => _title = value,
    );
  }

  Widget _nameField() {
    return ReuseTextField(
      labelText: AppLocalizeService.of(context).translate('name'),
      maxLine: 1,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('contact_name_is_empty')
          : null,
      onSaved: (value) => _contactName = value,
    );
  }

  Widget _phoneNumberField() {
    return ReuseTextField(
      labelText: AppLocalizeService.of(context).translate('phone_hint'),
      maxLine: 1,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('phone_number_is_empty')
          : null,
      onSaved: (value) => _phoneNumber = value,
    );
  }

  Widget _streetAddress() {
    return ReuseTextField(
      labelText: AppLocalizeService.of(context).translate('street_address'),
      onSaved: (newValue) => _address = newValue,
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

  Widget _readPolicy() {
    return Container(
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
    );
  }
}
