import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/providers/products_provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

enum Options { Camera, Gallery }

class _BodyState extends State<Body> {
  final _formKeyDetail = GlobalKey<FormState>();
  final _formKeySeller = GlobalKey<FormState>();

  File _myImage;
  final picker = ImagePicker();

  String _title;
  String _price;
  String _description;
  String _contactName;
  String _phoneNumber;
  String _address;
  String _categories = "Categories";

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

  void checkValidate() {
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            _postDetail(),
            _sellerDetail(),
          ],
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
              height: 20,
            ),
            _image(),
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
                _cityName(),
              ],
            ),
            //_pickLocation(),
            SizedBox(
              height: 40,
            ),
            Consumer<ProductsProvider>(
              builder: (context, value, child) => Container(
                child: ReuseButton.getItem('SUBMIT', () {
                  checkValidate();
                  value.addItem(_title, double.parse(_price), _description,
                      _contactName, _phoneNumber);
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
      labelText: 'Price',
      maxLine: 1,
      inputType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty ? "Empty Price" : null,
      onSaved: (newValue) => _price = newValue,
    );
  }

  Widget _descriptionField() {
    return ReuseTextField(
      maxLine: 3,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      labelText: 'Description',
      validator: (value) => value.isEmpty ? "Empty Description" : null,
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
        title: Text(_categories),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          routeA();
        },
      ),
    );
  }

  Widget _titleField() {
    return ReuseTextField(
      labelText: 'Title',
      maxLine: 1,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty ? "Empty Title" : null,
      onSaved: (value) => _title = value,
    );
  }

  Widget _image() {
    return InkWell(
      onTap: () {
        ReuseChoiceDialog().choiceDialog(context);
      },
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultRadius),
          border: Border.all(
            color: kDefaultColor,
            width: 1,
          ),
        ),
        child: _myImage == null
            ? Image(
                image: NetworkImage(
                    'https://static.thenounproject.com/png/187803-200.png'),
              )
            : Image.file(_myImage),
      ),
    );
  }

  Widget _nameField() {
    return ReuseTextField(
      labelText: 'Name',
      maxLine: 1,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty ? "Empty Contact Name" : null,
      onSaved: (value) => _contactName = value,
    );
  }

  Widget _phoneNumberField() {
    return ReuseTextField(
      labelText: 'Phone Number',
      maxLine: 1,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty ? "Empty Phone Number" : null,
      onSaved: (value) => _phoneNumber = value,
    );
  }

  Widget _streetAddress() {
    return ReuseTextField(
      labelText: 'Street Address',
      onSaved: (newValue) => _address = newValue,
    );
  }

  Widget _district() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      child: ReuseTextField(
        textInputAction: TextInputAction.done,
        labelText: 'State/District',
      ),
    );
  }

  Widget _cityName() {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      child: ReuseTextField(
        labelText: 'City/Province',
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
            child: Text('Please more about our Rule &Policy'),
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
