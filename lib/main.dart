import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/ui/screens/seller_confirmation/seller_confrmation.dart';
import 'all_export.dart';
import 'core/route/router.dart' as router;
import 'package:flutter_localizations/flutter_localizations.dart';

final navigationKey = GlobalKey<NavigatorState>();
final sfKey = GlobalKey<ScaffoldState>();

void main() {
  runApp(SelendraApp());
}

class SelendraApp extends StatefulWidget {
  @override
  _SelendraAppState createState() => _SelendraAppState();
}

class _SelendraAppState extends State<SelendraApp> {
  var dark = true;
  @override
  void initState() {
    super.initState();
  }

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
        ChangeNotifierProvider(
          create: (_) => DarkMode(),
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
      ],
      child: Consumer<LangProvider>(builder: (context, value, child) {
        var data = Provider.of<DarkMode>(context).isDarkMode;
        return MaterialApp(
          // ResponsiveWrapper.builder(
          //   child
          // ,
          //   maxWidth: 1200,
          //   minWidth: 480,
          //   defaultScale: true,
          //   breakpoints: [
          //     ResponsiveBreakpoint.resize(480, name: MOBILE),
          //     ResponsiveBreakpoint.autoScale(800, name: TABLET),
          //     ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          //   ],
          //   background: Container(color: Color(0xFFF5F5F5))
          // ),
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

          // debugShowCheckedModeBanner: true,
          theme: ThemeData(
            primaryColor: Colors.white,
            cardColor: Colors.white,
          ),
          darkTheme: ThemeData.dark(),
          themeMode: data ? ThemeMode.dark : ThemeMode.light,

          onGenerateRoute: router.generateRoute,
          initialRoute: SignInView,

          routes: {
            DetailView: (context) => DetailScreen(),
            SellerInfoView: (context) => SellerConfirm(),
          },
          home: SignIn(), //SplashScreen(),
          navigatorKey: navigationKey,
        );
      }),
    );
  }
}
