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
                        Navigator.pop(context, {'currency_name': 'Riel', 'id': '1'});
                      },
                      text: "Riel",
                    ),
                    Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                    MyTextButton(
                      onTap: ()  async {
                        Navigator.pop(context, {'currency_name': 'Dollar', 'id': '2'});
                      },
                      text: "Dollar",
                    ),

                    Divider(color: Colors.grey.withOpacity(0.2), height: 2),
                    MyTextButton(
                      onTap: ()  async {
                        Navigator.pop(context, {'currency_name': 'SEL', 'id': '3'});
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
    final weightList = Provider.of<AddProductProvider>(context, listen: false).addProduct.weightList;
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
              // left: x,
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
                    child: ListView.builder(
                      itemCount: weightList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              
                            MyTextButton(
                              onTap: (){
                                Navigator.pop(context, weightList[index]);
                              },
                              text: weightList[index]['weight_option'],
                            ),

                            Divider(height: 1),
                          ]
                        );
                      }
                    )
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                           
                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Kilogram');
                    //       },
                    //       text: "Kilogram",
                    //     ),

                    //     Divider(height: 1),

                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Gram');
                    //       },
                    //       text: "Gram",
                    //     ),

                    //     Divider(height: 1),

                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Unit');
                    //       },
                    //       text: "Unit",
                    //     ),
                    //   ],
                    // ),
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
    final categoriesList = Provider.of<CategoriesModel>(context, listen: false).listCategories;
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
              // right: if x ,
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
                    child: ListView.builder(
                      itemCount: categoriesList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            MyTextButton(
                              onTap: (){
                                Navigator.pop(context, categoriesList[index]);
                              },
                              text: categoriesList[index]['category_name'],
                            ),

                            Divider(height: 1)
                          ],
                        );
                      }
                    )
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                           
                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Fruit');
                    //       },
                    //       text: "Fruit",
                    //     ),

                    //     Divider(height: 1),

                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Meat');
                    //       },
                    //       text: "Meat",
                    //     ),

                    //     Divider(height: 1),

                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Vegetable');
                    //       },
                    //       text: "Vegetable",
                    //     ),

                    //     Divider(height: 1),

                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Cereal');
                    //       },
                    //       text: "Cereal",
                    //     ),

                    //     Divider(height: 1),

                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Others');
                    //       },
                    //       text: "Others",
                    //     )
                    //   ],
                    // ),
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }

  static Widget paymentDdBtn({BuildContext context, double x, double y}){
    final paymentList = Provider.of<AddProductProvider>(context, listen: false).addProduct.paymentOptsList;
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
                    width: 120,
                    child: ListView.builder(
                      itemCount: paymentList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              
                            MyTextButton(
                              onTap: (){
                                Navigator.pop(context, paymentList[index]);
                              },
                              text: paymentList[index]['options_name'],
                            ),

                            Divider(height: 1),
                          ]
                        );
                      }
                    )
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
  static Widget shippingDdBtn({BuildContext context, double x, double y}){
    final shippingList = Provider.of<AddProductProvider>(context, listen: false).addProduct.shippingList;
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
                    width: 120,
                    child: ListView.builder(
                      itemCount: shippingList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              
                            MyTextButton(
                              onTap: (){
                                Navigator.pop(context, shippingList[index]);
                              },
                              text: shippingList[index]['shipping_service'],
                            ),

                            Divider(height: 1),
                          ]
                        );
                      }
                    )
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                           
                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Kilogram');
                    //       },
                    //       text: "Kilogram",
                    //     ),

                    //     Divider(height: 1),

                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Gram');
                    //       },
                    //       text: "Gram",
                    //     ),

                    //     Divider(height: 1),

                    //     MyTextButton(
                    //       onTap: (){
                    //         Navigator.pop(context, 'Unit');
                    //       },
                    //       text: "Unit",
                    //     ),
                    //   ],
                    // ),
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