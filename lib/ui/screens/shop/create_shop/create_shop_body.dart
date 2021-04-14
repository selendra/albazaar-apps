import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/models/shop_m.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product.dart';

class CreateShopBody extends StatelessWidget {

  final ShopModel shopModel;

  final Function onChangeImage;

  final Function submit;

  CreateShopBody({this.shopModel, this.onChangeImage, this.submit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // Header
        MyPadding(
          pTop: pd10+2,
          pLeft: pd10+2, pRight: pd10+2,
          pBottom: pd10+pd10,
          child: MyCard(
            // height: 382.0,
            child: Stack(
              children: [
                Column(
                  children: [

                    GestureDetector(
                      onTap: (){
                        onChangeImage('bgImage');
                      },
                      child: shopModel.bgImage != '' ? 
                      // Image have picked
                      MyCard(
                        height: 228,
                        pBottom: 20, pTop: 20, pRight: 20, pLeft: 20,
                        bBottomLeft: 0, bBottomRight: 0,
                        image: DecorationImage(
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          image: FileImage(File(shopModel.bgImage))
                        ),
                      ) 
                      // Default image
                      : Container(
                        padding: EdgeInsets.only(top: 20),
                        height: 228,
                        child: SvgPicture.asset('assets/gallery.svg', width: 140, height: 107.33)
                        // child: Image.asset('assets/gallery.svg',fit: BoxFit.contain)
                      )
                    ),

                    MyCard(
                      bTopLeft: 0, bTopRight: 0,
                      hexaColor: AppColors.secondary,
                      child: Container(
                        padding: EdgeInsets.only(left: pd20, right: pd20, top: pd20+15, bottom: pd20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            TextFormField(
                              controller: shopModel.about,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                                labelText: "About",
                                
                              ),
                            )
                          ],
                        )
                      ),
                    )    
                  ]   
                ),

                // Profile Logo
                Positioned(
                  top: (382/2.3),
                  left: 20,
                  child: GestureDetector(
                    onTap: (){
                      onChangeImage('thumbnail');
                    },
                    child: MyCard(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 2,
                          spreadRadius: 1,
                        )
                      ],
                      image: shopModel.thumbnail == '' ? null : DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        image: FileImage(File(shopModel.thumbnail))
                      ),
                      height: 80, width: 80,
                      hexaColor: AppColors.white,
                      child: shopModel.thumbnail != '' ? Container() : MyPadding(
                        pBottom: pd10, pLeft: pd10, pRight: pd10, pTop: pd10,
                        child: SvgPicture.asset('assets/gallery.svg', width: 50, height: 38.33),
                      )
                    ),
                  ),
                ),   
              ],
            )
          ),
        ),

        // Location
        GestureDetector(
          child: MyPadding(
            pBottom: pd10, pRight: pd10+2, pLeft: pd10+2, pTop: pd10,
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.secondary)),
                MyText(left: pd10, text: "Set Address", fontWeight: FontWeight.w600, color: AppColors.secondary,),
              ],
            ),
          ),
        ),

        MyPadding(
          pLeft: pd10+2, pRight: pd10+2,
          pBottom: pd20,
          child: MyCard(
            height: 136,
            width: MediaQuery.of(context).size.width,
            // child: ,
          )
        ),

        Center(
          child: MyFlatButton(
            border: Border.all(color: AppServices.hexaCodeToColor(AppColors.secondary), width: 2),
            isTransparent: true,
            width: 161,
            height: 46,
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.secondary)),
                MyText(left: pd10, text: "Add product", fontWeight: FontWeight.w600, color: AppColors.secondary,),
              ],
            ),
            action: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProduct()));
            },
          )
        ),

        Flexible(
          child: Container(),
        ),

        MyFlatButton(
          height: 72,
          width: MediaQuery.of(context).size.width/2,
          buttonColor: AppColors.secondary,
          child: MyText(
            text: "Submit",
            fontSize: 25,
            color: AppColors.white,
          ),
          action: submit,
        )
      ],
    );
  }
}