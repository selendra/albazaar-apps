import 'package:flutter/material.dart';

class DarkModeStyle {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme
        ? ThemeData.dark()
        : ThemeData(
            primaryColor: Colors.white,
            cardColor: Colors.white,
          );
  }
}

// ThemeData(
//             cursorColor: kDefaultColor,
//             primaryColor: Colors.white,
//             brightness: Brightness.light,
//           ),
