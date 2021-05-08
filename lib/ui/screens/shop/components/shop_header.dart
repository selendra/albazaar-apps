import 'package:albazaar_app/all_export.dart';

class ShopHeader extends StatelessWidget{

  final ShopModel shopModel;
  final Function editHeader;

  ShopHeader({
    this.shopModel,
    this.editHeader
  });

  Widget build(BuildContext context){
    return MyPadding(
      pTop: pd10+2,
      pLeft: pd10+2, pRight: pd10+2,
      pBottom: pd10+pd10,
      child: MyCard(
        boxShadow: [
          boxShadow()
        ],
        // height: 382.0,
        child: Stack(
          children: [
            Column(
              children: [

                Container(
                  padding: shopModel.cover.isEmpty ? EdgeInsets.only(top: 20) : EdgeInsets.zero,
                  height: 228,
                  child: shopModel.cover.isEmpty ? Image.asset('${AppConfig.imagePath}shop_cover_image.jpg') : Image.file(File(shopModel.cover),)
                ),

                Flexible(
                  child: MyCard(
                    bTopLeft: 0, bTopRight: 0,
                    hexaColor: AppColors.secondary,
                    child: Container(
                      padding: EdgeInsets.only(left: pd20, right: pd20, top: pd20+15, bottom: pd20),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            textAlign: TextAlign.start,
                            text: "About",
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),

                          MyText(
                            top: pd10,
                            textAlign: TextAlign.left,
                            color: AppColors.white,
                            text: "${shopModel.about.text.isEmpty ? 'No information' : shopModel.about.text.isEmpty}",
                            fontSize: 16,
                          )
                        ],
                      )
                    ),
                  )
                )    
              ]   
            ),

            // Profile Logo
            Positioned(
              top: (382/2.3),
              left: 20,
              child: MyCard(
                height: 80, width: 80,
                hexaColor: AppColors.black,
                child: MyPadding(
                  pBottom: shopModel.profile.isEmpty ? pd10 : 0, 
                  pLeft: shopModel.profile.isEmpty ? pd10 : 0, 
                  pRight: shopModel.profile.isEmpty ? pd10 : 0,
                  pTop: shopModel.profile.isEmpty ? pd10 : 0,
                  child: shopModel.profile.isEmpty ? Image.asset('assets/koompi_logo.png') : Image.file(File(shopModel.profile), fit: BoxFit.cover,)
                )
              ),
            ),   

            // Edit Logo
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTapDown: (TapDownDetails detail) async {
                  final response = await Navigator.push(
                    context, 
                    popUpRoute(
                      MyDropDownCustom.profileDropDownBtn(context: context, x: detail.globalPosition.dx, y: detail.globalPosition.dy,), sigmaX: 0.0, sigmaY: 0.0
                    )
                  );

                  if (response != null){
                    editHeader(response);
                  }
                },
                child: MyPadding(
                  pRight: 8,
                  pTop: 8,
                  pBottom: 8,
                  pLeft: 8,
                  child: SvgPicture.asset('assets/icons/edit.svg', width: 20, height: 20)
                ),
              ),
            )    
          ],
        )
      ),
    );
  }
}