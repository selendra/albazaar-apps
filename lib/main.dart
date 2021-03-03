import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selendra_marketplace_app/core/providers/add_product_provider.dart';
import 'package:selendra_marketplace_app/core/providers/guest_acc_p.dart';
import 'package:selendra_marketplace_app/core/providers/seller_provider.dart';
import 'package:selendra_marketplace_app/core/providers/trx_history_provider.dart';
import 'package:selendra_marketplace_app/core/services/app_services.dart';
import 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_confrmation.dart';
import 'all_export.dart';
import 'core/route/router.dart' as router;
import 'core/providers/auth_provider.dart';
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
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (context) => ConnectivityServices().streamController.stream,
        ),
        ChangeNotifierProvider<LangProvider>(
          create: (context) => LangProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<ProductsProvider>(
            create: (context) => ProductsProvider()),
        ChangeNotifierProvider<FavoriteProvider>(
          create: (context) => FavoriteProvider(),
        ),
        ChangeNotifierProvider<AddProductProvider>(
            create: (context) => AddProductProvider()),
        ChangeNotifierProvider<SellerProvider>(
            create: (context) => SellerProvider()),
        ChangeNotifierProvider<TrxHistoryProvider>(
            create: (context) => TrxHistoryProvider()),
        ChangeNotifierProvider<GuestAccProvider>(
          create: (context) => GuestAccProvider()),
      ],
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
            SellerInfoView: (context) => SellerConfirm(),
            OTPScreen.route: (context) => OTPScreen('', '')
          },
          home: ListingScreen(),
          navigatorKey: navigationKey,
        ),
      ),
    );
  }
}
