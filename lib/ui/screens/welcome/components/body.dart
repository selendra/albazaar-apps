import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:albazaar_app/core/components/component.dart';
import 'package:albazaar_app/core/components/flat_button.dart';
import 'package:albazaar_app/core/components/scaffold.dart';

class Body extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return MyBodyScaffold(
      height: MediaQuery.of(context).size.height,
      child: NetworkAlert(
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            MyPadding(
              pTop: pd35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _lang.translate('welcome_string'),
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Selendra Marketplace',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                                color: kDefaultColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ),

                  Expanded(
                    flex: 1,
                    child: SvgPicture.asset('assets/sld_logo.svg', alignment: Alignment.centerRight, width: 90, height: 107.37),
                  ),
                ],
              )
            ),

            Expanded(
              child: Container()
            ),

            Align(
              alignment: Alignment.center,
              child: MyPadding(
                child: SvgPicture.asset(
                  'assets/welcome_illustrator.svg',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
            ),

            Expanded(
              child: Container()
            ),

            MyPadding(
              pBottom: 25,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 59,
                      child: MyFlatButton(
                        action: () {
                          Navigator.pushReplacementNamed(context, SignInView);
                        },
                        child: MyText(
                          pTop: 20,
                          pBottom: 20,
                          text: _lang.translate('signin_string'),
                          color: "#FFFFFF",
                        ),
                        buttonColor: AppColors.primary,
                      ),
                    )
                  ),

                  SizedBox(
                    width: 10,
                  ),

                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 59,
                      child: MyFlatButton(
                        action: () {
                          Navigator.pushReplacementNamed(context, SignUpView);
                        },
                        child: MyText(
                          pTop: 20,
                          pBottom: 20,
                          text: _lang.translate('signup_string'),
                          color: "#FFFFFF",
                        ),
                        buttonColor: AppColors.secondary,
                      ),
                    ),
                  )
                ],
              )
            ),

            MyPadding(
              pBottom: pd35+pd35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: MyText(
                      text: "Play around with test account.",
                    ),
                  ),

                  MyFlatButton(
                    width: 100,
                    isTransparent: true,
                    edgePadding: EdgeInsets.only(left: 5),
                    child: MyText(
                      text: "Try now",
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    action: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    }
                  )
                ],
              )
            )
            
          ],
        ),
      ),
    );
  }
}
