import 'dart:async';

import 'package:http/http.dart';
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

  static String getDataFromStream(StreamedResponse stream){
    String value;
    stream.stream.transform(utf8.decoder).listen((data){
      print(json.decode(data)['uri']);
      value = json.decode(data)['uri'];
    });
    // Wait 500 milliseconds For Add Data To Value Before Return
    Timer(Duration(milliseconds: 500), (){});
    return value;
  }
}