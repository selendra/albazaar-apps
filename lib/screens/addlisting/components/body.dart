import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/constants.dart';
import 'package:selendra_marketplace_app/models/categories.dart';
import 'package:selendra_marketplace_app/screens/category/categories_list.dart';
import 'package:selendra_marketplace_app/models/products.dart';
import 'package:selendra_marketplace_app/reuse_widget/reuse_button.dart';
import 'package:image_picker/image_picker.dart';

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
  String _categories = "Categories";

  Future<void> choiceDialog() async {
    switch (await showDialog<Options>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Choose an option'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Camera'),
                onPressed: () {
                  Navigator.pop(context, Options.Camera);
                },
              ),
              SimpleDialogOption(
                child: Text('Gallery'),
                onPressed: () {
                  Navigator.pop(context, Options.Gallery);
                },
              )
            ],
          );
        })) {
      case Options.Camera:
        cameraImage();
        break;
      case Options.Gallery:
        galleryImage();
        break;
    }
  }

  void routeA() async {
    String resultOfC = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoriesListScreen(category)));
    print(resultOfC);
    setState(() {
      _categories = resultOfC;
    });
  }

  Future galleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _myImage = File(pickedFile.path);
    });
  }
  Future cameraImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _myImage = File(pickedFile.path);
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
        products.add(Product(
            id: 20,
            title: _title,
            price: int.parse(_price),
            description: _description,
            image: "images/new-house.jpg",
            color: Color(0xFF3D82AE)));
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
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text(
                  'POST DETAIL',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _image(),
            SizedBox(
              height: 20,
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
              height: 20,
            ),
            _nameField(),
            SizedBox(
              height: 10,
            ),
            _phoneNumberField(),
            SizedBox(
              height: 10,
            ),
            _pickLocation(),
            SizedBox(
              height: 20,
            ),
            ReuseButton.getItem('Submit', () {
              checkValidate();
            }, context),
            _readPolicy(),
          ],
        ),
      ),
    );
  }

  Widget _priceField() {
    return Container(
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Price',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
        ),
        validator: (value) => value.isEmpty ? "Empty Price" : null,
        onSaved: (value) => _price = value,
      ),
    );
  }

  Widget _descriptionField() {
    return Container(
      child: TextFormField(
        maxLines: 4,
        keyboardType: TextInputType.text,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Description',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
        ),
        validator: (value) => value.isEmpty ? "Empty Description" : null,
        onSaved: (value) => _description = value,
      ),
    );
  }

  Widget _myCategories() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: kDefualtColor, width: 1),
        borderRadius: BorderRadius.circular(18.0),
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
    return Container(
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Title',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
        ),
        validator: (value) => value.isEmpty ? "Empty Title" : null,
        onSaved: (value) => _title = value,
      ),
    );
  }

  Widget _image() {
    return InkWell(
      onTap: () {
        choiceDialog();
      },
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
            color: kDefualtColor,
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
    return Container(
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Contact Name',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
        ),
        validator: (value) => value.isEmpty ? "Empty Contact Name" : null,
        onSaved: (value) => _contactName = value,
      ),
    );
  }

  Widget _phoneNumberField() {
    return Container(
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autocorrect: true,
        decoration: InputDecoration(
          labelText: 'Phone Number',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDefualtColor),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
        ),
        validator: (value) => value.isEmpty ? "Empty Phone Number" : null,
        onSaved: (value) => _phoneNumber = value,
      ),
    );
  }

  Widget _pickLocation() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
            color: kDefualtColor,
            width: 1,
          ),
        ),
        child: Center(child: Text('Pick Location')),
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
              print('rule & policy');
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
