import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/components/card_c.dart';

class SellerInformation extends StatelessWidget {

  final double padding = 10;
  
  @override
  Widget build(BuildContext context) {
    final double margin = 20;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: MyCard(
          mRight: margin, mLeft: margin,
          width: MediaQuery.of(context).size.width,
          hexaColor: AppColors.bgColor,
          height: 510,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PaddingScaffold(
                pTop: padding,
                pRight: padding,
                pBottom: padding+padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: MyCard(
                        height: 40, width: 40,
                        colorOpacity: 0,
                        child: SvgPicture.asset('images/icons/close.svg'),
                      ),
                    )
                  ],
                ),
              ),

              MyCard(
                hexaColor: AppColors.secondary,
                align: Alignment.center,
                width: 100, height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset('images/avatar_user.svg'),
                ),
              ),
              
              MyText(
                bottom: padding,
                text: 'Koompi',
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                fontSize: 25,
              ),
              
              MyText(
                bottom: padding * 3 + 5,
                text: 'Phnom penh (Steng mean chey)',
                color: AppColors.black
              ),
              
              PaddingScaffold(
                pLeft: 0, pRight: 0,
                pBottom: padding * 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyFlatButton(
                      edgeMargin: EdgeInsets.only(right: 15),
                      width: 104, height: 50,
                      buttonColor: AppColors.secondary,
                      action: (){},
                      child: MyText(
                        text: 'Call',
                        color: AppColors.white
                      ),
                    ),

                    MyFlatButton(
                      edgeMargin: EdgeInsets.only(right: 15),
                      width: 53, height: 50,
                      buttonColor: AppColors.secondary,
                      action: (){},
                      child: SvgPicture.asset('images/icons/message.svg', width: 25, height: 25),
                    ),

                    MyFlatButton(
                      width: 43, height: 50,
                      buttonColor: AppColors.white,
                      action: (){},
                      child: SvgPicture.asset('images/icons/options.svg', height: 20,),
                    )
                  ],
                ),
              ),

              PaddingScaffold(
                pLeft: padding, pRight: padding,
                pBottom: padding * 2,
                child: Divider(
                  height: 1,
                  color: AppServices.hexaCodeToColor(AppColors.black),
                )
              ),

              PaddingScaffold(
                pLeft: padding, pRight: padding,
                pBottom: padding * 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    pRight: 10,
                    text: 'About',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  )
                ),
              ),

              PaddingScaffold(
                pLeft: padding, pRight: padding,
                pBottom: padding,
                child: MyText(
                  textAlign: TextAlign.left,
                  text: 'Hello ! My name’s Daveat. I’m come from phnom penh and sell crops like broccoli, etc.',
                  fontSize: 16,
                )
              ),
              
            ],
          ),
        )
      ),
    );
  }
}