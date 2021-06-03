import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/card_c.dart';

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
              MyPadding(
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
                        child: SvgPicture.asset('assets/icons/close.svg'),
                      ),
                    )
                  ],
                ),
              ),

              MyCard(
                hexaColor: AppColors.secondary,
                align: Alignment.center,
                width: 100, height: 100,
                mBottom: padding*2,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: SvgPicture.asset('assets/avatar_user.svg'),
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
              
              MyPadding(
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
                      child: SvgPicture.asset('assets/icons/chat.svg', width: 25, height: 25, color: Colors.white),
                    ),

                    MyFlatButton(
                      width: 43, height: 50,
                      buttonColor: AppColors.white,
                      action: () async {
                        await MyBottomSheet().contactOption(context: context);
                      },
                      child: SvgPicture.asset('assets/icons/options.svg', height: 20,),
                    )
                  ],
                ),
              ),

              MyPadding(
                pLeft: padding*2, pRight: padding*2,
                pBottom: padding * 2,
                child: Divider(
                  height: 1,
                  color: AppServices.hexaCodeToColor(AppColors.black),
                )
              ),

              MyPadding(
                pLeft: padding * 2, pRight: padding * 2,
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

              MyPadding(
                pLeft: padding*2, pRight: padding*2,
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