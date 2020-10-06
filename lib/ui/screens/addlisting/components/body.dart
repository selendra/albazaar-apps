import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

enum Options { Camera, Gallery }

class _BodyState extends State<Body> {
  final _formKeyDetail = GlobalKey<FormState>();
  final _formKeySeller = GlobalKey<FormState>();

  //List<File> _myImage = List<File>(8);
  Map<int, File> _myImage = {
    0: null,
    1: null,
    2: null,
    3: null,
    4: null,
    5: null,
    6: null,
  };
  //File _myImage;
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

  Future galleryImage(int index) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _myImage[index] = File(pickedFile.path);
        // _myImage.add(File(pickedFile.path));
      });
      if (_myImage != null) {
        print('File: $_myImage');
        /*ApiPostServices().upLoadImage(_myImage).then((value){
          value.stream.transform(utf8.decoder).listen((data){

          });
        });*/

      }
      Navigator.pop(context);
    } on PlatformException {
      return null;
    }
  }

  Future cameraImage(int index) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      // _myImage.add(File(pickedFile.path));

      setState(() {
        _myImage[index] = File(pickedFile.path);
        //_myImage.add(File(pickedFile.path));
      });
    } on PlatformException {
      return null;
    }
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
            Container(
              height: 100,
              child: ListView.builder(
                itemCount: _myImage.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    final pickedFile =
                        await picker.getImage(source: ImageSource.gallery);
                    _myImage[index] = File(pickedFile.path);
                    setState(() {});
                  },
                  child: GridTile(
                    child: Card(
                      child: Center(
                        child: _myImage[index] == null
                            ? Image.network(
                                'https://static.thenounproject.com/png/187803-200.png')
                            : Image.file(
                                _myImage[index],
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
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
        title: Text(AppLocalizeService.of(context).translate('categories')),
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

  // Widget _image() {
  //   return InkWell(
  //     onTap: () {
  //       ReuseChoiceDialog().choiceDialog(context, galleryImage, cameraImage);
  //     },
  //     child: Container(
  //       height: 70,
  //       width: 70,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(kDefaultRadius),
  //         border: Border.all(
  //           color: kDefaultColor,
  //           width: 1,
  //         ),
  //       ),
  //       child: _myImage == null
  //           ? Image(
  //               image: NetworkImage(
  //                   'https://static.thenounproject.com/png/187803-200.png'),
  //             )
  //           : null,
  //     ),
  //   );
  // }

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
