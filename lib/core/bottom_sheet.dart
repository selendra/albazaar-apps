import 'package:flutter_svg/svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class MyBottomSheet{

  dynamic response;
  
  Future<dynamic> trxOptions({
    BuildContext context,
    List portfolioList,
    Function resetHomeData
  }) {
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white//hexaCodeToColor(AppColors.bgdColor)
        ),
        height: 153,
        child: Column(
          children: [

            Align(
              alignment: Alignment.center,
              child: MyText(
                color: "#FFFFFF",
                top: 20,
                bottom: 33,
                text: "Transaction options",
              ),
            ),
            
            Row(
              children: [

                Expanded(
                  child: MyBottomSheetItem(
                    subTitle: "Scan wallet",
                    icon: "sld_qr.svg",
                    action: () async {
                      try {
                        // await TrxOptionMethod.scanQR(context, portfolioList, resetHomeData);
                      } catch (e){
                        print(e.message);
                      }
                    },
                  ),
                ),

                Expanded(
                  child: MyBottomSheetItem(
                    icon: "form.svg",
                    subTitle: "Fill wallet", 
                    action: () {
                      // TrxOptionMethod.navigateFillAddress(context, portfolioList, resetHomeData);
                    }
                  )
                ),

                Expanded(
                  child: MyBottomSheetItem(
                    icon: "contact.svg",
                    subTitle: "Invite friend", 
                    action: () {
                      // TrxOptionMethod.selectContact(context, portfolioList, resetHomeData);
                    }
                  )
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Future<dynamic> notification({
    BuildContext context
  }) {
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white//hexaCodeToColor(AppColors.bgdColor)
        ),
        height: MediaQuery.of(context).size.height - 107,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: MyText(
                color: "#FFFFFF",
                top: 20,
                bottom: 33,
                text: "",
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/no_data.svg', height: 200),

                  MyText(
                    text: "There are no notification found"
                  )
                ],
              )
            )
          ],
        ),
      );
    },
    );
  }
}

class MyBottomSheetItem extends StatelessWidget {

  final String subTitle;
  final String icon;
  final Function action;

  MyBottomSheetItem({
    @required this.subTitle,
    @required this.icon,
    @required this.action
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Column(
        children: [
          
          SvgPicture.asset('images/icons/$icon', width: 30, height: 30, color: Colors.black),

          Text(
            subTitle
          )
        ],
      )
    );
  }
}


class MyText extends StatelessWidget{

  final String text; final String color; final double fontSize; final FontWeight fontWeight;
  final double top; final double right; final double bottom; final double left;
  final double pTop; final double pRight; final double pBottom; final double pLeft;
  final double width; final double height; final TextAlign textAlign;
  final TextOverflow overflow;

  MyText({
    this.text, this.color = "#FFFFFF", this.fontSize = 18, this.fontWeight = FontWeight.normal,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0,
    this.pLeft = 0, this.pRight = 0, this.pTop = 0, this.pBottom = 0,
    this.width, this.height, this.textAlign = TextAlign.center,
    this.overflow,
  });
  
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      padding: EdgeInsets.fromLTRB(pLeft, pTop, pRight, pBottom),
      child: SizedBox(
        width: this.width,
        height: this.height,
        child: Text(
          this.text,
          style: TextStyle(
            fontWeight: this.fontWeight,
            color: Colors.black,//Color(AppUtils.convertHexaColor(this.color)),
            fontSize: this.fontSize
          ),
          textAlign: this.textAlign,
          overflow: overflow,
        )
      ),
    );
  }
}