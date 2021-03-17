import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/card_c.dart';
import 'package:albazaar_app/core/components/text_btn.dart';

class MyDropDownCustom{

  static double padding = 10;
  static double margin = 20;

  static Widget productEdit({@required BuildContext context, double x, double y}) {
    return GestureDetector(
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
              left: x,
              top: y, //MediaQuery.of(context).size.height/2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCard(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.2)
                      )
                    ],
                    alignChild: Alignment.center,
                    mRight: margin, mLeft: margin,
                    hexaColor: AppColors.white,
                    width: 119,
                    height: 250,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, "edit");
                          },
                          text: "Edit",
                        ),
                        Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                        MyTextButton(
                          onTap: ()  async {
                            Navigator.pop(context, "delete");
                          },
                          text: "Delete",
                        ),
                        Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, "share");
                          },
                          text: "Share",
                        ),
                        Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                        MyTextButton(
                          fontWeight: FontWeight.normal,
                          text: "Close"
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }

  static Widget profileDropDownBtn({BuildContext context, double x, double y}){
    return GestureDetector(
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
              left: x - 150,
              top: y + 10, //MediaQuery.of(context).size.height/2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCard(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.2)
                      )
                    ],
                    alignChild: Alignment.center,
                    mRight: margin, mLeft: margin,
                    hexaColor: AppColors.white,
                    width: 250,
                    height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyTextButton(
                          onTap: (){
                          },
                          text: "Change profile",
                        ),
                        Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                        MyTextButton(
                          onTap: ()  async {
                          },
                          text: "Change background",
                        ),

                        Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                        MyTextButton(
                          onTap: ()  async {
                          },
                          text: "Change about",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
  
  static Widget currencyDdBtn({BuildContext context, double x, double y}){
    return GestureDetector(
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
              left: x,
              top: y, //MediaQuery.of(context).size.height/2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCard(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.2)
                      )
                    ],
                    alignChild: Alignment.center,
                    mRight: margin, mLeft: margin,
                    hexaColor: AppColors.white,
                    width: 100,
                    height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyTextButton(
                          onTap: (){
                          },
                          text: "Riel",
                        ),
                        Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                        MyTextButton(
                          onTap: ()  async {
                          },
                          text: "Dollar",
                        ),

                        Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                        MyTextButton(
                          onTap: ()  async {
                          },
                          text: "SEL",
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
  
  static Widget weightDbBtn({BuildContext context, double x, double y}){
    return GestureDetector(
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
              left: x,
              top: y + 100, //MediaQuery.of(context).size.height/2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCard(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(0.2)
                      )
                    ],
                    alignChild: Alignment.center,
                    mRight: margin, mLeft: margin,
                    hexaColor: AppColors.white,
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                           
                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'kg');
                          },
                          text: "Fruit",
                        ),

                        Divider(height: 1),

                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'g');
                          },
                          text: "Meat",
                        ),

                        Divider(height: 1),

                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'g');
                          },
                          text: "Vegetable",
                        ),

                        Divider(height: 1),

                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'g');
                          },
                          text: "Electronic",
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
}