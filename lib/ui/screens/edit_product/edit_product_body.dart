import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/text_btn.dart';
import 'package:albazaar_app/ui/screens/listing/components/my_dropdown.dart';

class EditProductBody extends StatelessWidget {

  final ProductModel product;
  final Function validate;
  final Function onChanged;
  final Function onSubmit;

  EditProductBody({
    this.product,
    this.validate,
    this.onChanged,
    this.onSubmit
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        MyCard(
          mTop: 70, mBottom: 16,
          width: 145, height: 122,
          pBottom: 16, pRight: 16, pTop: 16, pLeft: 16,
          child: SvgPicture.asset('images/avatar_user.svg'),
        ),
        
        MyFlatButton(
          edgeMargin: EdgeInsets.only(bottom: pd35-5),
          isTransparent: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('images/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.secondary)),
              MyText(text: "Change image", color: AppColors.secondary, fontSize: 16, left: 10,),
            ],
          ), 
          action: (){

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
                          controller: product.price, 
                          focusNode: product.priceNode, 
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
                        await Navigator.push(context, popUpRoute(MyDropDownCustom.currencyDdBtn(context: context, x: details.globalPosition.dx, y: details.globalPosition.dy), sigmaX: 0.0, sigmaY: 0.0));
                      },
                      child: MyCard(
                        mLeft: pd12, mRight: pd12,
                        height: heightInput,
                        pRight: pd12+3, pLeft: pd12+3,
                        alignChild: Alignment.center,
                        child: Row(
                          children: [
                            MyText(text: "Currency", pRight: 15,),

                            SvgPicture.asset('images/icons/dropdown.svg', width: 18.52, height: 10)
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('images/icons/check_in.svg', width: 20, height: 20,),
                            MyText(text: "location", color: AppColors.secondary, pLeft: 5,)
                          ],
                        ), 
                        action: (){

                        }, 
                      )
                    )
                  ],
                ),
              ),

              MyCard(
                height: heightInput,
                mLeft: pd12,
                mRight: pd12,
                mBottom: pd12,
                pLeft: 21,
                width: MediaQuery.of(context).size.width,
                alignChild: Alignment.centerLeft,
                child: MyText(
                  text: "Weight"
                ),
              ),

              MyInputField(
                height: 159.0,
                pLeft: pd12, pRight: pd12,
                labelText: "Description...",
                controller: product.description, 
                focusNode: product.descriptionNode, 
                validateField: (String value){
                  validate(value, label: "description");
                }, 
                onChanged: onChanged, 
                onSubmit: onSubmit
              ),
              
            ],
          ),
        ),

        Expanded(child: Container()),
        MyFlatButton(
          // height: 59,
          edgeMargin: EdgeInsets.only(left: 55, right: 55, bottom: 31),
          child: MyText(text: "Save edit", color: AppColors.white, pTop: 19, pBottom: 19,),
          action: (){

          },
        )
      ],
    );
  }
}