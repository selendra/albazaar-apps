import 'package:albazaar_app/all_export.dart';

class EditProductBody extends StatelessWidget {

  final OwnerProduct productOwner;
  final Function validate;
  final Function onChanged;
  final Function onChangeImage;
  final Function onChangeDropDown;
  final Function removeImageByIndex;
  final Function onSubmit;
  final Function submitProduct;

  EditProductBody({
    this.productOwner,
    this.validate,
    this.onChanged,
    this.onChangeImage,
    this.onChangeDropDown,
    this.removeImageByIndex,
    this.onSubmit,
    this.submitProduct
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        MyCard(
          mTop: 70, mBottom: 16,
          height: 150 ,
          pRight: 16, pLeft: 16,
          mRight: 16, mLeft: 16,
          // image: productOwner.productModel.image != null ? DecorationImage(
          //   fit: BoxFit.cover,
          //   image: FileImage(
          //     File(productOwner.productModel.image[0])
          //   )
          // ) : null,
          alignChild: Alignment.center,
          child: productOwner.productModel.image.length != 0 ? GridView.count(
            crossAxisCount: 3,
            children: List.generate(productOwner.productModel.image.length, (index) {
              return MyCard(
                height: 100, width: 100,
                align: Alignment.center,
                child: Stack(
                  children: [

                    CachedNetworkImage(
                      imageUrl: productOwner.productModel.image[index],
                      placeholder: (context, value){
                        return Image.asset(AppConfig.imagePath+'loading.gif');
                      },
                    ),
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
          ) : MyPadding(pTop: 16, pBottom: 16, child: SvgPicture.asset(AppConfig.imagePath+'gallery.svg')),
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

        Form(
          key: productOwner.productModel.formKey,
          child: Column(
            children: [
              MyPadding(
                pLeft: pd12, pRight: pd12,
                pBottom: pd12,
                child: MyInputField(
                  labelText: "Product Name",
                  controller: productOwner.productModel.productName, 
                  focusNode: productOwner.productModel.productNameNode, 
                  validateField: (String value){
                    validate(value, label: "productName");
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
                          controller: productOwner.productModel.price, 
                          focusNode: productOwner.productModel.priceNode,
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(TextField.noMaxLength),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          inputType: TextInputType.number,
                          validateField: (String value){
                            validate(value, label: "price");
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
                            MyText(text: productOwner.productModel.currency, pRight: 15,),

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
                        controller: productOwner.productModel.location, 
                        focusNode: productOwner.productModel.locationNode, 
                        validateField: (String value){
                          validate(value, label: "location");
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
                pBottom: pd35,
                pLeft: 0, pRight: 0,
                child: Row(
                  children: [

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
                            MyText(text: productOwner.productModel.categoryDropDown, pRight: 15,),

                            SvgPicture.asset('assets/icons/dropdown.svg', width: 18.52, height: 10, color: AppServices.hexaCodeToColor(AppColors.primary))
                          ],
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
                            MyText(text: productOwner.productModel.scale, pRight: 15,),

                            SvgPicture.asset('assets/icons/dropdown.svg', width: 18.52, height: 10, color: AppServices.hexaCodeToColor(AppColors.primary))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              MyInputField(
                height: 159.0,
                pLeft: pd12, pRight: pd12,
                labelText: "Description",
                controller: productOwner.productModel.description, 
                focusNode: productOwner.productModel.descriptionNode, 
                maxLines: 5,
                validateField: (String value){
                  validate(value, label: "description");
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
          action: () async {
            print(productOwner.productModel.categoryDropDown);
            await submitProduct(OwnerProduct.fromEdit(productOwner));
          },
        )
      ],
    );
  }
}