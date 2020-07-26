import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:selendra_marketplace_app/enums/connectivity_status.dart';
import 'package:selendra_marketplace_app/services/connectivity_services.dart';
import 'screens/splashscreen/splashscreen.dart';



void main() {
  debugPaintSizeEnabled = true;
  runApp(SelendraApp());
}

class SelendraApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      create: (context) => ConnectivityServices().streamController.stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        home: SplashScreen(),
      ),
    );
  }
}


