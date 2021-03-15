import 'package:albazaar_app/all_export.dart';

class CreateShopBody extends StatelessWidget {
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

                    Container(
                      padding: EdgeInsets.only(top: 20),
                      height: 228,
                      child: SvgPicture.asset('images/gallery.svg', width: 140, height: 107.33,)
                      // child: Image.asset('images/gallery.svg',fit: BoxFit.contain)
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
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                                labelText: "About"
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
                  child: MyCard(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 2,
                        spreadRadius: 1,
                      )
                    ],
                    height: 80, width: 80,
                    hexaColor: AppColors.white,
                    child: MyPadding(
                      pBottom: pd10, pLeft: pd10, pRight: pd10, pTop: pd10,
                      child: SvgPicture.asset('images/gallery.svg', width: 50, height: 38.33),
                    )
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
                SvgPicture.asset('images/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.secondary)),
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

        Expanded(child: Container(),),

        MyFlatButton(
          border: Border.all(color: AppServices.hexaCodeToColor(AppColors.secondary), width: 2),
          isTransparent: true,
          width: 161,
          height: 46,
          child: Row(
            children: [
              SvgPicture.asset('images/icons/plus.svg', width: 15, height: 15, color: AppServices.hexaCodeToColor(AppColors.secondary)),
              MyText(left: pd10, text: "Add product", fontWeight: FontWeight.w600, color: AppColors.secondary,),
            ],
          ),
          action: (){},
        ),

        Expanded(
          child: Container(),
        ),

        MyFlatButton(
          height: 72,
          borderRadius: 0,
          buttonColor: AppColors.secondary,
          child: MyText(
            text: "Submit",
            fontSize: 25,
            color: AppColors.white,
          ),
          action: (){},
        )
      ],
    );
  }
}