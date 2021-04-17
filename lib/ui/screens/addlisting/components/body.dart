import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'image_list.dart';

class Body extends StatelessWidget {

  AddProductProvider addProductProvider;

  final ProductModel product;
  final Function toSeller;
  final Function removeAsset;
  final Function loadAssets;
  final Function onChanged;
  final Function onSubmit;
  final Function onChangeCategory;
  final Function onChangeWeight;
  final Function onChangedPaymentOption;

  final Function validateField;
  final Function onChangeDropDown;

  Body({
    this.addProductProvider,
    this.product,
    this.toSeller,
    this.removeAsset,
    this.loadAssets,
    this.onChanged,
    this.onChangeCategory,
    this.onChangeWeight,
    this.onChangedPaymentOption,

    this.validateField,
    this.onChangeDropDown,
    this.onSubmit
  });

  @override
  Widget build(BuildContext context) {
    addProductProvider = Provider.of<AddProductProvider>(context);
    UserProvider user = Provider.of<UserProvider>(context);
    // Provider.of<AddProductProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
      children: [

        MyCard(
          mTop: 70, mBottom: 16,
          width: 145, height: 122,
          pBottom: 16, pRight: 16, pTop: 16, pLeft: 16,
          image: product.images != null ? DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
              File(product.images[0])
            )
          ) : null,
          child: product.images == null ? SvgPicture.asset('assets/avatar_user.svg', color: AppServices.hexaCodeToColor(AppColors.primary)) : Container(),
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
            // onChangeImage();
          }, 
        ),

        Form(
          key: product.formKey,
          child: Column(
            children: [
              MyPadding(
                pLeft: pd12, pRight: pd12,
                pBottom: pd12,
                child: MyInputField(
                  labelText: "Product Name",
                  controller: product.productName, 
                  focusNode: product.productNameNode, 
                  validateField: (String value){
                    // validate(value, label: "productName");
                  }, 
                  onChanged: onChanged, 
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
                          controller: product.price, 
                          focusNode: product.priceNode,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(TextField.noMaxLength),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          inputType: TextInputType.number,
                          validateField: (String value){
                            validateField(value, label: "price");
                          }, 
                          onChanged: onChanged, 
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
                            MyText(text: product.currency, pRight: 15,),

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
                        controller: product.location, 
                        focusNode: product.locationNode, 
                        validateField: (String value){
                          validateField(value, label: "location");
                        }, 
                        onChanged: onChanged, 
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

                    Expanded(
                      flex: 2,
                      child: MyPadding(
                        pLeft: pd12, 
                        pRight: 0,
                        child: MyInputField(
                          labelText: "Category",
                          controller: product.category,
                          focusNode: product.categoryNode, 
                          validateField: (String value){
                            validateField(value, label: "weight");
                          }, 
                          onChanged: onChanged, 
                          onSubmit: onSubmit
                        ),
                      ),
                    ),

                    // DropDown Scale
                    GestureDetector(
                      onTapDown: (TapDownDetails details) async {
                        dynamic result = await Navigator.push(context, popUpRoute(MyDropDownCustom.scaleDdBtn(context: context, x: details.globalPosition.dx, y: details.globalPosition.dy), sigmaX: 0.0, sigmaY: 0.0));
                        if (result != null){
                          onChangeDropDown('scale', result);
                        }
                      },
                      child: MyCard(
                        mLeft: pd12, mRight: 0,
                        height: heightInput,
                        pRight: pd12+3, pLeft: pd12+3,
                        alignChild: Alignment.center,
                        child: Row(
                          children: [
                            MyText(text: product.scale, pRight: 15,),

                            SvgPicture.asset('assets/icons/dropdown.svg', width: 18.52, height: 10, color: AppServices.hexaCodeToColor(AppColors.primary))
                          ],
                        ),
                      ),
                    ),

                    // DropDown Category
                    GestureDetector(
                      onTapDown: (TapDownDetails details) async {
                        dynamic result = await Navigator.push(context, popUpRoute(MyDropDownCustom.categoryDdBtn(context: context, x: details.globalPosition.dx, y: details.globalPosition.dy), sigmaX: 0.0, sigmaY: 0.0));
                        if (result != null){
                          onChangeDropDown('category', result);
                        }
                      },
                      child: MyCard(
                        mLeft: pd12, mRight: pd12,
                        height: heightInput,
                        pRight: pd12+3, pLeft: pd12+3,
                        alignChild: Alignment.center,
                        child: Row(
                          children: [
                            MyText(text: product.categoryDropDown, pRight: 15,),

                            SvgPicture.asset('assets/icons/dropdown.svg', width: 18.52, height: 10, color: AppServices.hexaCodeToColor(AppColors.primary))
                          ],
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
                controller: product.description, 
                focusNode: product.descriptionNode, 
                validateField: (String value){
                  validateField(value, label: "description");
                }, 
                onChanged: onChanged, 
                onSubmit: onSubmit
              ),
              
            ],
          ),
        ),

        MyFlatButton(
          edgeMargin: EdgeInsets.only(left: 110, right: 110, bottom: 31),
          child: MyText(text: "Save edit", color: AppColors.white, pTop: 19, pBottom: 19,),
          action: product.enable == false ? null : (){
            print(product.productName.text);
            print(product.price.text);
            print(product.currency);
            print(product.category.text);
            print(product.description.text);
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
