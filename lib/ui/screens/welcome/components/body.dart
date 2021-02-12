import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selendra_marketplace_app/core/components/flat_button.dart';
import 'package:selendra_marketplace_app/core/components/scaffold.dart';

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

            Row(
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
                  child: SvgPicture.asset('images/sld_logo.svg', alignment: Alignment.centerRight, width: 90, height: 107.37),
                ),
              ],
            ),

            Expanded(
              child: Container()
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: SvgPicture.asset(
                  'images/welcome_illustrator.svg',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
            ),

            Expanded(
              child: Container()
            ),

            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 59,
                      child: MyFlatButton(
                        action: () {
                          Navigator.pushReplacementNamed(context, SignInView);
                        },
                        textButton: _lang.translate('signin_string'),
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
                      height: 59,
                      child: MyFlatButton(
                        action: () {
                          Navigator.pushReplacementNamed(context, SignUpView);
                        },
                        textButton: _lang.translate('signup_string'),
                        buttonColor: AppColors.secondary,
                      ),
                    ),
                  )
                ],
              )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: "Play around with test account.",
                ),

                FlatButton(
                  padding: EdgeInsets.only(left: 5),
                  onPressed: (){

                  },
                  child: MyText(
                    text: "Try now",
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                )
              ],
            )
            
          ],
        ),
      ),
    );
  }
}
