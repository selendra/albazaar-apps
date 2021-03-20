import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/component.dart';

class SignInBody extends StatelessWidget{

  final SignInModel signInModel;
  final Function onApiSignInByPhone;
  final Function onFacebookSignIn;
  final Function onGoogleSignIn;
  final Function onApiSignInByEmail;
  final Function onChangedCountryCode;
  final Function validateInput;
  final Function validatePassword;
  final Function onPageChange;
  final Function onChanged;
  final Function onSubmit;

  SignInBody({
    this.signInModel,
    this.onApiSignInByPhone,
    this.onFacebookSignIn,
    this.onGoogleSignIn,
    this.onApiSignInByEmail,
    this.onChangedCountryCode,
    this.validateInput,
    this.validatePassword,
    this.onPageChange,
    this.onChanged,
    this.onSubmit
  });

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Column(
      children: [

        MyPadding(
          pTop: pd35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      // padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Text(
                            _lang.translate('signin_string'),
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Albazaar',
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

        MyPadding(
          pTop: 60,
          pBottom: 30,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ReuseAuthTab(
              signInModel.tabController,
              _lang.translate('phone'),
              _lang.translate('email'),
              onPageChange
            )
          )
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: MyPadding(
            child: TabBarView(
              controller: signInModel.tabController,
              children: [
                
                SignInPhoneForm(
                  signInPhoneFunc: onApiSignInByPhone,
                  signInModel: signInModel,
                  onChangedCountryCode: onChangedCountryCode,
                  validateInput: validateInput,
                  validatePassword: validatePassword,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                ),

                SignInEmailForm(
                  signInEmailFunc: onApiSignInByEmail,
                  signInModel: signInModel,
                  validateInput: validateInput,
                  validatePassword: validatePassword,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                )
              ],
            )
          ),
        ),

        MyPadding(
          child: MyInputField(
            pRight: 5, pLeft: 5, pTop: 5,
            labelText: "Password",
            controller: signInModel.password, 
            focusNode: signInModel.passwordNode, 
            textInputFormatter: [
              LengthLimitingTextInputFormatter(TextField.noMaxLength)
            ],
            validateField: validatePassword, 
            onChanged: onChanged, 
            onSubmit: onSubmit,
          ),
        ),
        
        Container(
          alignment: Alignment.centerRight,
          child: MyPadding(
            pLeft: 10, pTop: 10, pBottom:10,
            child: TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pushReplacement(context, RouteAnimation(enterPage: ResetPassPhone()));
              },
              child: MyText(
                text: _lang.translate('forget_password'),
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
          ),
        ),

        MyFlatButton(
          // edgeMargin: EdgeInsets.only(bottom: 25),
          child: MyText(
            pTop: 20,
            pBottom: 20,
            text: _lang.translate('signin_string'),
            color: "#FFFFFF",
          ),
          edgePadding: EdgeInsets.only(left: 78 + pd35, right: 78+ pd35),
          action: !signInModel.enable ? null : (){
          // validateAndSubmit();
          },
        ),
        
        Flexible(
          child: MyPadding(
            child: Align(
              alignment: Alignment.center,
              child: Text(
              _lang.translate('or_string'),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            )
          ),
        ),

        MyPadding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BtnSocial(
                () {
                  onFacebookSignIn();
                }, 
                'assets/facebook.svg'
              ),
              SizedBox(width: 20),
              BtnSocial(() {
                onGoogleSignIn();
              }, 'assets/google.svg'),
            ],
          )
        ),

        SizedBox(height: 10),
        MyPadding(
          child: ReuseFlatButton.getItem(
            _lang.translate('haven\'t_had_account'),
            AppLocalizeService.of(context).translate('signup_string'), () {

              FocusScope.of(context).unfocus();
              Navigator.pushReplacementNamed(context, SignUpView);
            }
          )
        )
      ],
    );
  }
}
