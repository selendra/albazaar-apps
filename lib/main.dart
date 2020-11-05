import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'all_export.dart';
import 'core/route/router.dart' as router;
import 'core/providers/auth_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/providers/user_provider.dart';

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
  @override
  Widget build(BuildContext context) {
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
      ],
      child: Consumer<LangProvider>(
        builder: (context, value, child) => MaterialApp(
          builder: (context, child) => ScrollConfiguration(
            behavior: ScrollBehavior()
              ..buildViewportChrome(context, child, AxisDirection.down),
            child: child,
          ),
          title: 'Selendra Marketplace',
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
          initialRoute: SplashScreenView,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            cursorColor: kDefaultColor,
            primaryColor: Colors.white,
            brightness: Brightness.light,
          ),
          routes: {DetailView: (context) => DetailScreen()},
          home: SplashScreen(),
          navigatorKey: navigationKey,
        ),
      ),
    );
  }
}
