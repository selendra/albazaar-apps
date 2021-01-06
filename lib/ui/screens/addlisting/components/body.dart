import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:async';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:html' as html;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AddProductProvider _addProductProvider;

  //String _error = 'No Error Dectected';
  ScrollController _scrollController = ScrollController();

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

  //void ddOnChanged(String value) {}

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
    try {
      html.File result =
          await ImagePickerWeb.getImage(outputType: ImageType.file);

      if (result != null) {
        _convertBlobUint8(result);
        _addProductProvider.addProduct.imageFile.add(result);
      }
    } catch (e) {
      e.toString();
      //print(e);
    }
    await getImage();
    if (!mounted) return;
  }

  Future<void> _convertBlobUint8(html.Blob result) async {
    await UserProvider().getHtmlFileContent(result).then((value) {
      setState(() {
        _addProductProvider.addProduct.imageBlob.add(value);
      });
    });
  }

  Future<void> getImage() async {
    // await UserProvider().upLoadImage(_image)
    await UserProvider()
        .upLoadImage(_addProductProvider.addProduct.imageFile[0])
        .then((value) {
      _addProductProvider.addProduct.imageUrl = json.decode(value)['uri'];
    });

    onChanged(_addProductProvider.addProduct.imageUrl, _addProductProvider);

    for (int i = 1; i < _addProductProvider.addProduct.imageFile.length; i++) {
      await UserProvider()
          .upLoadImage(_addProductProvider.addProduct.imageFile[i])
          .then((value) {
        _addProductProvider.addProduct.imageUrlList
            .add(json.decode(value)['uri']);
      });
    }
  }

  Future<void> loadAsset() async {
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
      //_error = error;
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
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Responsive(
        mobile: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
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
        desktop: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            child: ReuseDesktop(
              widget: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      _postDetail(),
                      SizedBox(height: 40),
                      Container(
                        width: Responsive.isDesktop(context)
                            ? MediaQuery.of(context).size.width * 0.2
                            : MediaQuery.of(context).size.width,
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
      ),
    );
  }

  Widget buildGridView(Function loadAssets) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        //border: Border.all(color: kDefaultColor),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: _addProductProvider.addProduct.imageBlob.length,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              GridTile(
                  child: Image.memory(
                _addProductProvider.addProduct.imageBlob[index],
                fit: BoxFit.cover,
              )),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _addProductProvider.addProduct.imageBlob.remove(
                          _addProductProvider.addProduct.imageBlob[index]);
                      if (index == 0) {
                        _addProductProvider.addProduct.imageUrl =
                            _addProductProvider.addProduct.imageUrlList[1];
                      }
                    });
                  },
                  child: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        },

        // children: List.generate(_imageBlob.length, (index) {
        //   // Asset asset = _addProductProvider.addProduct.images[index];
        //   return
        //   // return Stack(
        //   //   children: [
        //   //     GestureDetector(
        //   //       onTap: () {},
        //   //       child: ClipRRect(
        //   //         borderRadius: BorderRadius.only(
        //   //           topLeft: Radius.circular(5),
        //   //           topRight: Radius.circular(5),
        //   //           bottomLeft: Radius.circular(5),
        //   //           bottomRight: Radius.circular(5),
        //   //         ),
        //   //         child: Container(
        //   //           decoration: BoxDecoration(
        //   //             boxShadow: [
        //   //               BoxShadow(
        //   //                 color: Colors.white,
        //   //                 spreadRadius: 5.0,
        //   //                 blurRadius: 5.0,
        //   //               )
        //   //             ],
        //   //           ),
        //   //           child: Image.memory(
        //   //             _imageBlob[index],
        //   //             fit: BoxFit.cover,
        //   //             filterQuality: FilterQuality.high,
        //   //           ),
        //   //         ),
        //   //       ),
        //   //     ),
        //   //     Positioned(
        //   //       top: 0,
        //   //       right: 0,
        //   //       child: InkWell(
        //   //         onTap: () {
        //   //           setState(() {
        //   //             _imageBlob.remove(_imageBlob[index]);
        //   //           });
        //   //         },
        //   //         child: Icon(
        //   //           Icons.remove_circle,
        //   //           color: Colors.red,
        //   //         ),
        //   //       ),
        //   //     ),
        //   //   ],
        //   //);
        //   // Asset asset = _addProductProvider.addProduct.images[index];
        //   // return Container(
        //   //   color: kDefaultColor,
        //   //   height: 50,
        //   //   width: 50,
        //   //   margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        //   //   child: GestureDetector(
        //   //     onTap: () {
        //   //       // Navigator.push(
        //   //       //   context,
        //   //       //   MaterialPageRoute(
        //   //       //     builder: (context) =>
        //   //       //         ImageList(_addProductProvider.addProduct.images),
        //   //       //   ),
        //   //       // );
        //   //     },
        //   //     child: Stack(
        //   //       children: [
        //   //         Image.memory(
        //   //           _imageBlob[index],
        //   //           fit: BoxFit.cover,
        //   //         ),
        //   //         // AssetThumb(
        //   //         //   quality: 100,
        //   //         //   asset: asset,
        //   //         //   width: 300,
        //   //         //   height: 300,
        //   //         // ),

        //   //       ],
        //   //     ),
        //   //   ),
        //   // );
        // }),
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

            _addProductProvider.addProduct.imageBlob.isNotEmpty
                //_addProductProvider.addProduct.images.isNotEmpty
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
