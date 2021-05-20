import 'package:albazaar_app/core/providers/app_provider_p.dart';
import 'package:albazaar_app/ui/screens/edit_product/edit_product.dart';
import 'package:albazaar_app/ui/screens/invitation/inviation.dart';
import 'package:albazaar_app/ui/screens/shop/create_shop/create_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:albazaar_app/core/services/app_services.dart';
import 'package:albazaar_app/ui/screens/seller_confirmation/seller_confrmation.dart';
import 'all_export.dart';
import 'core/route/router.dart' as router;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:responsive_framework/responsive_framework.dart';

final navigationKey = GlobalKey<NavigatorState>();
final sfKey = GlobalKey<ScaffoldState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SelendraApp());
}

class SelendraApp extends StatefulWidget {
  @override
  _SelendraAppState createState() => _SelendraAppState();
}

class _SelendraAppState extends State<SelendraApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: AppProvider.listProvider,
      child: Consumer<LangProvider>(
        builder: (context, value, child) => MaterialApp(
          builder: (context, child) {
            return ResponsiveWrapper.builder(
              ScrollConfiguration(
                behavior: ScrollBehavior()
                  ..buildViewportChrome(context, child, AxisDirection.down),
                child: child,
              ),
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(480, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              ],
              background: Container(color: Color(0xFFF5F5F5))
            );
          },
          title: appTitle,
          locale: value.manualLocale,

          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('km', 'KH'),
          ],
          localizationsDelegates: [
            AppLocalizeService.delegate,
            //build-in localization for material wiidgets
            GlobalWidgetsLocalizations.delegate,

            GlobalMaterialLocalizations.delegate,
          ],
          
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            if (locale != null) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
            }
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
          },
          onGenerateRoute: router.generateRoute,
          // initialRoute: OTPScreen.route, //SplashScreenView,
          // debugShowCheckedModeBanner: true,
          theme: ThemeData(
            cursorColor: kDefaultColor,
            // textTheme: TextTheme(bodyText1: TextStyle(color: AppServices.hexaCodeToColor(textColor))),
            primaryColor: AppServices.hexaCodeToColor("#F7F7F7"),
            scaffoldBackgroundColor: AppServices.hexaCodeToColor(AppColors.bgColor),
            brightness: Brightness.light,
            textTheme: GoogleFonts.robotoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          routes: {
            DetailView: (context) => DetailScreen(),
            SellerInfoView: (context) => SoldDetails(),
            OTPScreen.route: (context) => OTPScreen('', '')
          },
          home: ProfileScreen(), //BottomNavigation(),//SplashScreen(),
          navigatorKey: navigationKey,
        ),
      ),
    );
  }
}
