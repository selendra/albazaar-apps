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
              right: 0,
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
              right: 0,
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
              right: 0,
              top: y, //MediaQuery.of(context).size.height/2,
              child: MyCard(
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
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    MyTextButton(
                      onTap: (){
                        Navigator.pop(context, 'riel');
                      },
                      text: "Riel",
                    ),
                    Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                    MyTextButton(
                      onTap: ()  async {
                        Navigator.pop(context, 'dollar');
                      },
                      text: "Dollar",
                    ),

                    Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                    MyTextButton(
                      onTap: ()  async {
                        Navigator.pop(context, 'sel');
                      },
                      text: "SEL",
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }

  static Widget scaleDdBtn({BuildContext context, double x, double y}){
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
              left: x-120,
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
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                           
                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'Kilogram');
                          },
                          text: "Kilogram",
                        ),

                        Divider(height: 1),

                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'Gram');
                          },
                          text: "Gram",
                        ),

                        Divider(height: 1),

                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'Unit');
                          },
                          text: "Unit",
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
  
  static Widget categoryDdBtn({BuildContext context, double x, double y}){
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
              right: 0,
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
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                           
                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'Fruit');
                          },
                          text: "Fruit",
                        ),

                        Divider(height: 1),

                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'Meat');
                          },
                          text: "Meat",
                        ),

                        Divider(height: 1),

                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'Vegetable');
                          },
                          text: "Vegetable",
                        ),

                        Divider(height: 1),

                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'Cereal');
                          },
                          text: "Cereal",
                        ),

                        Divider(height: 1),

                        MyTextButton(
                          onTap: (){
                            Navigator.pop(context, 'Others');
                          },
                          text: "Others",
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