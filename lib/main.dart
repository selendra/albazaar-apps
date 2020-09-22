import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/core/enums/connectivity_status.dart';
import 'package:selendra_marketplace_app/core/services/connectivity_services.dart';
import 'all_export.dart';
import 'core/providers/products_provider.dart';

final navigationKey = GlobalKey<NavigatorState>();
final sfKey = GlobalKey<ScaffoldState>();

void main() {
  // debugPaintSizeEnabled = true;
  runApp(SelendraApp());
}

class SelendraApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (context) => ConnectivityServices().streamController.stream,
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<ProductsProvider>(
            create: (context) => ProductsProvider()),
        ChangeNotifierProvider<FavoriteProvider>(
          create: (context) => FavoriteProvider(),
        ),
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider<ApiGetServices>(
          create: (context) => ApiGetServices(),
        ),
        ChangeNotifierProvider<ApiPostServices>(
          create: (context) => ApiPostServices(),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) => ScrollConfiguration(
          behavior: ScrollBehavior()
            ..buildViewportChrome(context, child, AxisDirection.down),
          child: child,
        ),
        initialRoute: '/',
        routes: {
          '/root': (context) => RootServices(),
          '/detail': (context) => DetailScreen(),
        },
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        navigatorKey: navigationKey,
      ),
    );
  }
}
