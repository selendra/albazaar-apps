import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'dart:async';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:selendra_marketplace_app/core/providers/add_product_provider.dart';
import 'package:selendra_marketplace_app/ui/component.dart';
// import 'package:selendra_marketplace_app/ui/screens/addlisting/fill_seller/fill_sellter.dart';
import 'image_list.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AddProductProvider _addProductProvider;

  String _error = 'No Error Dectected';

  PostRequest _postRequest = PostRequest();

  // BuildContext context;
  // void routeA() async {
  //   String resultOfC = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => CategoriesListScreen(category)));
  //   setState(() {
  //     // _addProductProvider.categories = resultOfC;
  //   });
  // }

  void onChanged(String value, AddProductProvider addProductProvider) {
    // print(addProductProvider.addProduct.imageUrl);
    // print(addProductProvider.addProduct.productName.text);
    // print(addProductProvider.addProduct.category);
    // print(addProductProvider.addProduct.weight);
    // print(addProductProvider.addProduct.price.text);
    // print(addProductProvider.addProduct.paymentOpt);
    // print(addProductProvider.addProduct.description.text);

    if (addProductProvider.addProduct.imageUrl.isNotEmpty &&
        addProductProvider.addProduct.productName.text.isNotEmpty &&
        addProductProvider.addProduct.category != "Category" &&
        addProductProvider.addProduct.weight != "Weight" &&
        addProductProvider.addProduct.price.text.isNotEmpty &&
        addProductProvider.addProduct.paymentOpt != "Payment Method" &&
        addProductProvider.addProduct.description.text.isNotEmpty)
      enableButton(true);
    else if (_addProductProvider.addProduct.enable1) enableButton(false);
  }

  void ddOnChanged(String value) {}

  void enableButton(bool enable) {
    setState(() {
      _addProductProvider.addProduct.enable1 = enable;
    });
  }

  void toSeller(AddProductProvider provider) async {
    print(provider.addProduct.imageUrl);
    print(provider.addProduct.productName.text);
    print(provider.addProduct.category);
    print(provider.addProduct.weight);
    print(provider.addProduct.price.text);
    print(provider.addProduct.paymentOpt);
    print(provider.addProduct.description.text);
    var response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FillSeller(addProduct: provider.addProduct)));

    if (response != null) Navigator.pop(context);
    // setState(() {
    //   if (_addProductProvider.formKeyDetail.currentState.validate() &&
    //       _addProductProvider.formKeySeller.currentState.validate()) {
    //     _addProductProvider.formKeyDetail.currentState.save();
    //     _addProductProvider.formKeySeller.currentState.save();

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

  Future<void> loadAssets() async {
    String error = 'No Error Dectected';

    try {
      _addProductProvider.addProduct.images = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: false,
        selectedAssets: _addProductProvider.addProduct.images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: '#${kDefaultColor.value.toRadixString(16)}',
          actionBarTitle: "Selendra App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      await imageAssetToFile();
    } on Exception catch (e) {
      print("Error $e");
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _error = error;
      print(_error);
    });

    await getImageUrl();
  }

  Future<void> imageAssetToFile() async {
    // Fetch Image From Asset
    for (Asset asset in _addProductProvider.addProduct.images) {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      _addProductProvider.addProduct.fileImagesList.add(File(filePath));
    }
  }

  // User After Display Image
  Future<void> getImageUrl() async {
    // Upload Image To Get Url Image
    await _postRequest
        .upLoadImage(_addProductProvider.addProduct.fileImagesList[0], "upload")
        .then((value) {
      // _addProductProvider.addProduct
      value.stream.transform(utf8.decoder).listen((data) {
        _addProductProvider.addProduct.imageUrl = json.decode(data)['uri'];
      });
    });

    // Loop Upload File Images Per Each
    for (int i = 1;
        i < _addProductProvider.addProduct.fileImagesList.length;
        i++) {
      await _postRequest
          .upLoadImage(
              _addProductProvider.addProduct.fileImagesList[i], "upload")
          .then((value) {
        value.stream.transform(utf8.decoder).listen((data) {
          _addProductProvider.addProduct.imageUrlList
              .add(json.decode(data)['uri']);
        });
      });
    }
  }

  @override
  void initState() {
    _addProductProvider = AddProductProvider();
    super.initState();
  }

  @override
  dispose() {
    Timer(Duration(milliseconds: 500), () {
      _addProductProvider.addProduct.clearProductField();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _addProductProvider = Provider.of<AddProductProvider>(context);
    // Provider.of<AddProductProvider>(context);
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

              Container(
                margin: EdgeInsets.only(right: 18, left: 18),
                child: ReuseButton.getItem(
                    AppLocalizeService.of(context).translate('next'),
                    !_addProductProvider.addProduct.enable1
                        ? null
                        : () {
                            toSeller(_addProductProvider);
                            // if (toSeller()) {
                            //   value.addItem(_addProductProvider.title.text, double.parse(_addProductProvider.price.text), _addProductProvider.description.text,
                            //       _addProductProvider.contactName.text, _addProductProvider.phoneNumber.text);
                            // }
                          },
                    context),
              ),
              // _sellerDetail(),
            ],
          ),
        ),
      ),
    );
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
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: kDefaultColor),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(_addProductProvider.addProduct.images.length,
            (index) {
          Asset asset = _addProductProvider.addProduct.images[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ImageList(_addProductProvider.addProduct.images),
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
                          _addProductProvider.addProduct.images.remove(asset);
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

  Widget _postDetail() {
    return Form(
      key: _addProductProvider.addProduct.formKeyDetail,
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
                context),

            _addProductProvider.addProduct.images.isNotEmpty
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
            Row(
              children: [
                Expanded(
                  child: MyDropDown(
                    hint: _addProductProvider.addProduct.category,
                    data: _addProductProvider.addProduct.categoriesList,
                    keyPair: 'category_name',
                    onChanged: (String value) {
                      setState(() {
                        print(value);
                        _addProductProvider.addProduct.category = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyDropDown(
                    hint: _addProductProvider.addProduct.weight,
                    data: _addProductProvider.addProduct.weightList,
                    keyPair: 'weight_option',
                    onChanged: (String value) {
                      setState(() {
                        _addProductProvider.addProduct.weight = value;
                      });
                    },
                  ),
                )
              ],
            ),
            // _myCategories(),

            SizedBox(
              height: 10,
            ),
            _priceField(),

            SizedBox(
              height: 10,
            ),
            MyDropDown(
              hint: _addProductProvider.addProduct.paymentOpt,
              data: _addProductProvider.addProduct.paymentOptsList,
              keyPair: 'options_name',
              onChanged: (String value) {
                setState(() {
                  _addProductProvider.addProduct.paymentOpt = value;
                });
              },
            ),

            SizedBox(
              height: 10,
            ),
            _descriptionField(),
          ],
        ),
      ),
    );
  }

  Widget _productNameField() {
    return ReuseTextField(
        controller: _addProductProvider.addProduct.productName,
        labelText: AppLocalizeService.of(context).translate('product_name'),
        maxLine: 1,
        textInputAction: TextInputAction.done,
        validator: (value) => value.isEmpty
            ? AppLocalizeService.of(context).translate('contact_name_is_empty')
            : null,
        onChanged: (String value) {
          onChanged(value, _addProductProvider);
        }
        // onSaved: (value) => _contactName = value,
        );
  }

  Widget _priceField() {
    return ReuseTextField(
      controller: _addProductProvider.addProduct.price,
      labelText: AppLocalizeService.of(context).translate('price'),
      maxLine: 1,
      inputType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('price_is_empty')
          : null,
      onChanged: (String value) {
        onChanged(value, _addProductProvider);
      },
      // onSaved: (newValue) => _addProductProvider.price. = newValue,
    );
  }

  Widget _descriptionField() {
    return ReuseTextField(
      controller: _addProductProvider.addProduct.description,
      maxLine: 3,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      labelText: AppLocalizeService.of(context).translate('description'),

      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('description_is_empty')
          : null,
      onChanged: (String value) {
        onChanged(value, _addProductProvider);
      },
      // onSaved: (value) => _description = value,
    );
  }
}

//   Widget _myCategories() {
//     return Container(
//         height: 60,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           border: Border.all(color: kDefaultColor, width: 1),
//           borderRadius: BorderRadius.circular(kDefaultRadius),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: new DropdownButton<String>(
//             items: _addProductProvider.addProduct.categoriesList
//                 .map((Map<String, dynamic> value) {
//               return new DropdownMenuItem<String>(
//                 value: value['category_name'],
//                 child: new Text(value['category_name']),
//               );
//             }).toList(),
//             onChanged: (_) {},
//           ),
//         )
//         // ListTile(
//         //   title: _addProductProvider.categories.text.isEmpty
//         //   ? Text(
//         //     AppLocalizeService.of(context).translate('categories'),
//         //   )
//         //   : Text(_addProductProvider.categories.text),
//         //   trailing: Icon(
//         //     Icons.arrow_forward_ios,
//         //     color: kDefaultColor,
//         //   ),
//         //   onTap: () {
//         //     routeA();
//         //   },
//         // ),
//         );
//   }

//   Widget _phoneNumberField() {
//     return ReuseTextField(
//         controller: _addProductProvider.addProduct.sellerNumber,
//         labelText: AppLocalizeService.of(context).translate('phone_hint'),
//         maxLine: 1,
//         textInputAction: TextInputAction.done,
//         validator: (value) => value.isEmpty
//             ? AppLocalizeService.of(context).translate('phone_number_is_empty')
//             : null,
//         onChanged: (String value) {
//           onChanged(value, _addProductProvider);
//         }
//         // onSaved: (value) => _phoneNumber = value,
//         );
//   }

//   Widget _streetAddress() {
//     return ReuseTextField(
//       controller: _addProductProvider.addProduct.address,
//       labelText: AppLocalizeService.of(context).translate('street_address'),
//       // onSaved: (newValue) => _address = newValue,
//     );
//   }

//   Widget _district() {
//     return Container(
//       width: MediaQuery.of(context).size.width / 2.3,
//       child: ReuseTextField(
//         textInputAction: TextInputAction.done,
//         labelText: AppLocalizeService.of(context).translate('district'),
//       ),
//     );
//   }

//   Widget _cityName() {
//     return Container(
//       width: MediaQuery.of(context).size.width / 2.3,
//       child: ReuseTextField(
//         labelText: AppLocalizeService.of(context).translate('city_province'),
//         textInputAction: TextInputAction.done,
//       ),
//     );
//   }
// }
