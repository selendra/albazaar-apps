import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/enums/connectivity_status.dart';
import 'package:selendra_marketplace_app/services/connectivity_services.dart';
import 'screens/splashscreen/splashscreen.dart';
import 'package:selendra_marketplace_app/services/auth/root_service.dart';
import 'providers/products_provider.dart';
import 'screens/detail/detail_screen.dart';
import 'models/products.dart';
import 'package:selendra_marketplace_app/providers/favorite_provider.dart';

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
        ChangeNotifierProvider<ProductsProvider>(
            create: (context) => ProductsProvider()),
        StreamProvider<ConnectivityStatus>(
          create: (context) => ConnectivityServices().streamController.stream,
        ),
        ChangeNotifierProvider<FavoriteProvider>(
          create: (context) => FavoriteProvider(),
        )
      ],
      child: MaterialApp(
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
