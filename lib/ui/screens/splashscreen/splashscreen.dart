import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  PrefService _pref = PrefService();
  AnimationController controller;
  Animation<double> animation;

  //List of all svg path in the app
  List<String> svg = [
    'images/undraw_wallet.svg',
    'images/undraw_loving_it.svg',
    'images/undraw_empty_cart.svg',
    'images/undraw_Mobile_application.svg',
    'images/packaging.svg'
  ];

  void checkUser() {
    //Read token
    _pref.read('token').then(
      (value) async {
        if (value != null) {
          //Fetch all listing product
          Provider.of<ProductsProvider>(
            context,
            listen: false,
          ).fetchListingProduct();

          //Fetch buyer order product list
          Provider.of<SellerProvider>(
            context,
            listen: false,
          ).fetchBuyerOrder();

          //Check if user is login by social media
          AuthProvider().currentUser.then(
            (valueUser) {
              if (valueUser != null) {
                //split the social user name into firstname and lastname
                var name = valueUser.displayName.split(' ');

                /*call provider with function to set profile infomation
                of the user*/
                Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).fetchSocialUserInfo(
                  valueUser.email,
                  name.first,
                  name.last,
                  valueUser.photoUrl,
                );
                Provider.of<UserProvider>(context, listen: false)
                    .socialUserInfo(value);
                Navigator.pushReplacementNamed(context, BottomNavigationView);
              } else {
                validateNormalUser();
              }
            },
          );
        } else {
          Navigator.pushReplacementNamed(context, WelcomeView);
        }
      },
    );
  }

  //It is use for validate normal user that register in sld api
  void validateNormalUser() async {
    await UserProvider().fetchPortforlio().then(
      (onValue) {
        if (onValue == '200') {
          Provider.of<UserProvider>(context, listen: false).fetchUserInfo();
          Navigator.pushReplacementNamed(context, BottomNavigationView);
        } else {
          _pref.clear('token');
          Navigator.pushReplacementNamed(context, WelcomeView);
        }
      },
    );
  }

  /*It precache all svg in the app
   *if help svg loaded faster when open the screen
   */
  void preCacheSvg() {
    for (int i = 0; i < svg.length; i++) {
      precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoder, svg[i]), null);
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
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 2),
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

    //Pre svg image
    preCacheSvg();

    //Set Language
    setDefaultLang();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkAlert(
        Center(
          child: FadeTransition(
            opacity: animation,
            child: Image.asset(
              'images/logo.png',
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
