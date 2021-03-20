import 'package:albazaar_app/all_export.dart';

class SignUpBody extends StatelessWidget {

  final SignUpModel signUpModel;
  final Function onApiSignUpByPhone;
  final Function onFacebookSignUp;
  final Function onGoogleSignUp;
  final Function onApiSignUpByEmail;
  final Function onChangedCountryCode;
  final Function validateInput;
  final Function validatePassword;
  final Function validateConPassword;
  final Function onPageChange;
  final Function onChanged;
  final Function onSubmit;

  SignUpBody({
    this.signUpModel,
    this.onApiSignUpByPhone,
    this.onFacebookSignUp,
    this.onGoogleSignUp,
    this.onApiSignUpByEmail,
    this.onChangedCountryCode,
    this.validateInput,
    this.validatePassword,
    this.validateConPassword,
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
                            _lang.translate('signup_string'),
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
                          'Selendra Albazaar',
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
              signUpModel.tabController,
              _lang.translate('phone'),
              _lang.translate('email'),
              onPageChange
            )
          ),
        ),
        // tabs(context),
        
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: MyPadding(
            child: TabBarView(
              controller: signUpModel.tabController,
              children: [
                
                SignUpPhoneForm(
                  signUpPhoneFunc: onApiSignUpByPhone,
                  signUpModel: signUpModel,
                  onChangedCountryCode: onChangedCountryCode,
                  validateInput: validateInput,
                  validatePassword: validatePassword,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                ),

                SignUpEmailForm(
                  signUpEmailFunc: onApiSignUpByEmail,
                  signUpModel: signUpModel,
                  validateInput: validateInput,
                  validatePassword: validatePassword,
                  onChanged: onChanged,
                  onSubmit: onSubmit,
                ),
                
              ],
            )
          ),
        ),

        MyPadding(
          child :MyInputField(
            pRight: 5, pLeft: 5, pTop: 5,
            pBottom: 11,
            labelText: "Password",
            controller: signUpModel.password, 
            focusNode: signUpModel.passwordNode, 
            validateField: validatePassword, 
            onChanged: onChanged, 
            onSubmit: onSubmit,
          )
        ),

        MyPadding(
          child: MyInputField(
            pRight: 5, pLeft: 5, pTop: 25,
            labelText: "Confirm Password",
            controller: signUpModel.confirmPassword, 
            focusNode: signUpModel.confirmPasswordNode, 
            validateField: validateConPassword, 
            onChanged: onChanged, 
            onSubmit: onSubmit,
          )
        ),

        MyFlatButton(
          edgeMargin: EdgeInsets.only(top: 25),
          // edgeMargin: EdgeInsets.only(bottom: 25),
          child: MyText(
            pTop: 20,
            pBottom: 20,
            text: _lang.translate('signup_string'),
            color: "#FFFFFF",
          ),
          edgePadding: EdgeInsets.only(left: 78 + pd35, right: 78+ pd35),
          action: (){
          // validateAndSubmit();
          },
        ),
        
        Flexible(
          child: Align(
            alignment: Alignment.center,
            child: Text(
            _lang.translate('or_string'),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          )
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BtnSocial(
              () {
              // facebookSignUp();
              }, 
              'assets/facebook.svg'
            ),
            SizedBox(width: 20),
            BtnSocial(() {
              // googleSignUp();
            }, 'assets/google.svg'),
          ],
        ),

        SizedBox(height: 10),
        MyPadding(
          child: ReuseFlatButton.getItem(
            _lang.translate('had_an_account'),
            AppLocalizeService.of(context).translate('signup_string'), () {
              Navigator.pushReplacementNamed(context, SignUpView);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignUp()));
            }
          ),
        )
      ],
    );
  }
}
