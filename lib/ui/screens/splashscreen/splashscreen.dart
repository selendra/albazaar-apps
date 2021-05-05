import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/services/app_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>with SingleTickerProviderStateMixin {

  PrefService _pref = PrefService();
  AnimationController controller;
  Animation<double> animation;

  List<Map<String, dynamic>> response;

  //List of all svg path in the app
  List<String> svg = [
    'assets/undraw_wallet.svg',
    'assets/undraw_loving_it.svg',
    'assets/undraw_empty_cart.svg',
    'assets/undraw_Mobile_application.svg',
    'assets/packaging.svg'
  ];

  void checkUser() async {
    print("Hello check have user");
    try {
      //Read token
      await _pref.read('token').then((value) async {
        print("My Token $value");
        if (value != null) {
          // Fetch all listing product
          await GetRequest().getUserProfile().then((user) async {
            print("Status ${user.statusCode}");

            // Check Expired Token
            if (user.statusCode == 200) {

              // Fetching Listing Product
              response = await Provider.of<ProductsProvider>(
                context,
                listen: false,
              ).fetchListingProduct();

              print("REsponse ${response.runtimeType}");

              print(!response[0].containsKey('error'));

              // Check Someting Wrong When Fetcing Listing Product
              // if (response.runtimeType.toString() != "List<dynamic>"){
              if (response[0]['error'] == null){

                print("No Error ");

                //Fetch buyer order product list
                await Provider.of<SellerProvider>(
                  context,
                  listen: false,
                ).fetchBuyerOrder();

                //Check if user is login by social media
                await AuthProvider().currentUser.then((valueUser) {
                  if (valueUser != null) {
                    //split the social user name into firstname and lastname
                    var name = valueUser.displayName.split(' ');

                    /*call provider with function to set profile infomation
                    of the user*/
                    Provider.of<UserProvider>(context, listen: false).fetchSocialUserInfo(
                      valueUser.email,
                      name.first,
                      name.last,
                      valueUser.photoURL,
                    );
                    Provider.of<UserProvider>(context, listen: false).socialUserInfo(value);
                  } else {
                    validateNormalUser();
                  }
                });

                Navigator.pushReplacementNamed(context, BottomNavigationView);
              } 
            }
            // Expired token
            else if (user.statusCode == 401){
              
              var isShow = await _pref.read('isshow');

              // Clear All Local Data
              await AppServices.clearStorage();

              // Save Carousel Screen
              await _pref.saveString('isshow', isShow);

              await Components.dialog(context, Text("Your login was expired", textAlign: TextAlign.center), Text("Message"));
              Navigator.pushReplacementNamed(context, WelcomeView);
            }

            // Throw Error If Something With Fetching 
            else {
              print("My response error $response");
              throw (response);
            }

          });
        }
        // No Token Or Not Yet Login In Before 
        else {
          Navigator.pushReplacementNamed(context, WelcomeView);
        }
      });
    } 
    // When Don't Have Internet Or Enable Connection
    on SocketException catch (e) {
      print("Exception socket ${e.message}");
      print(e);
      await Components.dialog(
        context, 
        Text("Please check your connection", textAlign: TextAlign.center),
        Text("Oops")
      );
      Navigator.pushReplacementNamed(context, WelcomeView);
    } catch (e) {
      print(e);
      await Components.dialog(context, Text(e[0]['error']['message'].toString(), textAlign: TextAlign.center), Text("Message"));
      Navigator.pushReplacementNamed(context, WelcomeView);
    }
  }

  //It is use for validate normal user that register in sld api
  void validateNormalUser() async {
    await UserProvider().fetchPortforlio().then((onValue) {
      print("validate normal user");
        if (onValue == '200') {
          Provider.of<UserProvider>(context, listen: false).fetchUserInfo();
        } 
      },
    );
  }

  /*It precache all svg in the app
   *if help svg loaded faster when open the screen
   */
  void preCacheSvg() {
    for (int i = 0; i < svg.length; i++) {
      precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoder, svg[i]), null);
    }
  }

  //It read language from sharepreference(local storage)
  void setDefaultLang() {
    var _lang = Provider.of<LangProvider>(context, listen: false);
    _pref.read('lang').then(
      (value) {
        _lang.setLocal(value, context);
      },
    );
  }

  @override
  void initState() {

    if (mounted){
      controller = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this,
      );

      animation = CurvedAnimation(
        curve: Curves.easeIn,
        parent: controller,
      );

      /*Perform faded animation to logo*/
      controller.forward().then(
        (value) {
          _pref.read('isshow').then(
            (onValue) {
              if (onValue == null) {
                Navigator.pushReplacementNamed(context, IntroScreenView);
              } else {
                checkUser();
              }
            },
          );
        },
      );
    }

    //Pre svg image
    preCacheSvg();

    //Set Language
    setDefaultLang();

    super.initState();
  }

  @override
  void dispose() {
    if (mounted){
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAlert(
        Center(
          child: FadeTransition(
            opacity: animation,
            child: SvgPicture.asset(
              'assets/sld_logo.svg',
              height: 150,
              width: 150,
            )
          ),
        ),
      ),
    );
  }
}
