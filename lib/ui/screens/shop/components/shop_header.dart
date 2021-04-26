import 'package:albazaar_app/all_export.dart';

class ShopHeader extends StatelessWidget{

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
                  padding: EdgeInsets.only(top: 20),
                  height: 228,
                  child: Image.asset('assets/shop_cover_image.jpg',fit: BoxFit.cover)
                ),

                Flexible(
                  child: MyCard(
                    bTopLeft: 0, bTopRight: 0,
                    hexaColor: AppColors.secondary,
                    child: Container(
                      padding: EdgeInsets.only(left: pd20, right: pd20, top: pd20+15, bottom: pd20),
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
                            text: "Hello ! My name’s Daveat. I’m come from phnom penh and sell crops like broccoli, etc.",
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
                  pBottom: pd10, pLeft: pd10, pRight: pd10, pTop: pd10,
                  child: Image.asset('assets/koompi_logo.png'),
                )
              ),
            ),   

            // Edit Logo
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTapDown: (TapDownDetails detail) async {
                  await Navigator.push(
                    context, 
                    popUpRoute(
                      MyDropDownCustom.profileDropDownBtn(context: context, x: detail.globalPosition.dx, y: detail.globalPosition.dy,), sigmaX: 0.0, sigmaY: 0.0
                    )
                  );
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