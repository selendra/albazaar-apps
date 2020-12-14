import 'package:flutter/material.dart';

class DarkModeStyle {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      cardColor: isDarkTheme ? Colors.black : Colors.white,
    );
  }
}

// ThemeData(
//             cursorColor: kDefaultColor,
//             primaryColor: Colors.white,
//             brightness: Brightness.light,
//           ),
