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

  static String getDataFromStream(StreamedResponse stream, AddProduct addProduct){
    String value;
    stream.stream.transform(utf8.decoder).listen((data){
      value = json.decode(data)['uri'];
    });
    // Wait 500 milliseconds For Add Data To Value Before Return
    Timer(Duration(milliseconds: 500), (){});
    return value;
  }

  static String removeZero(String number){
    if (number.startsWith("0")){
      number = number.replaceRange(0, 1, '');
    }
    return number;
  }

  static Future<void> clearStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
  
}