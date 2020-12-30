import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'dart:async';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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

  void onChanged(String value, AddProductProvider addProductProvider) {
    if (addProductProvider.addProduct.imageUrl.isNotEmpty &&
        addProductProvider.addProduct.productName.text.isNotEmpty &&
        addProductProvider.addProduct.hintCategory != "Category" &&
        addProductProvider.addProduct.hintWeight != "Weight" &&
        addProductProvider.addProduct.price.text.isNotEmpty &&
        addProductProvider.addProduct.hintPaymentOpt != "Payment Method" &&
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

  void toSeller(AddProductProvider provider, UserProvider user) async {
    var response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FillSeller(
                  addProduct: provider.addProduct,
                  userProvider: user,
                )));

    if (response != null) Navigator.pop(context, response);
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
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _error = error;
    });

    await getImageUrl();
  }

  Future<void> imageAssetToFile() async {
    // Fetch Image From Asset
    _addProductProvider.addProduct.fileImagesList.clear();
    for (Asset asset in _addProductProvider.addProduct.images) {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
      _addProductProvider.addProduct.fileImagesList.add(File(filePath));
    }
  }

  // Use After Display Image
  Future<void> getImageUrl() async {
    // Upload Image To Get Url Image
    await _postRequest
        .upLoadImage(_addProductProvider.addProduct.fileImagesList[0], "upload")
        .then((value) {
      _addProductProvider.addProduct.imageUrl = json.decode(value)['uri'];
    });

    // Validate After Get Url Thumnail
    onChanged(_addProductProvider.addProduct.imageUrl, _addProductProvider);

    // // Loop Upload File Images Per Each
    for (int i = 1;
        i < _addProductProvider.addProduct.fileImagesList.length;
        i++) {
      await _postRequest
          .upLoadImage(
              _addProductProvider.addProduct.fileImagesList[i], "upload")
          .then((value) {
        _addProductProvider.addProduct.imageUrlList
            .add(json.decode(value)['uri']);
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
    UserProvider user = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Responsive(
        mobile: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                _postDetail(),
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.only(right: 18, left: 18),
                  padding: EdgeInsets.only(bottom: 20),
                  child: ReuseButton.getItem(
                      AppLocalizeService.of(context).translate('next'),
                      !_addProductProvider.addProduct.enable1
                          ? null
                          : () {
                              toSeller(_addProductProvider, user);
                            },
                      context),
                ),
                // _sellerDetail(),
              ],
            ),
          ),
        ),
        desktop: Container(
          child: ReuseDesktop(
            widget: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    _postDetail(),
                    SizedBox(height: 40),
                    Container(
                      margin: EdgeInsets.only(right: 18, left: 18),
                      padding: EdgeInsets.only(bottom: 20),
                      child: ReuseButton.getItem(
                          AppLocalizeService.of(context).translate('next'),
                          !_addProductProvider.addProduct.enable1
                              ? null
                              : () {
                                  toSeller(_addProductProvider, user);
                                },
                          context),
                    ),
                    // _sellerDetail(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGridView(Function loadAssets) {
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
                    hint: _addProductProvider.addProduct.hintCategory,
                    data: _addProductProvider.addProduct.categoriesList,
                    keyPair: 'category_name',
                    onChanged: (String value) {
                      setState(() {
                        for (int i = 0;
                            i <
                                _addProductProvider
                                    .addProduct.categoriesList.length;
                            i++) {
                          if (value ==
                              _addProductProvider.addProduct.categoriesList[i]
                                  ['category_name']) {
                            _addProductProvider.addProduct.category =
                                _addProductProvider.addProduct.categoriesList[i]
                                    ['id'];
                            break;
                          }
                        }
                        _addProductProvider.addProduct.hintCategory = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyDropDown(
                    hint: _addProductProvider.addProduct.hintWeight,
                    data: _addProductProvider.addProduct.weightList,
                    keyPair: 'weight_option',
                    onChanged: (String value) {
                      setState(() {
                        for (int i = 0;
                            i <
                                _addProductProvider
                                    .addProduct.weightList.length;
                            i++) {
                          if (value ==
                              _addProductProvider.addProduct.weightList[i]
                                  ['weight_option']) {
                            _addProductProvider.addProduct.weight =
                                _addProductProvider.addProduct.weightList[i]
                                    ['id'];
                            break;
                          }
                        }
                        _addProductProvider.addProduct.hintWeight = value;
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
              hint: _addProductProvider.addProduct.hintPaymentOpt,
              data: _addProductProvider.addProduct.paymentOptsList,
              keyPair: 'options_name',
              onChanged: (String value) {
                setState(() {
                  for (int i = 0;
                      i < _addProductProvider.addProduct.paymentOptsList.length;
                      i++) {
                    if (value ==
                        _addProductProvider.addProduct.paymentOptsList[i]
                            ['options_name']) {
                      _addProductProvider.addProduct.paymentOpt =
                          _addProductProvider.addProduct.paymentOptsList[i]
                              ['id'];
                      break;
                    }
                  }
                  _addProductProvider.addProduct.hintPaymentOpt = value;
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
