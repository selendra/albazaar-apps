import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'image_list.dart';

class Body extends StatelessWidget {

  final AddProductProvider addProductProvider;
  final ProductModel productModel;
  final Function toSeller;
  final Function removeAsset; // Will remove later
  final Function removeImageByIndex;
  final Function loadAssets;
  final Function onChangeImage;

  final Function onChanged;
  final Function onSubmit;
  final Function onChangeCategory;
  final Function onChangeWeight;
  final Function onChangedPaymentOption;

  final Function validateField;
  final Function onChangeDropDown;
  final Function submitProduct;

  Body({
    this.addProductProvider,
    this.productModel,
    this.toSeller,
    this.removeAsset,
    this.removeImageByIndex,
    this.loadAssets,
    this.onChangeImage,
    this.onChanged,
    this.onChangeCategory,
    this.onChangeWeight,
    this.onChangedPaymentOption,

    this.validateField,
    this.onChangeDropDown,
    this.onSubmit,
    this.submitProduct
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
      children: [
        
        MyCard(
          mTop: 70, mBottom: 16,
          height: 150 ,
          pRight: 16, pLeft: 16,
          mRight: 16, mLeft: 16,
          alignChild: Alignment.center,
          child: productModel.images.length != 0 ? GridView.count(
            crossAxisCount: 3,
            children: List.generate(productModel.images.length, (index) {
              return MyCard(
                height: 100, width: 100,
                align: Alignment.center,
                child: Stack(
                  children: [
                    if (productModel.images[index].contains('https')) CachedNetworkImage(
                      imageUrl: productModel.images[index],
                      placeholder: (context, value){
                        return Image.asset(AppConfig.imagePath+'loading.gif');
                      },
                    )
                    else Image.file(File(productModel.images[index])),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          removeImageByIndex(index);
                        },
                        child: Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                      )
                    )
                  ],
                )//Image.asset(AppConfig.imagePath+'loading.gif'),
              );
            })
          ) : MyPadding(pTop: 16, pBottom: 16, child: SvgPicture.asset(AppConfig.imagePath+'gallery.svg',)),
          // productOwner.productModel.image == null ? SvgPicture.asset('assets/avatar_user.svg', color: AppServices.hexaCodeToColor(AppColors.primary)) : Container(),
        ),
        
        MyFlatButton(
          edgeMargin: EdgeInsets.only(bottom: pd35-5),
          isTransparent: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.primary)),
              MyText(text: "Change image", color: AppColors.primary, fontSize: 16, left: 10,),
            ],
          ), 
          action: (){
            onChangeImage();
          }, 
        ),

        // All Input
        Form(
          key: productModel.formKey,
          child: Column(
            children: [
              MyPadding(
                pLeft: pd12, pRight: pd12,
                pBottom: pd12,
                child: MyInputField(
                  labelText: "Product Name",
                  controller: productModel.productName, 
                  focusNode: productModel.productNameNode, 
                  validateField: (String value){
                    // validate(value, label: "productName");
                  }, 
                  onChanged: (String value){
                    onChanged(value, addProductProvider);
                  }, 
                  onSubmit: onSubmit
                ),
              ),

              MyPadding(
                pBottom: pd12,
                pLeft: 0, pRight: 0,
                child: Row(
                  children: [

                    Expanded(
                      flex: 2,
                      child: MyPadding(
                        pLeft: pd12, 
                        pRight: 0,
                        child: MyInputField(
                          labelText: "Price",
                          controller: productModel.price, 
                          focusNode: productModel.priceNode,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(TextField.noMaxLength),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          inputType: TextInputType.number,
                          validateField: (String value){
                            validateField(value, label: "price");
                          }, 
                          onChanged: (String value){
                            onChanged(value, addProductProvider);
                          }, 
                          onSubmit: onSubmit
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTapDown: (TapDownDetails details) async {
                        dynamic result = await Navigator.push(context, popUpRoute(MyDropDownCustom.currencyDdBtn(context: context, x: details.globalPosition.dx, y: details.globalPosition.dy), sigmaX: 0.0, sigmaY: 0.0));
                        if (result != null){
                          onChangeDropDown('currency', result);
                        }
                      },
                      child: MyCard(
                        mLeft: pd12, mRight: pd12,
                        height: heightInput,
                        pRight: pd12+3, pLeft: pd12+3,
                        alignChild: Alignment.center,
                        child: Row(
                          children: [
                            MyText(text: productModel.currency, pRight: 15,),

                            SvgPicture.asset('assets/icons/dropdown.svg', width: 18.52, height: 10, color: AppServices.hexaCodeToColor(AppColors.primary),)
                          ],
                        ),
                      ),
                      )
                  ],
                ),
              ),

              MyPadding(
                pBottom: pd12,
                pLeft: 0, pRight: 0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: MyInputField(
                        pLeft: pd12,
                        labelText: "Search Location",
                        controller: productModel.location, 
                        focusNode: productModel.locationNode, 
                        validateField: (String value){
                          validateField(value, label: "location");
                        }, 
                        onChanged: (String value){
                          onChanged(value, addProductProvider);
                        }, 
                        onSubmit: onSubmit
                      )
                    ),

                    Flexible(
                      child: MyFlatButton(
                        isTransparent: true,
                        edgePadding: EdgeInsets.only(right: pd12, left: pd12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/check_in.svg', width: 20, height: 20, color: AppServices.hexaCodeToColor(AppColors.primary),),
                            MyText(text: "location", pLeft: 5, color: AppColors.primary)
                          ],
                        ), 
                        action: (){

                        }, 
                      )
                    )
                  ],
                ),
              ),

              MyPadding(
                pBottom: pd12,
                pLeft: 0, pRight: 0,
                child: Row(
                  children: [

                    // Expanded(
                    //   flex: 2,
                    //   child: MyPadding(
                    //     pLeft: pd12, 
                    //     pRight: 0,
                    //     child: MyInputField(
                    //       labelText: "Scale",
                    //       controller: productModel.scale,
                    //       focusNode: productModel.scale., 
                    //       validateField: (String value){
                    //         validateField(value, label: "weight");
                    //       }, 
                    //       onChanged: onChanged, 
                    //       onSubmit: onSubmit
                    //     ),
                    //   ),
                    // ),

                    // DropDown Category
                    Expanded(
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) async {
                          dynamic result = await Navigator.push(context, popUpRoute(MyDropDownCustom.categoryDdBtn(context: context, x: details.globalPosition.dx, y: details.globalPosition.dy), sigmaX: 0.0, sigmaY: 0.0));
                          if (result != null){
                            onChangeDropDown('category', result);
                          }
                        },
                        child: MyCard(
                          mLeft: pd12, mRight: pd12/2,
                          height: heightInput,
                          pRight: pd12+3, pLeft: pd12+3,
                          alignChild: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(text: productModel.categoryDropDown, pRight: 15,)
                              ),

                              SvgPicture.asset('assets/icons/dropdown.svg', width: 18.52, height: 10, color: AppServices.hexaCodeToColor(AppColors.primary))
                            ],
                          ),
                        ),
                      ),
                    ),

                    // DropDown Scale
                    Expanded(
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) async {
                          dynamic result = await Navigator.push(context, popUpRoute(MyDropDownCustom.scaleDdBtn(context: context, x: details.globalPosition.dx, y: details.globalPosition.dy), sigmaX: 0.0, sigmaY: 0.0));
                          if (result != null){
                            onChangeDropDown('scale', result);
                          }
                        },
                        child: MyCard(
                          mLeft: pd12/2, mRight: 12,
                          height: heightInput,
                          pRight: pd12+3, pLeft: pd12+3,
                          alignChild: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(text: productModel.scale, pRight: 15,)
                              ),

                              SvgPicture.asset('assets/icons/dropdown.svg', width: 18.52, height: 10, color: AppServices.hexaCodeToColor(AppColors.primary))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              
              // Shipping and Payment method
              MyPadding(
                pBottom: pd12,
                pLeft: 0, pRight: 0,
                child: Row(
                  children: [

                    // DropDown Shipping
                    Expanded(
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) async {
                          dynamic result = await Navigator.push(context, popUpRoute(MyDropDownCustom.shippingDdBtn(context: context, x: details.globalPosition.dx, y: details.globalPosition.dy), sigmaX: 0.0, sigmaY: 0.0));
                          if (result != null){
                            onChangeDropDown('shipping', result);
                          }
                        },
                        child: MyCard(
                          mLeft: pd12, mRight: pd12/2,
                          height: heightInput,
                          pRight: pd12+3, pLeft: pd12+3,
                          alignChild: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(text: productModel.shippingOpt, pRight: 15,)
                              ),

                              SvgPicture.asset('assets/icons/dropdown.svg', width: 18.52, height: 10, color: AppServices.hexaCodeToColor(AppColors.primary))
                            ],
                          ),
                        ),
                      ),
                    ),

                    // DropDown Payment Method
                    Expanded(
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) async {
                          dynamic result = await Navigator.push(context, popUpRoute(MyDropDownCustom.paymentDdBtn(context: context, x: details.globalPosition.dx, y: details.globalPosition.dy), sigmaX: 0.0, sigmaY: 0.0));
                          if (result != null){
                            onChangeDropDown('payment', result);
                          }
                        },
                        child: MyCard(
                          mLeft: pd12 /2, mRight: 12,
                          height: heightInput,
                          pRight: pd12+3, pLeft: pd12+3,
                          alignChild: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(text: productModel.paymentOpt, pRight: 15,),
                              ),
                              SvgPicture.asset('assets/icons/dropdown.svg', width: 18.52, height: 10, color: AppServices.hexaCodeToColor(AppColors.primary))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              MyInputField(
                height: 159.0,
                pLeft: pd12, pRight: pd12,
                labelText: "Description",
                controller: productModel.description, 
                focusNode: productModel.descriptionNode, 
                validateField: (String value){
                  validateField(value, label: "description");
                }, 
                onChanged: (String value){
                  onChanged(value, addProductProvider);
                }, 
                onSubmit: onSubmit
              ),
              
            ],
          ),
        ),

        MyFlatButton(
          edgeMargin: EdgeInsets.only(left: 110, right: 110, bottom: 31),
          child: MyText(text: "Save edit", color: AppColors.white, pTop: 19, pBottom: 19,),
          action: //productModel.enable == false ? null : 
          () async {
            productModel.productName.text = "Meat";
            productModel.price.text = "15000";
            productModel.shippingOptId = "b8fd8a60-242c-405d-8a62-1ae2880094a6";
            productModel.paymentOptId = "375f4c4b-945d-437e-9a2d-4a0af398f925";
            productModel.scaleId = "b8fd8a60-242c-405d-8a62-1ae2880094a7";
            productModel.categoryId = "4e984edb-abd2-4691-990f-a6b1413cf472";
            productModel.description.text = "New meat";
            productModel.tmpImagesUrl.add("https://selendra.s3-ap-southeast-1.amazonaws.com/d4c94173-61b8-467b-9544-8d077770ecaf");
            await submitProduct(ProductModel().fromAddProduct(productModel));
          },
        )
      ],
    )
      // Container(
      //   child: SingleChildScrollView(
      //     scrollDirection: Axis.vertical,
      //     child: Column(
      //       children: <Widget>[
      //         _postDetail(context, loadAssets, onChangeCategory, onChangeWeight, onChangedPaymentOption),
      //         SizedBox(
      //           height: 40,
      //         ),

      //         Container(
      //           margin: EdgeInsets.only(right: 18, left: 18),
      //           padding: EdgeInsets.only(bottom: 20),
      //           child: ReuseButton.getItem(
      //               AppLocalizeService.of(context).translate('next'),
      //               !addProductProvider.addProduct.enable1
      //                   ? null
      //                   : () {
      //                       toSeller(addProductProvider, user);
      //                       // if (toSeller()) {
      //                       //   value.addItem(addProductProvider.title.text, double.parse(addProductProvider.price.text), addProductProvider.description.text,
      //                       //       addProductProvider.contactName.text, addProductProvider.phoneNumber.text);
      //                       // }
      //                     },
      //               context),
      //         ),
      //         // _sellerDetail(),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget buildGridView(Function loadAssets, BuildContext context) {
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
        children: List.generate(addProductProvider.addProduct.images.length, (index) {
          Asset asset = addProductProvider.addProduct.images[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ImageList(addProductProvider.addProduct.images),
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

  Widget _postDetail(BuildContext context, Function loadAssets, Function onChangeCategory, Function onChangeWeight, Function onChangePaymentOption) {
    return Form(
      key: addProductProvider.addProduct.formKeyDetail,
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

            addProductProvider.addProduct.images.isNotEmpty
                ? buildGridView(loadAssets, context)
                : Container(
                    height: 0,
                  ),

            SizedBox(
              height: 10,
            ),
            _productNameField(context),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: MyDropDown(
                    hint: addProductProvider.addProduct.hintCategory,
                    data: addProductProvider.addProduct.categoriesList,
                    keyPair: 'category_name',
                    onChanged: (String value) {
                      onChangeCategory(value);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyDropDown(
                    hint: addProductProvider.addProduct.hintWeight,
                    data: addProductProvider.addProduct.weightList,
                    keyPair: 'weight_option',
                    onChanged: (String value) {
                      onChangeWeight(value);
                    },
                  ),
                )
              ],
            ),
            // _myCategories(),

            SizedBox(
              height: 10,
            ),
            _priceField(context),

            SizedBox(
              height: 10,
            ),
            MyDropDown(
              hint: addProductProvider.addProduct.hintPaymentOpt,
              data: addProductProvider.addProduct.paymentOptsList,
              keyPair: 'options_name',
              onChanged: (String value) {
                onChangePaymentOption(value);
              },
            ),

            SizedBox(
              height: 10,
            ),
            _descriptionField(context),
          ],
        ),
      ),
    );
  }

  Widget _productNameField(BuildContext context) {
    return ReuseTextField(
        controller: addProductProvider.addProduct.productName,
        labelText: AppLocalizeService.of(context).translate('product_name'),
        maxLine: 1,
        textInputAction: TextInputAction.done,
        validator: (value) => value.isEmpty
            ? AppLocalizeService.of(context).translate('contact_name_is_empty')
            : null,
        onChanged: (String value) {
          onChanged(value, addProductProvider);
        }
        // onSaved: (value) => _contactName = value,
        );
  }

  Widget _priceField(BuildContext context) {
    return ReuseTextField(
      controller: addProductProvider.addProduct.price,
      labelText: AppLocalizeService.of(context).translate('price'),
      maxLine: 1,
      inputType: TextInputType.number,
      textInputAction: TextInputAction.done,
      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('price_is_empty')
          : null,
      onChanged: (String value) {
        onChanged(value, addProductProvider);
      },
      // onSaved: (newValue) => addProductProvider.price. = newValue,
    );
  }

  Widget _descriptionField(BuildContext context) {
    return ReuseTextField(
      controller: addProductProvider.addProduct.description,
      maxLine: 3,
      inputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      labelText: AppLocalizeService.of(context).translate('description'),

      validator: (value) => value.isEmpty
          ? AppLocalizeService.of(context).translate('description_is_empty')
          : null,
      onChanged: (String value) {
        onChanged(value, addProductProvider);
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
//             items: addProductProvider.addProduct.categoriesList
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
//         //   title: addProductProvider.categories.text.isEmpty
//         //   ? Text(
//         //     AppLocalizeService.of(context).translate('categories'),
//         //   )
//         //   : Text(addProductProvider.categories.text),
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
//         controller: addProductProvider.addProduct.sellerNumber,
//         labelText: AppLocalizeService.of(context).translate('phone_hint'),
//         maxLine: 1,
//         textInputAction: TextInputAction.done,
//         validator: (value) => value.isEmpty
//             ? AppLocalizeService.of(context).translate('phone_number_is_empty')
//             : null,
//         onChanged: (String value) {
//           onChanged(value, addProductProvider);
//         }
//         // onSaved: (value) => _phoneNumber = value,
//         );
//   }

//   Widget _streetAddress() {
//     return ReuseTextField(
//       controller: addProductProvider.addProduct.address,
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
