import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/core/components/card_c.dart';

class MyDropDownCustom extends StatelessWidget {

  final double padding = 10;
  
  @override
  Widget build(BuildContext context) {
    final double margin = 20;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0),
          child: Stack(
            children: [
              Positioned(
                right: pd10+12,
                top: MediaQuery.of(context).size.height/2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyCard(
                      boxShadow: [BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: Colors.black.withOpacity(0.5)
                        )
                      ],
                      alignChild: Alignment.center,
                      mRight: margin, mLeft: margin,
                      hexaColor: AppColors.bgColor,
                      width: 119,
                      height: 250,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: (){
                              print("1");
                            },
                            child: MyPadding(
                              child: MyText(width: 119, text: "Edit", fontWeight: FontWeight.w600),
                              pLeft: 0, pRight: 0, pTop: 18, pBottom: 18,
                            ),
                          ),
                          Divider(color: AppServices.hexaCodeToColor(AppColors.black), height: 2),
                          MyPadding(
                            child: MyText(width: 119, text: "Delete", fontWeight: FontWeight.w600),
                            pLeft: 0, pRight: 0, pTop: 18, pBottom: 18,
                          ),
                          Divider(color: AppServices.hexaCodeToColor(AppColors.black), height: 2),
                          MyPadding(
                            child: MyText(width: 119, text: "Share", fontWeight: FontWeight.w600),
                            pLeft: 0, pRight: 0, pTop: 18, pBottom: 18,
                          ),
                          Divider(color: AppServices.hexaCodeToColor(AppColors.black), height: 2),
                          MyPadding(
                            child: MyText(width: 119, text: "Close"),
                            pLeft: 0, pRight: 0, pTop: 18, pBottom: 18,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
          // MyCard(
          //   alignChild: Alignment.center,
          //   mRight: margin, mLeft: margin,
          //   hexaColor: AppColors.bgColor,
          //   width: 119,
          //   height: 250,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       MyPadding(
          //         child: MyText(width: 119, text: "Edit", fontWeight: FontWeight.w600),
          //         pLeft: 0, pRight: 0, pTop: 18, pBottom: 18,
          //       ),
          //       Divider(color: AppServices.hexaCodeToColor(AppColors.black), height: 2),
          //       MyPadding(
          //         child: MyText(width: 119, text: "Delete", fontWeight: FontWeight.w600),
          //         pLeft: 0, pRight: 0, pTop: 18, pBottom: 18,
          //       ),
          //       Divider(color: AppServices.hexaCodeToColor(AppColors.black), height: 2),
          //       MyPadding(
          //         child: MyText(width: 119, text: "Share", fontWeight: FontWeight.w600),
          //         pLeft: 0, pRight: 0, pTop: 18, pBottom: 18,
          //       ),
          //       Divider(color: AppServices.hexaCodeToColor(AppColors.black), height: 2),
          //       MyPadding(
          //         child: MyText(width: 119, text: "Close"),
          //         pLeft: 0, pRight: 0, pTop: 18, pBottom: 18,
          //       ),
          //     ],
          //   ),
          // )
        )
      )
    );
  }
}