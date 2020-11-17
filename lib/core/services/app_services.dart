import 'package:selendra_marketplace_app/all_export.dart';

class AppServices {
  
  static Color hexaCodeToColor(String hexaCode) {
    return Color(convertHexaColor(hexaCode));
  }

  static int convertHexaColor(String colorhexcode) { /* Convert Hexa Color */
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }
}